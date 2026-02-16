# On-Action Patterns

## Extend an existing AGOT relation hook

```txt
on_set_relation_agot_dragon = {
	on_actions = {
		starfyre_on_set_relation_agot_dragon
	}
}

starfyre_on_set_relation_agot_dragon = {
	trigger = {
		is_human = yes
		any_memory = { memory_type = agot_hatched_egg }
	}
	effect = {
		trigger_event = { id = starfyre_dreams.1100 days = 1 }
	}
}
```

## Game start injection

```txt
on_game_start = {
	on_actions = {
		my_submod_on_game_start
	}
}
```

## Notes

- Prefer custom sub-action names (for example `my_submod_on_*`) to keep ownership clear.
- Keep trigger gating strict to avoid noisy fire across unrelated characters.
- Delay wrapper events by `days = 1` when piggybacking on heavy AGOT effects.
