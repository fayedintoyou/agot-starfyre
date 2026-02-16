# Integration Points

## Dragon hatch payoff hook (recommended)

Hook:

- AGOT relation on_action: `on_set_relation_agot_dragon`
- AGOT source: `common/on_action/agot_on_actions/relations/agot_dragon_relation_on_actions.txt`

Why this hook:

- It runs when rider-dragon relation is created.
- Hatching success path calls relation setup after spawning hatchling.
- It is stable for "post-hatch payoff wrapper" events.

Safe submod pattern:

```txt
on_set_relation_agot_dragon = {
	on_actions = {
		my_submod_on_set_relation_agot_dragon
	}
}

my_submod_on_set_relation_agot_dragon = {
	trigger = {
		is_human = yes
		any_memory = { memory_type = agot_hatched_egg }
	}
	effect = {
		trigger_event = { id = my_submod.1000 days = 1 }
	}
}
```

## Hatching success chain linkage

Source path:

- `events/activities/agot_hatching_activity/agot_dragon_hatching_activity_events.txt`
  - Success event `agot_dragon_hatching.0401` calls `agot_spawn_bonded_hatchling_from_egg_effect`.
- `common/scripted_effects/00_agot_dragon_spawning_effects.txt`
  - `agot_spawn_bonded_hatchling_from_egg_effect` creates memory `agot_hatched_egg`, then bonds dragon.

Use for submods:

- Check `any_memory = { memory_type = agot_hatched_egg }` to gate one-time hatch payoff content.

## Dragonlore integration

`dragonlore` is consumed by AGOT hatching math.

Reference files:

- `common/scripted_modifiers/00_agot_dragon_scripted_modifiers.txt`
- `common/script_values/00_agot_activity_values.txt`

Submod effect pattern:

```txt
change_variable = {
	name = dragonlore
	add = 2
}
```

## On_action merge behavior reminder

AGOT defines some top-level on_actions in multiple files (for example `on_game_start`).
Submods can append via `on_actions = { ... }` blocks without replacing AGOT behavior.
