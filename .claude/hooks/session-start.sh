#!/bin/bash
set -euo pipefail

# Only run in remote Claude Code web sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

mkdir -p "$HOME/.claude/skills"

for skill_dir in "$CLAUDE_PROJECT_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  target="$HOME/.claude/skills/$skill_name"
  # Remove stale symlink so ln -s doesn't fail under set -e
  if [ -L "$target" ] && [ ! -e "$target" ]; then
    rm "$target"
  fi
  if [ ! -e "$target" ]; then
    ln -s "$skill_dir" "$target"
    echo "Installed skill: $skill_name"
  fi
done
