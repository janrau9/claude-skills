# docs/ — Documentation conventions (LLM Wiki)

This folder is an **LLM Wiki**: a persistent, compounding set of Markdown pages that agents
(Claude Code in particular) read and maintain. It follows the structure described in
Andrej Karpathy's "LLM Wiki" note
(<https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f>).

**This file is the schema** — the rules every page obeys. Read it before creating or
editing anything under `docs/`. (This `docs/` folder also serves as the live example output
of the [`doc-writer`](../skills/doc-writer/SKILL.md) skill.)

## Mental model — three layers

1. **Raw sources** — code, specs, external docs, tickets. *Immutable.* Read them, link to
   them, summarize them. Never rewrite them inside the wiki.
2. **The wiki** — every `.md` file under `docs/`. *Agent-owned.* Summaries, concept pages,
   entity pages, guides. This is what you create and refine.
3. **The schema** — this `CLAUDE.md`. Defines layout, numbering, and workflow.

## Layout & numbering (it reads top to bottom)

- Every content file and every subfolder carries a **zero-padded two-digit prefix**:
  `NN-kebab-slug`. Examples: `01-creating-a-skill.md`, `03-skills-catalog/`.
- **`00-index.md` is reserved at every level** as the table of contents for that level.
  Real content starts at `01`.
- **Sort order = read order.** Listing a folder alphabetically yields the intended reading
  sequence, top to bottom.
- Subfolders are numbered too, and each contains its own `00-index.md`.
- `CLAUDE.md`, `log.md`, and an optional `plans.md` are the only unnumbered files — they are
  meta, not content. `00-index.md` and `log.md` are the wiki's two **navigation tools**: the
  index answers "what exists?", the log answers "what changed, and when?" (`plans.md` covers
  "what's intended" — see below; it's opt-in.)

Example tree:

```
docs/
├── CLAUDE.md             ← this schema (unnumbered)
├── log.md                ← append-only change log (unnumbered)
├── plans.md              ← planned work — opt-in (unnumbered)
├── 00-index.md           ← top-level table of contents
├── 01-creating-a-skill.md
├── 02-installing-skills.md
└── 03-skills-catalog/
    ├── 00-index.md       ← section table of contents
    └── 01-doc-writer.md
```

## `00-index.md` format

Each `00-index.md` lists, **in numeric order**, every sibling entry with a one-line summary
and a relative link. It mirrors the folder exactly.

```markdown
# 00 · Index — <area name>

> One-line description of what this area covers.

- [01 · Creating a skill](01-creating-a-skill.md) — author a new skill here.
- [02 · Installing skills](02-installing-skills.md) — global vs per-project.
- [03 · Skills catalog](03-skills-catalog/00-index.md) — every skill in the repo.
```

Whenever you add, remove, rename, or renumber a file/folder, **update the relevant
`00-index.md` in the same pass**.

## Page conventions

- **One topic per page.** A page is an entity, a concept, or a task — not a grab-bag.
- **Lead with a TL;DR.** The first line after the H1 is a one-sentence summary in a
  blockquote.
- **Cross-link generously** with relative links. Dense linking is what makes the wiki
  navigable.
- **Cite raw sources, don't copy them.** Link to the file or URL and summarize — e.g.
  `See \`install.sh\`.` Sources are the truth; the wiki is the synthesis.
- **Keep it current.** Prefer editing the right existing page over adding a near-duplicate.
- **Sentence-case, shallow headings.** H1 title, H2 sections, H3 sparingly.

## Operations

- **Create / ingest.** New doc → pick the right folder (or create a numbered one) → take the
  next free `NN-` prefix → write the page → update that level's `00-index.md` → add
  cross-links from related pages → **append a `log.md` line**.
- **Insert / renumber.** Inserting between `02` and `03`? Renumber the tail (`03 → 04`, …),
  fix every link that pointed at them, update the index — in one pass.
- **Lint (periodically).** Scan for: entries missing from an index, orphaned pages, broken
  relative links, stale claims that no longer match the raw sources, and contradictory
  pages. Fix or flag.

## log.md — the change log

Karpathy's LLM wiki keeps **two** navigation files: `index.md` (here, `00-index.md`) and
`log.md`. `log.md` is the maintained change log — an append-only, chronological record so
any agent can reconstruct *what changed and when* without diffing git.

Keep one `log.md` at the top of `docs/`. Newest at the bottom, one dated line per change,
with a stable prefix (`[ingest]` new page, `[update]` edit, `[lint]` cleanup):

```
2026-06-26 [ingest] 01-creating-a-skill.md — initial guide
2026-06-26 [update] 03-skills-catalog/00-index.md — registered doc-writer
2026-06-26 [lint]   fixed 3 broken links under 03-reference/
```

Append a line on every change, in the same pass that you touch the page and its index.

## plans.md — the future (opt-in)

`00-index.md` and `log.md` are the two core navigation files. `plans.md` is an **optional
third surface** for forward-looking work: a task list of what's intended but **not yet true**.
Add it only if you plan in-repo — many projects plan in issues/PRs instead, where a blank
`plans.md` would just be noise.

Keep it strictly segregated from the numbered knowledge pages. Those state what *is* true;
`plans.md` states what *isn't yet*. Mixing them lets an agent read an intention as fact.

**Lifecycle — promote-and-prune.** An item lives in `plans.md` only while it is still future.
"Pruning" relocates the information; it never destroys it:

```
plans.md (future) ──ships──▶ numbered page (present) + log.md (past) ──▶ removed from plans.md
                  └─abandoned──────────────────────────────────────────▶ removed from plans.md
```

- **Ships:** write the resulting knowledge into the right numbered page, append a `log.md`
  line, then delete the item from `plans.md`.
- **Abandoned:** delete it (optionally a `[plan] dropped …` line in `log.md`); no page, since
  nothing became true.

Never leave shipped or dead items lying around as checked-off boxes — that graveyard is
exactly what this discipline avoids. Open and in-progress items live here; done items leave.
