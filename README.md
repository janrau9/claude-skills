# claude-skills

A personal catalog of **Agent Skills** (primarily for [Claude Code](https://claude.com/claude-code)).
This is the place where skills are authored, version-controlled, and installed from.

Describe a skill you want → it gets built here → install it globally or per-project.

## Install a skill

Skills are installed by **symlink**, so any edit in this repo takes effect immediately
everywhere the skill is installed.

```bash
# Global — available in every project (~/.claude/skills)
./install.sh doc-writer

# Per-project — only this project (<project>/.claude/skills)
./install.sh doc-writer --project ~/code/my-app

# Everything, globally
./install.sh --all

# List what's available
./install.sh --list
```

To remove a skill, just delete the symlink (e.g. `rm ~/.claude/skills/doc-writer`).

## One-line install on another machine

`remote-install.sh` fetches the repo itself and **copies** the skill (no clone left
behind; re-run to update):

```bash
curl -fsSL https://raw.githubusercontent.com/janrau9/claude-skills/main/remote-install.sh \
  | bash -s -- seiza
```

Same flags as `install.sh` (`--all`, `--project DIR`, `--list`), plus `--ref BRANCH`.
Use `--project` to vendor a copy into a repo for teammates or Claude Code cloud sessions.

## Available skills

| Skill | What it does |
|-------|--------------|
| [`doc-writer`](skills/doc-writer/SKILL.md) | Generates & maintains Markdown docs in a project's `docs/` folder as an LLM-wiki: numbered files/folders, a `00-index.md` table of contents, and dense cross-links. |
| [`seiza`](skills/seiza/SKILL.md) | Applies Seiza (星座) — janrau's design language: Japanese architectural minimalism under a cosmic sky, monochrome OKLCH lightness hierarchy, one vermilion seal per view, Fibonacci space/time ladders. |

## Request a new skill

Tell Claude Code (in this repo) what you want the skill to do and when it should trigger.
It will scaffold `skills/<name>/SKILL.md`, add supporting files, register it in
[`docs/`](docs/00-index.md), and tell you how to install it. See
[`CLAUDE.md`](CLAUDE.md) for the authoring conventions.

## How this repo is organized

```
skills/        one folder per skill (SKILL.md + optional templates/scripts/references)
install.sh     symlink installer
docs/          this repo's own docs, following the LLM-wiki convention in docs/CLAUDE.md
CLAUDE.md      conventions for authoring skills here
```
