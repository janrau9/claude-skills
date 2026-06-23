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
