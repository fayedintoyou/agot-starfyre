# House Starfyre — CK3 AGOT Submod

A custom start for CK3's A Game of Thrones mod. Play as Viserra, a young Dornish woman who discovers she carries the blood of the Black Dragon — and an egg that has been waiting for her.

---

## The Story

### Generation 1 — Vaella Blackfyre & Vorian Dayne
Daemon I Blackfyre had dragon eggs smuggled from Dragonstone before his rebellion. When the Black Dragon fell at the Redgrass Field in 8196, his daughter **Vaella** fled with one of those eggs. **Vorian Dayne**, a younger son of Starfall who had fought alongside the Blackfyres, smuggled her south to Dorne. They married on the road. He died mysteriously soon after arriving at Starfall. Vaella hid the egg and what remained of her father's legacy in a secret cache beneath the castle walls, and lived out her days as a quiet Dayne widow. She never told anyone.

### Generation 2 — Daemon Starfyre
**Daemon**, the posthumous son of Vorian and Vaella, was raised as a Dayne. Years later he discovered his mother's hidden cache — the dragon egg, and fragments of a Valyrian steel blade. He traveled to Qohor, where a master smith forged a new sword from the Blackfyre fragments and star-metal found near Starfall. He named the blade **Starfyre**.

Then he tried to hatch the egg. He built a pyre in the hills east of Starfall, stepped into the fire, and burned. The egg survived. Daemon did not. His loyal men — "Daemon's Faithful" — carried out his dying command: hide everything back at Starfall, find his daughter when she was old enough, and let her choose.

### Generation 3 — Viserra (Player Character)
**Viserra** starts the game in 8251 as a 16-year-old landless adventurer, nominally a Dayne. Her father's old sworn swords have just found her and told her the truth. She must travel to Starfall to discover the hidden cache — an egg, a sword, and a choice.

### Generation 4 — Lys Exile Branch (History Scaffold)
For post-Ninepenny bookmarks, Viserra's line is scaffolded forward through Lys. She relocates east, marries into a Rogare cadet line matrilineally, and her eldest child inherits the Starfyre adventurer camp before the later bookmark starts.

---

## Gameplay

