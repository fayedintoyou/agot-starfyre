# Lessons Learned

Use this file as an append-only log. Add short entries while working, not at the end of a session.

## Entry Template

```md
### YYYY-MM-DD - [Area] Short Title
- Symptom:
- Cause:
- Fix:
- References:
  - relative/path/to/file.txt:line
  - relative/path/to/other_file.txt:line
```

## Pre-Flight Checklist (Run Before Coding)

1. Run the one-command check.
   - `scripts/preflight.sh`
2. For new systems/hooks, target the AGOT search explicitly.
   - `scripts/preflight.sh --hook "target_hook_or_effect"`
3. Read the relevant guardrails before editing.
   - `docs/integration-points.md`
   - `docs/patterns/*.md` (only relevant file)
4. If preflight fails, fix failures before adding new code.
5. Append new quirks/errors/fixes to this file immediately.

## Entries

### 2026-02-16 - [AGOT Hook] Reliable post-hatch wrapper point
- Symptom: Needed a custom event to fire after successful dragon hatch, without editing AGOT hatching mechanics directly.
- Cause: Generic pulses are too broad and do not represent "just hatched now" cleanly.
- Fix: Extend `on_set_relation_agot_dragon`, then gate with `any_memory = { memory_type = agot_hatched_egg }` and one-time character flags.
- References:
  - `common/on_action/agot_on_actions/relations/agot_dragon_relation_on_actions.txt:45`
  - `common/scripted_effects/00_agot_dragon_spawning_effects.txt:103`
  - `starfyre_mod/common/on_action/99_starfyre_on_actions.txt:8`

### 2026-02-16 - [AGOT Flow] Hatching success order matters
- Symptom: Needed confidence that relation hook truly maps to successful hatching.
- Cause: If relation can be set in other contexts, payoff event could misfire.
- Fix: Follow AGOT success chain: success event -> `agot_spawn_bonded_hatchling_from_egg_effect` -> create memory `agot_hatched_egg` -> bond relation. Keep memory check in trigger.
- References:
  - `events/activities/agot_hatching_activity/agot_dragon_hatching_activity_events.txt:4375`
  - `common/scripted_effects/00_agot_dragon_spawning_effects.txt:100`
  - `common/scripted_effects/00_agot_dragon_spawning_effects.txt:110`

### 2026-02-16 - [Balance Lever] `dragonlore` is a first-class hatching weight input
- Symptom: Needed dream/decision rewards that impact gameplay beyond prestige/stress.
- Cause: Static rewards did not materially affect AGOT hatching outcomes.
- Fix: Award `change_variable = { name = dragonlore add = X }` through events/decisions to influence AGOT hatching probabilities.
- References:
  - `common/scripted_modifiers/00_agot_dragon_scripted_modifiers.txt:314`
  - `common/script_values/00_agot_activity_values.txt:45`
  - `starfyre_mod/events/99_starfyre_dream_events.txt:294`

### 2026-02-16 - [CK3 Script] Use `add_prowess_skill`, not `add_prowess`
- Symptom: Character skill adjustment keyword mismatch risk in custom events.
- Cause: `add_prowess` is not the correct effect key in this context.
- Fix: Use `add_prowess_skill = 1` for character prowess changes.
- References:
  - `starfyre_mod/events/99_starfyre_dream_events.txt:358`

### 2026-02-16 - [Localization/Parsing] Keep UTF-8 BOM on CK3 txt/yml files
- Symptom: CK3 parsing/localization issues can appear when encoding is inconsistent across script and loc files.
- Cause: CK3 content frequently expects BOM-bearing UTF-8 files, especially localization.
- Fix: Save modified `.txt` and `.yml` as UTF-8 with BOM (`utf-8-sig`) consistently.
- References:
  - `starfyre_mod/localization/english/99_starfyre_l_english.yml:1`
