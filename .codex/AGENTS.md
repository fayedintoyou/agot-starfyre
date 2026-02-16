# CK3 AGOT Submod Development

**Base Mod**: `/mnt/c/Program Files (x86)/Steam/steamapps/workshop/content/1158310/2962333032`  
**Environment**: WSL (Linux paths only - never use `C:\...`)

---

## Workflow

1. **Check `/docs/` first** - lessons-learned, integration-points, file-index, patterns
2. **Search AGOT** (grep/find) - targeted, never read entire directories
3. **Read specific files** (view with line ranges)
4. **Implement** using documented patterns
5. **Auto-update docs** as you work - don't wait to be asked

---

## Auto-Documentation (Do This Automatically)

**Append to `/docs/lessons-learned.md` when you:**
- Make a mistake → what broke + why + fix
- Discover AGOT quirk → syntax rule + example
- Find new hook/system → file:line reference

**Update other docs when you:**
- Find new file locations → `/docs/file-index.md`
- Find new hooks → `/docs/integration-points.md`  
- Create reusable code → `/docs/patterns/[system].md`

**Format**: Brief, code examples, file:line refs. No fluff.

---

## Known Patterns (Read `/docs/lessons-learned.md` for details)

✅ On-actions for game start (not in dynasty defs)  
✅ UTF-8 BOM all files (`encoding='utf-8-sig'`)  
✅ Loc keys: dot notation (`namespace.id.t`)  
✅ Traits: no `can_have`, `valid_sex` = male|female only  
✅ Event themes: intrigue/realm/diplomacy (no `mystic`)  
✅ Flags: `add_character_flag` (ignore CK3 warnings)  
✅ Event chains: `trigger_event` in `hidden_effect`

**Don't repeat these mistakes. Check docs before coding.**

---

## Critical Paths
```bash
BASE="/mnt/c/Program Files (x86)/Steam/steamapps/workshop/content/1158310/2962333032"

$BASE/common/on_action/          # Integration hooks
$BASE/common/scripted_effects/   # Reusable effects
$BASE/events/                    # Event examples
$BASE/localization/english/      # Loc patterns
```

---

## Error Handling

1. Check `/docs/lessons-learned.md` for known issues
2. Read error.log: `/mnt/c/Users/.../Paradox Interactive/Crusader Kings III/logs/error.log`
3. If new error → document it immediately in lessons-learned
4. If repeat error → you failed to check docs

---

## File Discovery
```bash
# Search first
grep -r "pattern" $BASE/common/on_action/

# Then read specific
view /path/to/file.txt 100-200

# Then document
# (update file-index.md automatically)
```

---

## Meta-Rules

- Docs update happens **during work**, not after
- Be specific: file:line, code examples
- Append, don't replace established knowledge
- Check docs → prevents repeat mistakes → saves time

**If you search for the same thing twice, you failed to document it the first time.**