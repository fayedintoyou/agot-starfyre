# Decision Patterns

## Show vs valid separation

Use `is_shown` for UI visibility and `is_valid` for selectable state.

```txt
my_decision = {
	is_shown = {
		has_character_flag = my_chain_started
	}
	is_valid = {
		is_at_war = no
		gold >= 75
		location.barony = title:b_dragonstone
	}
	effect = {
		trigger_event = my_namespace.1001
	}
	cost = { gold = 75 }
	ai_check_interval = 0
}
```

## Location checks used in AGOT submods

- `location.barony = title:b_<barony>`
- `location.county = title:c_<county>`

## Notes

- Put hard blockers in `is_valid` (war state, gold, stats).
- Keep event payload in event files; decisions should only gate/launch.
