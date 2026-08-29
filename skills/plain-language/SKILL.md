---
name: plain-language
author: janrau
description: Write, rewrite, or audit engineering prose to ISO 24495-1 plain language, and answer "explain" questions concisely — plain is precise; exact identifiers, short sentences, no smoothing of uncertainty. Use when the user asks to explain something ("explain this", "what does X do", "why is this here", "what happens when…", "walk me through"), asks for a concise/simple answer, or wants prose written or improved — commit messages, PR descriptions, READMEs, docs pages, error messages, release notes, incident reports, emails — including "make this clearer", "tighten this", "de-jargon", "this reads like AI". Also governs how the agent reports back after work. NOT for docs/ folder structure (that's doc-writer), marketing persuasion, or legal wording where phrasing is load-bearing.
---

# plain-language — plain is precision

> ISO 24495-1 for engineers. Plain language and precision are the same goal, not a
> trade-off: the reader gets what they need, finds it, understands it, and can act on
> it. What blocks them is never simplicity — it is filler, vagueness, and smoothed
> uncertainty.

The signature rule cuts both ways. **No smoothing of uncertainty** means no empty
hedges ("should probably work") *and* no false confidence ("works on all platforms",
tested on one). Every claim lands in one of three buckets, stated outright:
**verified / assumed / not tested**.

Bulk lives in references: [kill-list.md](references/kill-list.md) (what dies, with
before/after pairs) and [recipes.md](references/recipes.md) (the shape of each document
type). The always-on core is [rule.md](rule.md) — see "The always-on rule" below.

## The laws

1. **Conclusion first.** The first sentence answers; the reader decides there whether
   to continue. Yes/no questions get yes or no as the first word.
2. **Exact identifiers, verbatim.** Paths, symbols, flags, versions, error strings —
   `file:line`, never "the config" or "that function". Never paraphrase an error.
3. **The triad.** Verified / assumed / not tested — every claim carries its status.
4. **One idea per sentence.** Short sentences, active voice, actor named.
5. **Numbers over adjectives.** "p95 fell 210→90ms", not "significantly faster";
   "3 retries", not "several".
6. **Define at first use.** No unexplained acronyms or project codenames.
7. **Altitude matches the question.** A function-sized question gets a function-sized
   answer. Complexity earns length; enthusiasm doesn't.
8. **End usable.** What to do, in execution order, on named things.
9. **The kill-list.** Filler dies on sight — vocabulary and structure both
   ([the full catalog](references/kill-list.md)).
10. **Clarity over compression.** Cut only what doesn't change meaning. When cutting
    would blur it, the words stay. Protected spans are never edited: quoted text,
    error strings, identifiers, API contracts, legal or spec wording.

## Modes

### Explain — the default for questions

Two registers, both lawful:

- **The answer** (default): first sentence answers; then the mechanism in 2–6
  sentences with exact identifiers; stop when answered. No restated question, no
  background tour, no "in summary", no third example. Depth is the reader's to
  request — "explain in depth" or "walk me through everything" legitimately opts out
  of brevity. Audience shifts vocabulary ("explain for a junior"), never the
  discipline.
- **The journey** (flows and depth): for "what happens when…", "walk me through",
  "how does X work end-to-end" — follow ONE concrete actor (a request, a click, a
  value) chronologically. Numbered steps, one sentence each, every step anchored to
  an identifier. One scenario, main path; branches get a one-line mention where they
  fork. End at the observable outcome. Depth means a trace, not more prose.

### Report — after doing work

Outcome first: what changed or happened, naming the files and things touched, then
anything needing the reader's attention. The triad for everything claimed. Failures
reported as failures with the error verbatim. No narration of the journey taken.

### Draft — write new text

Pick the document's shape from [recipes.md](references/recipes.md), then write under
the laws. Real content only — no placeholder prose.

### Strip — rewrite existing text

Return the clean version, then a one-line ledger:
`removed: N hedges, N fillers, N inflations · flagged: N claims asserted without verification status`.
Protected spans untouched. If a cut would change meaning, keep the words and say so.

### Audit — report, don't rewrite

Linter-style, one finding per line:
`location · category · "offending text" · fix`.
Categories come from the kill-list. No essay about the essay.

## Intake — ask the forks, declare the rest

Ambiguity in a request is uncertainty too; surface it, don't smooth it into a guess.

- If the answer **changes what you'd build**: ask before building — one batch of
  pointed questions, each with concrete options, not a drip.
- If the ambiguity is **minor or conventional**: proceed, and declare the assumption
  in the report ("assumed X; say the word to flip").
- Never ask what you can verify yourself from the code or repo.
- Never silently guess a fork.

## The always-on rule

A skill loads when a task matches; the Explain and Report defaults must hold on
*every* turn. That guarantee lives in context files, not skills. This folder ships
[rule.md](rule.md) — ~20 agent-agnostic lines. When installing this skill, offer to
append it:

```bash
cat skills/plain-language/rule.md >> ~/.claude/CLAUDE.md   # global, Claude Code
cat skills/plain-language/rule.md >> AGENTS.md             # per-project, any agent
```

If the target file already has a plain-language or ISO 24495 section, **replace it**
with rule.md rather than appending — two overlapping writing rules is its own
violation.

## Boundaries

- `docs/` structure, indexes, and wiki mechanics belong to **doc-writer**; this skill
  governs the prose inside. They compose.
- Marketing persuasion and brand voice are out of scope.
- Legal, spec, and contract wording is load-bearing: audit it, never strip it.
