#!/usr/bin/env bash
#
# install.sh — symlink skills from this repo into a Claude skills directory.
#
# Symlinking (not copying) means edits made in this repo take effect immediately
# everywhere the skill is installed.
#
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$REPO_DIR/skills"

usage() {
  cat <<'EOF'
Install skills from this repo by symlinking them into a Claude skills directory.

Usage:
  ./install.sh <skill>...                Install named skill(s) globally (~/.claude/skills)
  ./install.sh --all                     Install every skill globally
  ./install.sh <skill>... --project DIR  Install into DIR/.claude/skills instead
  ./install.sh --list                    List available skills
  ./install.sh -h | --help               Show this help

Examples:
  ./install.sh doc-writer
  ./install.sh --all
  ./install.sh doc-writer --project ~/code/my-app
EOF
}

list_skills() {
  echo "Available skills:"
  for d in "$SKILLS_DIR"/*/; do
    [ -f "${d}SKILL.md" ] || continue
    echo "  - $(basename "$d")"
  done
}

# --- parse args ---------------------------------------------------------------
names=()
all=0
project=""

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    --list) list_skills; exit 0 ;;
    --all) all=1; shift ;;
    --project)
      [ $# -ge 2 ] || { echo "error: --project needs a directory" >&2; exit 1; }
      project="$2"; shift 2 ;;
    --*) echo "error: unknown flag '$1'" >&2; usage; exit 1 ;;
    *) names+=("$1"); shift ;;
  esac
done

# --- resolve target dir -------------------------------------------------------
if [ -n "$project" ]; then
  target="${project/#\~/$HOME}/.claude/skills"
else
  target="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills"
fi

# --- resolve skill list -------------------------------------------------------
if [ "$all" -eq 1 ]; then
  names=()
  for d in "$SKILLS_DIR"/*/; do
    [ -f "${d}SKILL.md" ] && names+=("$(basename "$d")")
  done
fi

if [ "${#names[@]}" -eq 0 ]; then
  echo "error: no skills specified" >&2
  echo >&2
  usage
  exit 1
fi

mkdir -p "$target"

# --- symlink ------------------------------------------------------------------
for name in "${names[@]}"; do
  src="$SKILLS_DIR/$name"
  if [ ! -f "$src/SKILL.md" ]; then
    echo "skip: '$name' is not a skill (no $src/SKILL.md)" >&2
    continue
  fi
  ln -sfn "$src" "$target/$name"
  echo "linked: $target/$name -> $src"
done

echo "done. installed into: $target"
