# File Index (AGOT + Starfyre)

## Project docs

- `docs/lessons-learned.md`
  - Append-only operational memory for mistakes, quirks, and confirmed fixes.
- `docs/troubleshooting.md`
  - Fast triage path for CK3/AGOT script and localization issues.
- `docs/flows/starfyre-state-map.md`
  - Event/flag flow map for Starfyre branching logic.

## Project tooling

- `scripts/preflight.sh`
  - One-command preflight for AGOT hook lookup, loc coverage, brace balance, merge markers, and BOM checks.

## AGOT source files used often

- `common/on_action/agot_on_actions/relations/agot_dragon_relation_on_actions.txt`
  - Contains `on_set_relation_agot_dragon` (dragon bond relation hook).
- `common/scripted_effects/00_agot_dragon_spawning_effects.txt`
  - Contains `agot_spawn_bonded_hatchling_from_egg_effect`.
- `common/scripted_effects/00_agot_dragon_effects.txt`
  - Contains `agot_bond_dragon_relation_effect` and `set_relation_agot_dragon`.
- `events/activities/agot_hatching_activity/agot_dragon_hatching_activity_events.txt`
  - Hatching success events (`agot_dragon_hatching.0401` host success flow).
- `common/character_memory_types/agot_character_memories.txt`
  - Defines memory type `agot_hatched_egg`.
- `common/scripted_modifiers/00_agot_dragon_scripted_modifiers.txt`
  - Dragon hatching weight logic, including `var:dragonlore`.
- `common/script_values/00_agot_activity_values.txt`
  - Activity-level contribution from `dragonlore`.
- `common/activities/activity_types/agot_dragon_hatching.txt`
  - Hatching activity constraints and weight checks.

## Starfyre submod files (current)

- `starfyre_mod/common/on_action/99_starfyre_on_actions.txt`
- `starfyre_mod/common/decisions/99_starfyre_decisions.txt`
- `starfyre_mod/common/modifiers/99_starfyre_modifiers.txt`
- `starfyre_mod/events/99_starfyre_startup_events.txt`
- `starfyre_mod/events/99_starfyre_dream_events.txt`
- `starfyre_mod/localization/english/99_starfyre_l_english.yml`

## Pattern docs

- `docs/patterns/on-actions.md`
- `docs/patterns/effects.md`
- `docs/patterns/decisions.md`
- `docs/patterns/events.md`
- `docs/patterns/localization.md`
