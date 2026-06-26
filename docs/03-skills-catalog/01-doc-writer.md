# 01 · doc-writer

> Generates and maintains Markdown documentation in a project's `docs/` folder as an LLM
> wiki — numbered files/folders, a `00-index.md` per level, dense cross-links.

## Source

`skills/doc-writer/SKILL.md` — see [the skill](../../skills/doc-writer/SKILL.md).

## What it does

When the user asks to write, create, or update any `.md` documentation, the skill:

1. Ensures `docs/` exists, with a `docs/CLAUDE.md` (the convention) and a root `00-index.md`.
2. Places the new page in the right numbered folder with the next free `NN-` prefix.
3. Writes it Karpathy-style: H1 → one-line TL;DR → body, with relative cross-links and
   citations to raw sources (linked, never copied).
4. Updates the relevant `00-index.md`, adds back-links, and appends a dated line to
   `docs/log.md` — the maintained change log.

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
