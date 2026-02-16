# Localization Patterns

## Core rules

- Use UTF-8 with BOM for CK3 localization files.
- Keep all Starfyre keys in `starfyre_mod/localization/english/99_starfyre_l_english.yml`.
- Prefer dot-notation for event keys.
  - `namespace.id.t`
  - `namespace.id.desc`
  - `namespace.id.a`
  - `namespace.id.a.tt`

## Common key families

- Events:
  - `starfyre_dreams.0001.t`
  - `starfyre_dreams.0001.desc`
  - `starfyre_dreams.0001.a`
  - `starfyre_dreams.0001.a.tt`
- Decisions:
  - `<decision_key>`
  - `<decision_key>_desc`
  - `<decision_key>_tooltip`
  - `<decision_key>_confirm`
- Modifiers:
  - `<modifier_key>`
  - `<modifier_key>_desc`
- Traits:
  - `trait_<trait_key>`
  - `trait_<trait_key>_desc`

## Text structure conventions

- Use `\n\n` for paragraph breaks in long descriptions.
- Keep option text concise; put detailed consequence language in tooltip keys.
- For conditional descriptions, include separate loc keys for each `triggered_desc`.
  - Example: `starfyre_dreams.0002.desc.married`

## High-frequency failure modes

- Missing key in localization file.
  - Symptom: raw key string appears in game UI.
- Typo mismatch between script key and localization key.
  - Symptom: only one option/title/tooltip fails while others render.
- No BOM / inconsistent encoding.
  - Symptom: parsing/localization oddities in CK3 logs.

## Quick validation commands

```bash
# One-command validation
scripts/preflight.sh --no-hook

# Check specific key usage in scripts
rg -n "starfyre_dreams\\.[0-9]{4}\\.(t|desc|a|b|c|a\\.tt|b\\.tt|c\\.tt)" starfyre_mod/events

# Check keys present in localization
rg -n "^\\s*starfyre_dreams\\." starfyre_mod/localization/english/99_starfyre_l_english.yml
```
