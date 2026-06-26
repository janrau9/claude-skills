---
name: doc-writer
description: Generate and maintain Markdown documentation in a project's docs/ folder as an LLM wiki — numbered files and folders, a 00-index.md table of contents per level, dense cross-links, and an append-only log.md change log, following Karpathy's LLM-wiki convention. Use whenever the user asks to write, create, or generate a .md doc, add or update documentation, document a feature/module/API, or set up a docs/ structure. Creates docs/ and its docs/CLAUDE.md guide if they don't exist. Works in existing repos too: follows a convention already in docs/, or offers (with confirmation) to adopt a free-form docs/ rather than imposing one, and edits existing pages in place.
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

## Setting up docs/ (assess first)

Before creating anything, classify the current `docs/`:

- **Absent or empty** → greenfield. Create `docs/` and copy in the scaffold:
  1. `docs/CLAUDE.md` ← [`templates/docs-CLAUDE.md`](templates/docs-CLAUDE.md)
  2. `docs/00-index.md` ← [`templates/00-index.md`](templates/00-index.md) (fill in the project name)
  3. `docs/log.md` ← [`templates/log.md`](templates/log.md) — the change log

  (`plans.md` is opt-in — see below — and is never auto-created.)
- **Already on a convention** — it has its own `docs/CLAUDE.md`, or its files are numbered →
  follow what's there; do **not** impose this one. Only fill in a missing `00-index.md` or
  `log.md`, matching the existing style.
- **Populated but free-form** — real `.md` files, but no `docs/CLAUDE.md` and no numbering →
  **do not silently impose the convention.** Go to [Working in an existing
  repo](#working-in-an-existing-repo-brownfield) and confirm with the user first.

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
7. **Log it.** Append a dated line to `docs/log.md` (`[ingest]` new page, `[update]` edit,
   `[lint]` cleanup), creating the file from [`templates/log.md`](templates/log.md) if it's
   missing.

## Updating an existing page

When the change belongs in a page that already exists, edit it in place — don't add a
near-duplicate:

1. Find the right page via `00-index.md`; read it.
2. Edit the content; refresh any claim the raw sources no longer support; keep the TL;DR
   accurate.
3. Fix or add the cross-links the change touches.
4. Renumber/retitle only if the topic genuinely moved — then update the index and inbound
   links too.
5. Append an `[update]` line to `docs/log.md`.

## Inserting between existing docs

Renumber the tail (`03 → 04`, …), fix every link that pointed at the moved files, and update
the `00-index.md` — all in one pass.

## Working in an existing repo (brownfield)

When `docs/` already holds free-form, un-numbered files and has no `docs/CLAUDE.md`, **pause
and offer two paths** — default to coexist if the user doesn't choose:

- **Coexist (default, non-destructive).** Leave every existing file exactly as it is. Add
  `docs/CLAUDE.md`, `00-index.md`, and `log.md`; list the existing files in `00-index.md`
  as-is under an "Existing docs" note; apply the numbered convention only to *new* pages.
  Nothing is renamed.
- **Adopt / migrate (only after explicit confirmation).** Renaming files breaks inbound links
  (READMEs, code comments, external URLs), so confirm first. Then, in one pass: propose a
  numbering map → rename each file to its `NN-` slug → register them in `00-index.md` → fix
  every internal link that pointed at the old names → append one `[adopt]` line to `log.md`.
  Flag any external links you cannot update.

If the project already has its own `docs/CLAUDE.md` or numbering, neither applies — follow
what's there, and don't impose a conflicting convention.

## plans.md (opt-in — do not auto-create)

`plans.md` is a third, optional meta-file: a task list of forward-looking work that's **not
yet true**. Do **not** scaffold it on first run. Create it (from
[`templates/plans.md`](templates/plans.md)) only when the user wants to track planned work
in-repo.

Keep it separate from the numbered knowledge pages. When a planned item **ships**: write the
resulting knowledge into the right numbered page, append a `log.md` line, then **remove the
item from `plans.md`** (promote-and-prune). When it's **abandoned**: remove it (optionally a
`[plan] dropped …` line in `log.md`). Never leave done/dead items behind as checked boxes —
their history lives in `log.md`. See `docs/CLAUDE.md` for the full lifecycle.
