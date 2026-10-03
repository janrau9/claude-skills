# 01 · doc-writer

> Generates and maintains Markdown documentation in a project's `docs/` folder as an LLM
> wiki — numbered files/folders, a `00-index.md` per level, dense cross-links.

## Source

`skills/doc-writer/SKILL.md` — see [the skill](../../skills/doc-writer/SKILL.md).

## What it does

When the user asks to write, create, or update any `.md` documentation, the skill:

1. Ensures `docs/` exists — a greenfield scaffold is three files from `templates/`:
   `docs/CLAUDE.md` (the convention), `00-index.md`, and `log.md`. If the project already
   has its own `docs/CLAUDE.md` or numbering, that convention wins over the skill's.
2. Places the new page in the right numbered folder with the next free `NN-` prefix.
3. Writes it Karpathy-style: H1 → one-line TL;DR → body, with relative cross-links and
   citations to raw sources (linked, never copied).
4. Updates the relevant `00-index.md`, adds back-links, and appends a dated line to
   `docs/log.md` — the maintained change log.

In an existing repo it follows any convention already in `docs/`, or — for a free-form
`docs/` — offers to **adopt** it (renumber + index existing files) only after confirmation,
defaulting to non-destructive coexistence otherwise. Existing pages are edited in place, not
duplicated. The project's root `README.md` and root `CLAUDE.md` are out of scope (entry
points, not wiki pages) unless the user explicitly asks.

## Templates it ships

- `templates/docs-CLAUDE.md` → installed as a project's `docs/CLAUDE.md` (the schema).
- `templates/00-index.md` → the starter top-level table of contents.
- `templates/log.md` → the starter change log.
- `templates/plans.md` → optional planned-work list (opt-in; never auto-created).

## Convention

The reading model and numbering rules are documented in this repo's own
[`docs/CLAUDE.md`](../CLAUDE.md), which is itself an instance of the template above.

## Install

```bash
./install.sh doc-writer            # global
./install.sh doc-writer --project <dir>
```