### The Cache Discovery
Travel to **Starfall** (decision appears in the decisions tab). Upon arrival, an event fires revealing the full history. Viserra receives:
- **A dragon egg** (random, via AGOT's standard egg generation)
- **Starfyre** — a custom Valyrian steel sword (dark smoke ripples, dragon wing crossguard, star sapphire pommel)

Then a choice:

**Option A — "I am no longer a Dayne. I am Starfyre."**
- Switches dynasty to House Starfyre
- Gains the `dragon_dreams` trait
- Begins the dream event chain (see below)

**Option B — "These are mine — but I will keep my mother's name."**
- Stays as a Dayne
- Gains the `Hidden Legacy` trait (+2 Intrigue, +1 Diplomacy)
- Keeps the artifacts but does not claim the Starfyre name

### The Dream Chain (Option A only)
Five dreams fire over approximately 5-7 years, each escalating in intensity:

| Dream | Title | Fires After | Arc |
|-------|-------|------------|-----|
| 1 | A Dream of Wings | ~1 month | First vision — fire, wings, a heartbeat |
| 2 | A Father's Voice | ~6-10 months later | Sees her father studying the egg by firelight |
| 3 | The Pyre | ~10-15 months later | Witnesses her father's death in full |
| 4 | The Egg Stirs | ~15-20 months later | The egg pulses. It was waiting for her. |
| 5 | Fire and Blood | ~20-30 months later | She stands in fire and does not burn. A promise. |

Each dream has two options that give different rewards (stress, prestige, skill points). The chain triggers automatically — all options in each dream lead to the next.

### The Dragonstone Pilgrimage
A separate decision: **"Walk the Halls of Dragonstone"**. Available any time after founding House Starfyre, whenever Viserra travels to Dragonstone. She explores the volcanic caverns beneath the Dragonmont and feels the old power of the dragonlords. This is a one-time event with two options granting prestige and stress relief.

The dreams narratively guide the player toward Dragonstone, but the game doesn't force the order — you can visit day one or years later.

### Dragon Hatching
The Starfyre dynasty has `valyrian_heritage_dynasty_modifier` applied at game start via on_action, the same way AGOT handles Targaryen, Velaryon, Celtigar, etc. This gives **+15 to egg hatching weights**. Combined with Dragonstone's built-in location bonus (+10), Viserra is mechanically positioned to attempt hatching.

---

## Installation

1. Navigate to: `Documents/Paradox Interactive/Crusader Kings III/mod/`
2. Copy the `starfyre_mod/` folder into the `mod/` directory
3. Copy the `starfyre.mod` file into the same `mod/` directory

Result:
```
mod/
  starfyre.mod
  starfyre_mod/
    descriptor.mod
    common/
    events/
    history/
    localization/
```

4. Launch CK3, enable "House Starfyre Start" in the mod launcher
5. **Load order: after CK3 AGOT**

### How to Play
1. Start any AGOT bookmark (tested with 8251, 8277, 8282, 8284)
2. Select any character, or use the character finder to locate **Viserra** (landless adventurer in Dorne)
3. Travel to Starfall and take the "Search for the Hidden Cache" decision
4. Choose your path

---

## File Structure

```
starfyre_mod/
  common/
    coat_of_arms/coat_of_arms/99_starfyre_coa.txt    # Dynasty, house, and title COAs
    decisions/99_starfyre_decisions.txt                 # Cache + Dragonstone decisions
    dna_data/99_starfyre_dna.txt                       # Viserra's appearance
    dynasties/99_starfyre_dynasties.txt                 # dynn_Starfyre
    dynasty_houses/99_starfyre_dynasty_houses.txt       # house_Starfyre
    landed_titles/99_starfyre_landed_titles.txt         # Adventurer band title
    on_action/99_starfyre_on_actions.txt                # Game start hooks
    scripted_effects/99_starfyre_scripted_effects.txt   # Sword creation effect
    traits/99_starfyre_traits.txt                       # Hidden Legacy trait
  events/
    99_starfyre_startup_events.txt                      # Cache discovery event
    99_starfyre_dream_events.txt                        # 5-part dream chain + Dragonstone
  history/
    characters/99_starfyre_characters.txt               # Viserra line + post-8251 Lys branch
    titles/99_starfyre_titles.txt                       # Adventurer band holder
  localization/english/
    99_starfyre_l_english.yml                           # All loc keys (58 entries)
```

---

## Characters

| ID | Name | Born | Died | Dynasty | Notes |
|----|------|------|------|---------|-------|
| Starfyre_4 | Vaella | 8178 | 8240 | Blackfyre | Daemon I's daughter. Fled Redgrass Field with egg. |
| Starfyre_5 | Vorian | 8175 | 8196 | Dayne | Smuggled Vaella to Dorne. Died mysteriously. |
| Starfyre_2 | Daemon | 8197 | 8250 | Starfyre | Found cache, forged sword, died trying to hatch egg. |
| Starfyre_3 | Allyria | 8210 | 8252 | Dayne | Daemon's wife. Daughter of Finnian Dayne. |
| Starfyre_1 | Viserra | 8235 | — | Dayne* | Player character. *Can switch to Starfyre via event. |
| Starfyre_8 | Lysaro | 8232 | — | Rogare | Lys cadet-branch spouse (matrilineal marriage to Viserra in history scaffold). |
| Starfyre_9 | Vaella | 8254 | — | Dayne | Eldest descendant; receives Starfyre landless camp handoff for later bookmarks. |
| Starfyre_10 | Daemon | 8257 | — | Dayne | Younger descendant in Lys; backup lineage continuity. |

Post-Ninepenny bookmark coverage (`8277`, `8282`, `8284`) is handled by dated camp holder handoff in `history/titles/99_starfyre_titles.txt`.

---

## Known Issues & Warnings

### Appearance Inheritance (Important)
- What changed for Viserra's hair color: in `common/dna_data/99_starfyre_dna.txt`, `hair_color` was changed from `251 1 93 252` to `251 1 251 1`.
- Why this helps: CK3 DNA color genes use two allele slots. If those slots differ, visible results can appear to vary with inheritance/presentation context. Matching both slots locks the intended color more reliably.
- What this does **not** change: this only targets hair color stability. It does not force a single immutable barbershop hairstyle in every context.
- Current baseline for stability is still correct for Viserra:
  1. `dna = starfyre_viserra_dna`
  2. `disallow_random_traits = yes`
  3. Optional one-time startup reapply event/effect if additional drift is observed.

### Expected Errors (Harmless)
- `starfyre_is_viserra variable used but never set` — It's a character flag set in history, not a variable. CK3 warns but it works.
- `Decision picture missing` — Cosmetic. Decisions work but show no custom image.
- Spouse load order warnings — Character history parsing order; may produce warnings about marriage dates.

### Verified Working
- Cache discovery event fires at Starfall
- Option A switches dynasty to Starfyre, grants dragon_dreams
- Dragon egg and Valyrian steel sword granted
- Dream chain triggers and progresses
- Valyrian heritage dynasty modifier applied at game start
- Custom COA displays for dynasty

### To Verify
- Option B appears and grants Hidden Legacy trait
- All 5 dreams fire in correct sequence with new timings
- Dragonstone decision appears and fires at b_dragonstone
- Adventurer band COA (may still show Dayne arms)
- House COA displays correctly (not default)
- Save/reload stability through dream chain

---

## Future Work

### Phase 4 — Polish
- [ ] Custom decision images
- [ ] Trait icon for Hidden Legacy
- [ ] Dragonstone event: alternate text if visited before/after specific dreams
- [ ] House modifiers (thematic buffs for House Starfyre)
- [ ] Rename adventurer band after house switch
- [ ] Artifact provenance refinement

### Phase 5 — Hardening
- [ ] Namespace collision audit
- [ ] Save/reload stability testing
- [ ] Descendant path testing (what happens if Viserra dies before Starfall?)
- [ ] AI behavior (will AI Viserra make reasonable choices?)

### Considering
- [ ] `dragonrider_house_modifier` for House Starfyre — Blackfyre has this in AGOT. Would give taming/bonding bonuses. Could be granted at game start via on_action, or earned through the Dragonstone event.
- [ ] Dragonstone event variant text depending on dream progress
- [ ] Additional events: arriving at Qohor, forging path, political consequences of claiming Blackfyre blood
- [ ] Interaction with AGOT's Blackfyre rebellion content

---

## Modding Patterns Learned


**On-action hooks:** Use `on_game_start` with `on_actions = { my_action }` to run effects at game start. This is how AGOT applies dynasty modifiers — don't try to put modifiers in dynasty definitions.

**Trait definitions:** No `can_have` syntax. `valid_sex` only accepts `male` or `female` (omit for both). Loc keys need `trait_` prefix. Keep traits minimal to avoid silent parse failures.

**COA entries:** Dynasty (`dynn_X`), house (`house_X`), and title (`d_titlename`) are separate entries. Do NOT use `custom=yes`.

**Event themes:** `mystic` doesn't exist in CK3/AGOT. Use `intrigue`, `realm`, `diplomacy`, etc.

**Landed titles:** `color2` is not valid for landless adventurer titles.

**UTF-8 BOM:** Required for ALL mod files (`.txt` and `.yml`). Use `encoding='utf-8-sig'` in Python.

**DNA override blocks:** Not supported. Stick to the standard gene/accessory blocks.

**Event chaining:** Use `trigger_event = { id = X days = { min max } }` in `hidden_effect`. Randomized delays feel organic. All options should trigger the next event to avoid broken chains.

**Character flags vs variables:** Use `add_character_flag` / `has_character_flag` for boolean state. CK3 warns about flags as if they're variables — ignore the warning.

**Dynasty modifiers at game start:** Cannot be placed in dynasty definition files. Must use on_action `on_game_start` hook with `add_dynasty_modifier` in an effect block, matching AGOT's own pattern.
