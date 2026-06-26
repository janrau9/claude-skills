# docs/ — Documentation conventions (LLM Wiki)

This folder is an **LLM Wiki**: a persistent, compounding set of Markdown pages that agents
(Claude Code in particular) read and maintain. It follows the structure described in
Andrej Karpathy's "LLM Wiki" note
(<https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f>).

**This file is the schema** — the rules every page obeys. Read it before creating or
editing anything under `docs/`.

## Mental model — three layers

1. **Raw sources** — code, specs, external docs, tickets. *Immutable.* Read them, link to
   them, summarize them. Never rewrite them inside the wiki.
2. **The wiki** — every `.md` file under `docs/`. *Agent-owned.* Summaries, concept pages,
   entity pages, guides. This is what you create and refine.
3. **The schema** — this `CLAUDE.md`. Defines layout, numbering, and workflow.

## Layout & numbering (it reads top to bottom)

- Every content file and every subfolder carries a **zero-padded two-digit prefix**:
  `NN-kebab-slug`. Examples: `01-getting-started.md`, `02-architecture/`.
- **`00-index.md` is reserved at every level** as the table of contents for that level.
  Real content starts at `01`.
- **Sort order = read order.** Listing a folder alphabetically yields the intended reading
  sequence, top to bottom.
- Subfolders are numbered too, and each contains its own `00-index.md`.
- `CLAUDE.md` and `log.md` are the only unnumbered files — they are meta, not content.
  `00-index.md` and `log.md` are the wiki's two **navigation tools**: the index answers
  "what exists?", the log answers "what changed, and when?"

Example tree:

```
docs/
├── CLAUDE.md             ← this schema (unnumbered)
├── log.md                ← append-only change log (unnumbered)
├── 00-index.md           ← top-level table of contents
├── 01-getting-started.md
├── 02-architecture/
│   ├── 00-index.md       ← section table of contents
│   ├── 01-overview.md
│   └── 02-data-flow.md
└── 03-reference/
    ├── 00-index.md
    └── 01-config.md
```

## `00-index.md` format

Each `00-index.md` lists, **in numeric order**, every sibling entry with a one-line summary
and a relative link. It mirrors the folder exactly.

```markdown
# 00 · Index — <area name>

> One-line description of what this area covers.

- [01 · Getting started](01-getting-started.md) — install, first run, key concepts.
- [02 · Architecture](02-architecture/00-index.md) — how the pieces fit together.
- [03 · Reference](03-reference/00-index.md) — config, APIs, flags.
```

Whenever you add, remove, rename, or renumber a file/folder, **update the relevant
`00-index.md` in the same pass**.

## Page conventions

- **One topic per page.** A page is an entity, a concept, or a task — not a grab-bag.
- **Lead with a TL;DR.** The first line after the H1 is a one-sentence summary in a
  blockquote.
- **Cross-link generously** with relative links
  (`[overview](../02-architecture/01-overview.md)`). Dense linking is what makes the wiki
  navigable.
- **Cite raw sources, don't copy them.** Link to the file or URL and summarize — e.g.
  `See \`src/auth/login.ts:42\`.` Sources are the truth; the wiki is the synthesis.
- **Keep it current.** Prefer editing the right existing page over adding a near-duplicate.
  Touching many files to fix one cross-reference is expected and cheap for an agent.
- **Sentence-case, shallow headings.** H1 title, H2 sections, H3 sparingly.

## Operations

- **Create / ingest.** New doc → pick the right folder (or create a numbered one) → take the
  next free `NN-` prefix → write the page → update that level's `00-index.md` → add
  cross-links from related pages → **append a `log.md` line**.
- **Insert / renumber.** Inserting between `02` and `03`? Renumber the tail (`03 → 04`, …),
  fix every link that pointed at them, update the index — in one pass.
- **Lint (periodically).** Scan for: entries missing from an index, orphaned pages (nothing
  links to them), broken relative links, stale claims that no longer match the raw sources,
  and contradictory pages. Fix or flag.

## log.md — the change log

Karpathy's LLM wiki keeps **two** navigation files: `index.md` (here, `00-index.md`) and
`log.md`. `log.md` is the maintained change log — an append-only, chronological record so
any agent can reconstruct *what changed and when* without diffing git.

Keep one `log.md` at the top of `docs/`. Newest at the bottom, one dated line per change,
with a stable prefix (`[ingest]` new page, `[update]` edit, `[lint]` cleanup):

```
2025-01-01 [ingest] 01-getting-started.md — initial setup guide
2025-01-02 [update] 02-architecture/01-overview.md — added queue section
2025-01-03 [lint]   fixed 3 broken links under 03-reference/
```

Append a line on every change, in the same pass that you touch the page and its index.
