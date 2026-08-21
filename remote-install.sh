#!/usr/bin/env bash
#
# remote-install.sh — one-line install of skills from this repo onto any machine,
# no permanent clone required. COPIES the skill (unlike install.sh's symlinks),
# which also suits vendoring into a project you'll commit for teammates or
# Claude Code cloud sessions. Re-run to update.
#
# One-liner:
#
#   curl -fsSL https://raw.githubusercontent.com/janrau9/claude-skills/main/remote-install.sh \
#     | bash -s -- seiza
#
# Also works via GitHub CLI (gh api .../contents/remote-install.sh | bash -s -- seiza)
# or from a clone (./remote-install.sh seiza — skips the network fetch).
#
set -euo pipefail

OWNER_REPO="janrau9/claude-skills"
REPO_SSH="git@github.com:${OWNER_REPO}.git"
REPO_HTTPS="https://github.com/${OWNER_REPO}.git"
REF="main"

usage() {
  cat <<'EOF'
Install skills from the claude-skills repo by copying them into a Claude skills
directory. Works piped from curl/gh (fetches the repo itself) or from inside a
checkout. Re-run to update an installed copy.

Usage:
  remote-install.sh <skill>...                Install named skill(s) globally (~/.claude/skills)
  remote-install.sh --all                     Install every skill globally
  remote-install.sh <skill>... --project DIR  Install into DIR/.claude/skills instead
  remote-install.sh --ref BRANCH              Install from a branch/tag (default: main)
  remote-install.sh --list                    List available skills
  remote-install.sh -h | --help               Show this help
EOF
}

# --- parse args ---------------------------------------------------------------
names=()
all=0
list=0
project=""

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    --list) list=1; shift ;;
    --all) all=1; shift ;;
    --ref)
      [ $# -ge 2 ] || { echo "error: --ref needs a branch or tag" >&2; exit 1; }
      REF="$2"; shift 2 ;;
    --project)
      [ $# -ge 2 ] || { echo "error: --project needs a directory" >&2; exit 1; }
      project="$2"; shift 2 ;;
    --*) echo "error: unknown flag '$1'" >&2; usage; exit 1 ;;
    *) names+=("$1"); shift ;;
  esac
done

# --- locate a source tree -----------------------------------------------------
# Running from inside a checkout (script sits next to skills/)? Use it directly.
src_root=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]:-}" ]; then
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  [ -d "$script_dir/skills" ] && src_root="$script_dir"
fi

if [ -z "$src_root" ]; then
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  echo "fetching ${OWNER_REPO}@${REF}..."
  if git clone --quiet --depth 1 --branch "$REF" "$REPO_SSH" "$tmp/repo" 2>/dev/null; then
    :
  elif command -v gh >/dev/null 2>&1 \
    && gh repo clone "$OWNER_REPO" "$tmp/repo" -- --quiet --depth 1 --branch "$REF" 2>/dev/null; then
    :
  elif git clone --quiet --depth 1 --branch "$REF" "$REPO_HTTPS" "$tmp/repo" 2>/dev/null; then
    :
  else
    echo "error: could not clone ${OWNER_REPO} — the repo is private; set up an SSH key or run 'gh auth login'" >&2
    exit 1
  fi
  src_root="$tmp/repo"
fi

SKILLS_DIR="$src_root/skills"

if [ "$list" -eq 1 ]; then
  echo "Available skills:"
  for d in "$SKILLS_DIR"/*/; do
    [ -f "${d}SKILL.md" ] || continue
    echo "  - $(basename "$d")"
  done
  exit 0
fi

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

# --- copy ---------------------------------------------------------------------
for name in "${names[@]}"; do
  src="$SKILLS_DIR/$name"
  if [ ! -f "$src/SKILL.md" ]; then
    echo "skip: '$name' is not a skill (no skills/$name/SKILL.md)" >&2
    continue
  fi
  verb="installed"
  if [ -e "$target/$name" ] || [ -L "$target/$name" ]; then
    rm -rf "$target/$name"
    verb="updated"
  fi
  cp -R "$src" "$target/$name"
  echo "$verb: $target/$name"
done

echo "done. installed into: $target (copies — re-run to update)"
