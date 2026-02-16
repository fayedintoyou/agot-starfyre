# AGOT Source Structure (WSL)

Base AGOT path:

```bash
/mnt/c/Program Files (x86)/Steam/steamapps/workshop/content/1158310/2962333032
```

High-value directories for submod work:

- `common/on_action/` - hook entry points and pulse wiring
- `common/scripted_effects/` - reusable AGOT effects (dragon spawn, bond, etc.)
- `common/scripted_modifiers/` - weight formulas and state-driven modifiers
- `common/activities/activity_types/` - activity setup and outcome flow
- `common/character_memory_types/` - memory IDs used by events/on_actions
- `events/activities/` - activity event chains (hatching outcomes, etc.)
- `localization/english/` - canonical key style and wording patterns

Quick search workflow:

```bash
BASE="/mnt/c/Program Files (x86)/Steam/steamapps/workshop/content/1158310/2962333032"

# Find a hook/effect quickly
rg -n "on_set_relation_agot_dragon|agot_spawn_bonded_hatchling_from_egg_effect" "$BASE"

# Find where a variable is consumed
rg -n "\bdragonlore\b" "$BASE/common"
```
