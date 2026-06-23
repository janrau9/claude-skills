# 01 · Creating a skill

> Describe a skill you want; it becomes a `skills/<name>/SKILL.md` folder, gets cataloged
> here, and is installed by symlink.

## What a skill is

An [Agent Skill](https://claude.com/claude-code) is a folder containing a `SKILL.md` file.
Its YAML frontmatter (`name` + `description`) is all an agent reads when deciding whether to
load it; the body holds the instructions; bulky material lives in subfolders.

## Steps

1. **Name it.** Pick a short `kebab-case` name. Create `skills/<name>/SKILL.md`.
2. **Frontmatter.** Add `name` (equal to the folder name) and a `description`.
3. **Body.** Put the runtime instructions in the body. Move templates, scripts, and
   reference docs into `templates/`, `scripts/`, `references/` and link to them
   (progressive disclosure keeps the body small).
4. **Catalog.** Add an entry under [`03-skills-catalog/`](03-skills-catalog/00-index.md).
5. **Install & ship.** Give the install command (see [02 · Installing skills](02-installing-skills.md)).
   Commit and push only when asked.

## Writing the `description`

The description is the trigger. Lead with **what the skill does**, then **when to use it**
with concrete phrases the user would type. Be specific; add disqualifiers if it could be
confused with another skill. Full rules live in the repo's [`CLAUDE.md`](../CLAUDE.md).

## Reference

- Repo conventions: [`../CLAUDE.md`](../CLAUDE.md)
- Example skill: [doc-writer](03-skills-catalog/01-doc-writer.md) — `skills/doc-writer/SKILL.md`
