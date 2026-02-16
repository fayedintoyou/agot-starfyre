#!/usr/bin/env bash
set -euo pipefail

BASE_DEFAULT="/mnt/c/Program Files (x86)/Steam/steamapps/workshop/content/1158310/2962333032"
HOOK_DEFAULT="on_set_relation_agot_dragon|agot_spawn_bonded_hatchling_from_egg_effect|dragonlore"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
STARMOD_DIR="${ROOT_DIR}/starfyre_mod"
LOC_FILE="${STARMOD_DIR}/localization/english/99_starfyre_l_english.yml"

BASE_PATH="${BASE_DEFAULT}"
HOOK_PATTERN="${HOOK_DEFAULT}"
RUN_HOOK_CHECK=1

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

usage() {
  cat <<'EOF'
Usage:
  scripts/preflight.sh [options]

Options:
  --hook <pattern>      AGOT search pattern for integration-point verification.
  --base <path>         Override AGOT base path.
  --no-hook             Skip AGOT source hook search.
  -h, --help            Show this help.

Examples:
  scripts/preflight.sh
  scripts/preflight.sh --hook "on_set_relation_agot_dragon"
  scripts/preflight.sh --no-hook
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --hook)
      if [[ $# -lt 2 ]]; then
        echo "[FAIL] --hook requires a pattern" >&2
        exit 2
      fi
      HOOK_PATTERN="$2"
      shift 2
      ;;
    --base)
      if [[ $# -lt 2 ]]; then
        echo "[FAIL] --base requires a path" >&2
        exit 2
      fi
      BASE_PATH="$2"
      shift 2
      ;;
    --no-hook)
      RUN_HOOK_CHECK=0
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "[FAIL] Unknown option: $1" >&2
      usage
      exit 2
      ;;
  esac
done

for cmd in rg awk sed sort comm find xxd; do
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "[FAIL] Missing required command: ${cmd}" >&2
    exit 2
  fi
done

if [[ ! -d "${STARMOD_DIR}" ]]; then
  echo "[FAIL] Missing submod directory: ${STARMOD_DIR}" >&2
  exit 2
fi

if [[ ! -f "${LOC_FILE}" ]]; then
  echo "[FAIL] Missing localization file: ${LOC_FILE}" >&2
  exit 2
fi

FAILED=0

fail_check() {
  FAILED=1
  echo "[FAIL] $1"
}

pass_check() {
  echo "[PASS] $1"
}

echo "== CK3 AGOT Submod Preflight =="
echo "Root: ${ROOT_DIR}"
echo "Submod: ${STARMOD_DIR}"
echo

if [[ "${RUN_HOOK_CHECK}" -eq 1 ]]; then
  if [[ ! -d "${BASE_PATH}" ]]; then
    fail_check "AGOT base path not found: ${BASE_PATH}"
  else
    HOOK_OUT="${TMP_DIR}/hook_hits.txt"
    if rg -n "${HOOK_PATTERN}" "${BASE_PATH}/common" "${BASE_PATH}/events" >"${HOOK_OUT}" 2>/dev/null; then
      pass_check "AGOT hook/effect search found matches for pattern: ${HOOK_PATTERN}"
      sed -n '1,10p' "${HOOK_OUT}" | sed 's/^/  - /'
    else
      fail_check "No AGOT hook/effect matches for pattern: ${HOOK_PATTERN}"
    fi
  fi
else
  echo "[SKIP] Hook search skipped (--no-hook)"
fi
echo

NEEDED_KEYS="${TMP_DIR}/needed_keys.txt"
LOC_KEYS="${TMP_DIR}/loc_keys.txt"
MISSING_KEYS="${TMP_DIR}/missing_keys.txt"

rg -No --pcre2 '\b(title|desc|name|custom_tooltip)\s*=\s*[A-Za-z0-9_.]+' \
  "${STARMOD_DIR}/events" "${STARMOD_DIR}/common/decisions" 2>/dev/null \
  | sed -E 's/.*=\s*//' \
  | grep -E '(\.|_decision$|_modifier$|^dynn_Starfyre$|^house_Starfyre$|^trait_starfyre_)' \
  | sort -u > "${NEEDED_KEYS}" || true

rg -No --pcre2 '^\s*[A-Za-z0-9_.]+:\s*"' "${LOC_FILE}" \
  | sed -E 's/^\s*([A-Za-z0-9_.]+):.*/\1/' \
  | sort -u > "${LOC_KEYS}"

comm -23 "${NEEDED_KEYS}" "${LOC_KEYS}" > "${MISSING_KEYS}" || true

if [[ -s "${MISSING_KEYS}" ]]; then
  fail_check "Missing localization keys"
  sed 's/^/  - /' "${MISSING_KEYS}"
else
  pass_check "Localization key coverage is complete for referenced Starfyre keys"
fi
echo

BRACE_FAILS="${TMP_DIR}/brace_fails.txt"
: > "${BRACE_FAILS}"

while IFS= read -r file; do
  BALANCE="$(awk '
    BEGIN { c = 0 }
    {
      line = $0
      sub(/#.*/, "", line)
      for (i = 1; i <= length(line); i++) {
        ch = substr(line, i, 1)
        if (ch == "{") c++
        else if (ch == "}") c--
      }
    }
    END { print c }
  ' "${file}")"
  if [[ "${BALANCE}" != "0" ]]; then
    echo "${file} (balance=${BALANCE})" >> "${BRACE_FAILS}"
  fi
done < <(find "${STARMOD_DIR}" -type f -name '*.txt' | sort)

if [[ -s "${BRACE_FAILS}" ]]; then
  fail_check "Brace-balance check failed"
  sed 's/^/  - /' "${BRACE_FAILS}"
else
  pass_check "Brace-balance check passed on Starfyre .txt files"
fi
echo

MARKERS_OUT="${TMP_DIR}/merge_markers.txt"
if rg -n '^(<<<<<<<|=======|>>>>>>>)' "${STARMOD_DIR}" "${ROOT_DIR}/docs" > "${MARKERS_OUT}" 2>/dev/null; then
  fail_check "Merge markers found"
  sed -n '1,20p' "${MARKERS_OUT}" | sed 's/^/  - /'
else
  pass_check "No merge markers found"
fi
echo

BOM_FAILS="${TMP_DIR}/bom_fails.txt"
: > "${BOM_FAILS}"

while IFS= read -r file; do
  SIG="$(xxd -p -l 3 "${file}")"
  if [[ "${SIG}" != "efbbbf" ]]; then
    echo "${file}" >> "${BOM_FAILS}"
  fi
done < <(find "${STARMOD_DIR}" -type f \( -name '*.txt' -o -name '*.yml' \) | sort)

if [[ -s "${BOM_FAILS}" ]]; then
  fail_check "UTF-8 BOM check failed"
  sed 's/^/  - /' "${BOM_FAILS}"
else
  pass_check "UTF-8 BOM check passed on Starfyre .txt/.yml files"
fi
echo

if [[ "${FAILED}" -ne 0 ]]; then
  echo "Preflight: FAILED"
  exit 1
fi

echo "Preflight: PASSED"
