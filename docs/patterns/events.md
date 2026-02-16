# Event Patterns

## Branch chain with explicit path flags

```txt
option = {
	name = my_chain.0003.a
	add_character_flag = my_path_restraint
	hidden_effect = {
		trigger_event = { id = my_chain.0004 days = { 300 450 } }
	}
}

option = {
	name = my_chain.0003.b
	add_character_flag = my_path_bold
	hidden_effect = {
		trigger_event = { id = my_chain.0006 days = { 300 450 } }
	}
}
```

## Responsive text with `triggered_desc`

```txt
desc = {
	desc = my_chain.0002.desc
	triggered_desc = {
		trigger = { is_at_war = yes }
		desc = my_chain.0002.desc.war
	}
	triggered_desc = {
		trigger = { is_married = yes }
		desc = my_chain.0002.desc.married
	}
}
```

## React to egg possession state

```txt
trigger = {
	any_character_artifact = {
		has_variable = dragon_egg
	}
}
```

## Post-hatch payoff gate

```txt
trigger = {
	has_character_flag = my_hatching_intent_set
	NOT = { has_character_flag = my_hatching_payoff_done }
	any_memory = { memory_type = agot_hatched_egg }
}
```

## Event hygiene

- Use `hidden_effect` for chain scheduling.
- Set one-time seen flags in `immediate`.
- Keep event themes to valid CK3 themes (for example `intrigue`, `realm`, `diplomacy`).
