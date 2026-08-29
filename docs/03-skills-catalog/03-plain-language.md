# 03 · plain-language

> ISO 24495-1 for engineers — plain is precise: exact identifiers, short sentences, no
> smoothing of uncertainty. Governs explanations, report-backs, and all engineering prose.

## Source

`skills/plain-language/SKILL.md` — see [the skill](../../skills/plain-language/SKILL.md).

## What it does

- **Explain mode** (the flagship): "explain this" gets the answer in the first
  sentence, mechanism in 2–6 sentences, exact identifiers, then stops. Flows and depth
  take **the journey** form — a numbered trace of one concrete scenario. Depth on
  request only.
- **Report mode**: after work, outcome first, files named, every claim tagged
  verified / assumed / not tested, failures verbatim.
- **Intake valve**: "ask the forks, declare the rest" — ambiguity that changes the
  build gets asked (one batch, with options); minor ambiguity proceeds with the
  assumption declared. Never a silent guess.
- **Draft / Strip / Audit**: write new prose to shape, rewrite existing prose (with a
  removal ledger), or lint it (`location · category · text · fix`).
- The signature rule cuts both ways: kills empty hedges *and* false confidence.

## Structure

- `SKILL.md` — the laws, five modes, protected spans, boundaries.
- `rule.md` — ~20 agent-agnostic lines (intake / explain / report / everywhere) meant
  to be appended to `~/.claude/CLAUDE.md` or a project's `AGENTS.md`, replacing any
  overlapping writing rule. Skills load per-task; the always-on defaults need context.
- `references/kill-list.md` — filler catalog with before → after pairs, including
  structural tells (sycophantic openers, marketing triads, hedged closers).
- `references/recipes.md` — shapes for commits, PRs, errors, incident reports,
  release notes, docstrings, READMEs, the journey template, audit output.

## Relations

Composes with [`doc-writer`](01-doc-writer.md): doc-writer builds the docs/ structure,
plain-language governs the prose inside it. Out of scope: marketing persuasion, legal
wording (audit only, never strip).

## Install

```bash
./install.sh plain-language                            # the skill
cat skills/plain-language/rule.md >> ~/.claude/CLAUDE.md   # the always-on rule
```
