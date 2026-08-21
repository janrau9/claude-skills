# 02 · Installing skills

> `install.sh` symlinks a skill into a Claude skills directory, so edits in this repo take
> effect immediately everywhere it's installed.

## Global (every project)

```bash
./install.sh <name>
```

Links `skills/<name>` into `~/.claude/skills/<name>` (or `$CLAUDE_CONFIG_DIR/skills` if set).

## Per-project

```bash
./install.sh <name> --project ~/code/my-app
```

Links into `<project>/.claude/skills/<name>`.

## Other commands

```bash
./install.sh --all       # install every skill globally
./install.sh --list      # list available skills
./install.sh --help      # usage
```

## Uninstall

Delete the symlink — the repo is untouched:

```bash
rm ~/.claude/skills/<name>
```

## Why symlinks

Installs point back at this repo. Edit a skill here and every install — global and
per-project — sees the change immediately, with no reinstall. See [`../install.sh`](../install.sh).

## Remote one-liner (machines without this repo)

[`../remote-install.sh`](../remote-install.sh) fetches the repo itself (shallow, to a
temp dir) and **copies** the skill instead of symlinking — right for machines that don't
keep a clone, and for vendoring into a project you'll commit (teammates and Claude Code
cloud sessions only see committed files, not symlinks). Re-running updates the copy.

```bash
curl -fsSL https://raw.githubusercontent.com/janrau9/claude-skills/main/remote-install.sh \
  | bash -s -- <name>
```

Flags mirror `install.sh` (`--all`, `--project DIR`, `--list`) plus `--ref BRANCH`. When
run from inside a checkout it skips the network fetch and copies from the working tree.
It also falls back through SSH and `gh` clones, so it keeps working from authenticated
machines even if the repo's visibility changes.
