#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

MOD_FILE="starfyre.mod"
MOD_DIR="starfyre_mod"
DEFAULT_OUT="${ROOT_DIR}/dist/starfyre_bundle.zip"

OUTPUT_PATH="${DEFAULT_OUT}"
FORCE=0

usage() {
  cat <<'EOF'
Usage:
  scripts/package_mod_zip.sh [options]

Options:
  -o, --output <path>  Output .zip path (default: dist/starfyre_bundle.zip)
  -f, --force          Overwrite output file if it already exists
  -h, --help           Show this help

Examples:
  scripts/package_mod_zip.sh
  scripts/package_mod_zip.sh --output /tmp/starfyre_bundle.zip
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -o|--output)
      if [[ $# -lt 2 ]]; then
        echo "[FAIL] --output requires a path" >&2
        exit 2
      fi
      OUTPUT_PATH="$2"
      shift 2
      ;;
    -f|--force)
      FORCE=1
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

if [[ ! -f "${ROOT_DIR}/${MOD_FILE}" ]]; then
  echo "[FAIL] Missing required file: ${ROOT_DIR}/${MOD_FILE}" >&2
  exit 2
fi

if [[ ! -d "${ROOT_DIR}/${MOD_DIR}" ]]; then
  echo "[FAIL] Missing required directory: ${ROOT_DIR}/${MOD_DIR}" >&2
  exit 2
fi

if [[ "${OUTPUT_PATH}" = /* ]]; then
  OUTPUT_ABS="${OUTPUT_PATH}"
else
  OUTPUT_ABS="${ROOT_DIR}/${OUTPUT_PATH}"
fi

OUT_DIR="$(dirname "${OUTPUT_ABS}")"
mkdir -p "${OUT_DIR}"

if [[ -e "${OUTPUT_ABS}" && "${FORCE}" -ne 1 ]]; then
  echo "[FAIL] Output already exists: ${OUTPUT_ABS}" >&2
  echo "Use --force to overwrite." >&2
  exit 2
fi

if [[ "${FORCE}" -eq 1 && -e "${OUTPUT_ABS}" ]]; then
  rm -f "${OUTPUT_ABS}"
fi

METHOD=""
if command -v zip >/dev/null 2>&1; then
  METHOD="zip"
  (
    cd "${ROOT_DIR}"
    zip -r -q "${OUTPUT_ABS}" "${MOD_FILE}" "${MOD_DIR}"
  )
elif command -v python3 >/dev/null 2>&1; then
  METHOD="python3_zipfile"
  python3 - "${ROOT_DIR}" "${OUTPUT_ABS}" "${MOD_FILE}" "${MOD_DIR}" <<'PY'
import os
import sys
import zipfile

root_dir, output_zip, mod_file, mod_dir = sys.argv[1:5]

def write_path(zf, base, rel):
    full = os.path.join(base, rel)
    if os.path.isfile(full):
        zf.write(full, arcname=rel)
        return
    for dirpath, _, filenames in os.walk(full):
        for fn in filenames:
            fp = os.path.join(dirpath, fn)
            arc = os.path.relpath(fp, base)
            zf.write(fp, arcname=arc)

with zipfile.ZipFile(output_zip, "w", compression=zipfile.ZIP_DEFLATED) as zf:
    write_path(zf, root_dir, mod_file)
    write_path(zf, root_dir, mod_dir)
PY
else
  echo "[FAIL] Neither 'zip' nor 'python3' is available to create a zip archive." >&2
  exit 2
fi

if [[ ! -s "${OUTPUT_ABS}" ]]; then
  echo "[FAIL] Archive creation failed: ${OUTPUT_ABS}" >&2
  exit 1
fi

echo "[PASS] Created archive: ${OUTPUT_ABS}"
echo "[INFO] Method: ${METHOD}"
echo "[INFO] Included: ${MOD_FILE} and ${MOD_DIR}/"
