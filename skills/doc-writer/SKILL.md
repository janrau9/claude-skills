---
name: doc-writer
description: Generate and maintain Markdown documentation in a project's docs/ folder as an LLM wiki — numbered files and folders, a 00-index.md table of contents per level, and dense cross-links, following Karpathy's LLM-wiki convention. Use whenever the user asks to write, create, or generate a .md doc, add or update documentation, document a feature/module/API, or set up a docs/ structure. Creates docs/ and its docs/CLAUDE.md guide if they don't exist.
---

# Doc Writer

Turns "write me a doc about X" into a well-placed, well-linked Markdown page inside the
project's `docs/` folder, maintained as an **LLM Wiki**: a persistent, compounding set of
numbered pages with a `00-index.md` table of contents at every level.

The full convention lives in [`templates/docs-CLAUDE.md`](templates/docs-CLAUDE.md). That
file is the source of truth and gets installed into each project as `docs/CLAUDE.md`.

## When to use

Load when the user wants to create or maintain documentation, e.g.:
"write a doc on…", "create a `.md` for…", "add documentation", "document this
module/API/feature", "set up docs", "update the docs", "add a page about…".

Not for the project's root `README.md` or root `CLAUDE.md` (those are entry points, not
wiki pages) — unless the user explicitly asks to put something there.

## Where docs go

- **All generated documentation lives under `docs/` at the project root.** If `docs/` does
  not exist, create it.
- If the user names an explicit path, honor it. Otherwise default to `docs/`.

## First-run setup (do this if the pieces are missing)

1. If `docs/` is missing → create it.
2. If `docs/CLAUDE.md` is missing → copy this skill's
   [`templates/docs-CLAUDE.md`](templates/docs-CLAUDE.md) to `docs/CLAUDE.md`.
3. If `docs/00-index.md` is missing → copy
   [`templates/00-index.md`](templates/00-index.md), filling in the project name.

## Generating a doc (every time)

1. **Read `docs/CLAUDE.md`** and the relevant `00-index.md` file(s). Follow whatever
   convention is recorded there — if it differs from this skill's default, the project's
   `docs/CLAUDE.md` wins.
2. **Place it.** Choose the right numbered folder; create a new numbered folder for a new
   area (with its own `00-index.md`).
3. **Number it.** Take the next free zero-padded `NN-` prefix at that level (content starts
   at `01`; `00-index.md` is reserved for the table of contents).
4. **Write the page:** H1 title → one-line TL;DR in a blockquote → body. Cross-link related
   pages with relative links. Cite raw sources (link to files/URLs, e.g. `src/app.ts:42`) —
   summarize them, never copy them wholesale.
5. **Update the index.** Add the entry to that level's `00-index.md` in numeric order, with
   a one-line summary and relative link.
6. **Back-link.** Add reciprocal links from closely related pages.
7. **Log it.** If `docs/log.md` exists (or the convention calls for one), append a line.

## Inserting between existing docs

Renumber the tail (`03 → 04`, …), fix every link that pointed at the moved files, and update
the `00-index.md` — all in one pass.

## Respect what's there

If `docs/` already has a numbering scheme or its own `docs/CLAUDE.md`, follow it. Don't
impose a conflicting convention on an existing wiki.
