# Effect Patterns

## Raise AGOT hatching odds via dragonlore

```txt
change_variable = {
	name = dragonlore
	add = 3
}
```

## One-time path flags

```txt
add_character_flag = my_path_bold
remove_character_flag = my_path_restraint
```

## Apply timed character modifiers

```txt
add_character_modifier = {
	modifier = my_custom_modifier
	years = 10
}
```

## Risk-reward branching with `random_list`

```txt
random_list = {
	20 = { death = { death_reason = death_fire } }
	40 = { add_trait = wounded_2 }
	40 = { add_prestige = 300 }
}
```

## Delayed chain continuation (hidden)

```txt
hidden_effect = {
	trigger_event = {
		id = my_namespace.2001
		days = { 120 240 }
	}
}
```
