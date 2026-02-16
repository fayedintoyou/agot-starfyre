# Starfyre State Map

Purpose: keep chain edits safe by showing event flow and flag dependencies.

## Entry flow

```txt
startup.0001 (hidden cache at Starfall)
  A) Found Starfyre:
     - set_house = house_Starfyre
     - add flag: starfyre_house_founded
     - add trait: dragon_dreams
     - schedule dreams.0001

  B) Stay Dayne:
     - add trait: starfyre_hidden_legacy
     - add flag: starfyre_stayed_dayne
     - schedule dreams.2001
```

## Post-8251 descendant scaffold (history-only)

```txt
8251.1.1
  - landless camp holder: Starfyre_1 (Viserra)

8252.1.1
  - move Starfyre camp to Lys (title history move effect)
  - move Viserra location to c_lys

8253.1.1
  - Viserra matrilineally marries Starfyre_8 (dynn_Rogare, lyseni)

8254.6.1
  - Starfyre_9 (Vaella) is born (dynn_Dayne)

8257.2.1
  - Starfyre_10 (Daemon) is born (dynn_Dayne)

8276.1.1
  - landless camp holder handoff: Starfyre_9
```

Bookmark coverage intent:

- Keeps one Starfyre-line landless playable in each post-Ninepenny AGOT bookmark:
  - `8277` (Defiance of Duskendale)
  - `8282` (Robert's Rebellion)
  - `8284` (The Crowned Stag)

Interaction with cache gate:

- Descendants remain valid for cache discovery because trigger checks:
  - direct flag `starfyre_is_viserra` OR `any_ancestor` with that flag
- Cache stays globally one-time through `starfyre_cache_discovered`

## Dream chain (Starfyre route)

```txt
0001 -> 0002 -> 0003
               |
               +-- 0003.a (restraint): set starfyre_path_restraint -> 0004 -> 0005
               |
               +-- 0003.b (bold): set starfyre_path_bold -> 0006 -> 0007
```

Option -> flag mapping (important for downstream gates):

- `0003.a` sets `starfyre_path_restraint`
- `0003.b` sets `starfyre_path_bold`
- `0006.a` sets `starfyre_step_into_fire_unlocked`
- `0006.b` sets `starfyre_step_into_fire_unlocked`
- `0005.a` sets `starfyre_hatching_intent_set` + `starfyre_hatching_intent_cautious`
- `0007.a` sets `starfyre_hatching_intent_set` + `starfyre_hatching_intent_bold` (+ keeps fire unlocked)
- `0007.b` sets `starfyre_hatching_intent_set` (no bold/cautious subflag)
- `0007.c` sets no intent flags

Core seen flags:

- `starfyre_dream_1_seen`
- `starfyre_dream_2_seen`
- `starfyre_dream_3_seen`
- `starfyre_dream_4_seen`
- `starfyre_dream_5_seen`

Path/intent flags:

- `starfyre_path_restraint`
- `starfyre_path_bold`
- `starfyre_hatching_intent_set`
- `starfyre_hatching_intent_cautious`
- `starfyre_hatching_intent_bold`
- `starfyre_step_into_fire_unlocked`
- `starfyre_step_into_fire_done`

## Hidden legacy chain (Dayne route)

```txt
2001 -> 2002 -> 2003
                 |
                 +-- 2003.a stay Dayne shadow path
                 +-- 2003.b reveal Starfyre:
                     - trigger requires: `starfyre_dayne_ambition` OR `starfyre_dayne_rumor_suppressed`
                     - remove trait: starfyre_hidden_legacy
                     - set_house = house_Starfyre
                     - add flags: starfyre_revealed_from_dayne, starfyre_house_founded
                     - add trait: dragon_dreams
                     - schedule dreams.0001
```

Option -> flag mapping:

- `2001.a` sets `starfyre_dayne_secrecy`
- `2001.b` sets `starfyre_dayne_ambition`
- `2002.a` sets `starfyre_dayne_rumor_quieted`
- `2002.b` sets `starfyre_dayne_rumor_suppressed`
- `2003.b` requires `starfyre_dayne_ambition` OR `starfyre_dayne_rumor_suppressed`

Hidden legacy flags:

- `starfyre_dayne_chain_1_seen`
- `starfyre_dayne_chain_2_seen`
- `starfyre_dayne_chain_3_seen`
- `starfyre_dayne_secrecy`
- `starfyre_dayne_ambition`
- `starfyre_dayne_rumor_quieted`
- `starfyre_dayne_rumor_suppressed`

## Dragonstone and fire overlays

- Dragonstone pilgrimage decision -> `dreams.1001`
  - implemented in: `starfyre_mod/common/decisions/99_starfyre_decisions.txt`
  - shown: `starfyre_house_founded` and not `starfyre_dragonstone_visited`
  - valid: at `b_dragonstone`, at peace, `gold >= 75`, and (`diplomacy >= 8` OR `learning >= 8` OR `starfyre_path_bold`)
  - effect: sets `starfyre_dragonstone_visited` in event `1001` immediate
- Step Into Fire decision -> `dreams.1002`
  - implemented in: `starfyre_mod/common/decisions/99_starfyre_decisions.txt`
  - shown: `starfyre_house_founded`, `starfyre_step_into_fire_unlocked`, not `starfyre_step_into_fire_done`
  - valid: at peace, location is `b_dragonstone` OR `c_starfall`
  - event `1002` additionally checks: `starfyre_step_into_fire_unlocked` and not `starfyre_step_into_fire_done`
  - `1001.c` (survive branches) can also unlock this path, even on restraint route

## `dragonlore` variable (base AGOT variable)

Status:

- This is the AGOT-native character variable `var:dragonlore` (not a Starfyre-only variable).
- Starfyre events add to it via `change_variable`.

Consumed by AGOT:

- `common/script_values/00_agot_activity_values.txt` (adds host `dragonlore` to hatch success math; can count again with knowledge option)
- `common/scripted_modifiers/00_agot_dragon_scripted_modifiers.txt` (tiered hatching modifiers by `var:dragonlore`)
- `common/activities/activity_types/agot_dragon_hatching.txt` (activity checks keyed off `var:dragonlore`)

Where Starfyre adds it:

- Dream chain: `0002`, `0003`, `0004/0006`, `0005/0007`
- Dragonstone event: `1001`
- Fire ritual event: `1002` (survival outcomes)

Approximate ranges (current implementation):

- Core restraint route (`0002`-`0005`): `~5-10`
- Core bold route (`0002`-`0007`): `~10-19`
- Add Dragonstone (`1001`): `+2/+4` safe options or `+6/+12` on surviving risky branch
- Add Step Into Fire (`1002`): `+10/+18` on surviving branches
- Dayne -> reveal route: no `dragonlore` gain in `2001-2003`; once revealed, same ceiling as normal dream chain but starts later in life

Potential integration risks:

- Balance coupling: AGOT updates to hatch formulas can change Starfyre outcomes without submod code changes.
- Stack coupling: other AGOT systems also alter `dragonlore`, so total values are not Starfyre-only.
- No built-in decay in Starfyre logic: values persist once accumulated.

## Modifiers and traits used by this flow

Modifiers referenced in events:

- `starfyre_patient_dragonkeeper_modifier`
- `starfyre_fire_in_the_blood_modifier`
- `starfyre_hidden_legacy_guarded_modifier`
- `starfyre_shadow_dragon_modifier`
- `starfyre_dragonstone_firekissed_modifier`

Defined in:

- `starfyre_mod/common/modifiers/99_starfyre_modifiers.txt`

Trait provenance:

- Custom in submod:
  - `starfyre_hidden_legacy` (defined in `starfyre_mod/common/traits/99_starfyre_traits.txt`)
- From AGOT base mod:
  - `dragon_dreams` (defined in `common/traits/00_agot_traits.txt`)

## Reveal path text behavior

Current behavior:

- After `2003.b` reveal, dreams `0001-0007` use the same text/logic as direct Starfyre founders.
- No dream text currently keys off `starfyre_revealed_from_dayne`.

Design note:

- This is currently intentional simplification, but can be expanded later with reveal-specific `triggered_desc` blocks if desired.

## Hatching payoff wrapper

Trigger source:

- AGOT relation hook `on_set_relation_agot_dragon`.
- Requires memory `agot_hatched_egg`.

Starfyre gate:

- Has one of:
  - `starfyre_house_founded`
  - `starfyre_revealed_from_dayne`
- Has `starfyre_hatching_intent_set`
- Lacks `starfyre_hatching_payoff_done`

Payoff event:

- `starfyre_dreams.1100`
- Sets `starfyre_hatching_payoff_done`
