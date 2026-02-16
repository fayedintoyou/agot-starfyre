# Troubleshooting

## Error log location

Windows install path (from WSL):

```txt
/mnt/c/Users/<YOUR_USER>/Documents/Paradox Interactive/Crusader Kings III/logs/error.log
```

## Fast triage workflow

```bash
# 1) Run preflight first
scripts/preflight.sh

# 2) Inspect newest errors
tail -n 200 "/mnt/c/Users/<YOUR_USER>/Documents/Paradox Interactive/Crusader Kings III/logs/error.log"

# 3) Filter to submod/system
rg -n "starfyre|dragonlore|on_set_relation_agot_dragon" "/mnt/c/Users/<YOUR_USER>/Documents/Paradox Interactive/Crusader Kings III/logs/error.log"
```

## Common issues and fixes

### Raw loc key appears in UI
- Likely cause: missing/typo localization key.
- Fix:
  - confirm key in script (`title/desc/name/custom_tooltip`)
  - add matching key in `99_starfyre_l_english.yml`
  - rerun `scripts/preflight.sh --no-hook`

### Event/decision never appears
- Likely cause:
  - `is_shown`/`is_valid` gate not met
  - missing prerequisite flags
  - chain event never scheduled
- Fix:
  - inspect trigger blocks and required flags
  - verify scheduling in `hidden_effect` `trigger_event`
  - check flow map in `docs/flows/starfyre-state-map.md`

### On-action logic not firing
- Likely cause:
  - wrong hook name
  - trigger too strict
  - expected memory/flag not present
- Fix:
  - verify hook exists in AGOT source
  - validate trigger state assumptions against chain order
  - use `any_memory = { memory_type = agot_hatched_egg }` for post-hatch gating

### Script parse errors
- Likely cause:
  - brace mismatch
  - invalid effect key
  - merge markers left in file
- Fix:
  - run `scripts/preflight.sh`
  - replace invalid keys (example: use `add_prowess_skill`, not `add_prowess`)

### Encoding/localization oddities
- Likely cause: missing UTF-8 BOM on CK3 txt/yml file.
- Fix:
  - ensure file starts with `efbbbf` (`xxd -p -l 3 <file>`)
  - save as UTF-8 BOM (`utf-8-sig`)

## Escalation rule

If the same error appears twice, add an entry to `docs/lessons-learned.md` with:
- symptom
- cause
- fix
- file:line references
