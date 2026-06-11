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
  if [ ! -e "$target" ]; then
    ln -s "$skill_dir" "$target"
    echo "Installed skill: $skill_name"
  fi
done
