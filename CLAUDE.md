# CLAUDE.md — Skills authoring repo

This repository is a personal catalog of **Agent Skills** (primarily for Claude Code).
Each skill is authored here, version-controlled, and **installed by symlink** into
`~/.claude/skills` (global) or a project's `.claude/skills` (per-project), so edits made
here propagate live everywhere the skill is installed.

The repo is also itself a workshop: when the user describes a skill they want, you build
it here, then they install it.

## Layout

```
skills/<name>/SKILL.md      one folder per skill; SKILL.md is required
skills/<name>/templates/    optional supporting files (templates, scripts, references)
install.sh                  symlink installer (global or per-project)
docs/                       this repo's own docs — follows the LLM-wiki convention
                            in docs/CLAUDE.md (dogfoods the doc-writer skill)
README.md                   human-facing overview + install instructions
```

## The core workflow: authoring a new skill

When the user describes a skill they want:

1. Pick a short `kebab-case` name. Create `skills/<name>/SKILL.md`.
2. Write the frontmatter (see below). The `name` must equal the folder name.
3. Keep the runtime instructions in the SKILL.md body. Put bulky material — templates,
   scripts, reference docs — in subfolders (`templates/`, `scripts/`, `references/`) and
   point to them from the body. This is **progressive disclosure**: the body stays small;
   detail is loaded only when needed.
4. Add a catalog entry under `docs/03-skills-catalog/` following `docs/CLAUDE.md`.
5. Tell the user the exact install command. Commit and push **only when they ask**.

## SKILL.md frontmatter

```yaml
---
name: <kebab-case, matches the folder name>
description: <see rules below — this is the only thing the agent sees when deciding to load>
---
```

Optional keys some skills use: `references:` (list of reference doc slugs under `references/`).

## Writing the `description` (most important field)

The description is the **trigger**: an agent reads only the name + description to decide
whether to load the skill. Make it earn its load.

- Third person. Start with **what the skill does**, then **when to use it** with concrete
  trigger phrases the user is likely to type.
- Be specific, not generic. "Use when the user asks to write/create/generate a `.md` doc,
  add documentation, or set up a `docs/` structure" beats "helps with docs".
- Mention disqualifiers if the skill is easily confused with another.

## Installing skills

```
./install.sh <name>                     # symlink into ~/.claude/skills (global)
./install.sh <name> --project <dir>     # symlink into <dir>/.claude/skills
./install.sh --all                      # install every skill globally
./install.sh --list                     # list available skills
```

Installs are symlinks, so editing a skill here updates every install immediately.

## Git

Public GitHub repo (`janrau9/claude-skills`). Commit and push **only when the user asks**.
Never commit secrets or personal data — the repo is world-readable.
Keep each skill in its own commit-able unit; conventional, descriptive commit messages.
