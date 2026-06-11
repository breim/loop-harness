#!/bin/sh
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
AGENTS_DIR="$HOME/.claude/agents"

mkdir -p "$SKILLS_DIR" "$AGENTS_DIR"

for skill in loop-check loop-init loop-review loop-engineering; do
  ln -sfn "$REPO_DIR/skills/$skill" "$SKILLS_DIR/$skill"
  echo "linked $SKILLS_DIR/$skill"
done

ln -sfn "$REPO_DIR/agents/loop-verifier.md" "$AGENTS_DIR/loop-verifier.md"
echo "linked $AGENTS_DIR/loop-verifier.md"

echo "Done. Open a new Claude Code session and type /loop-check to confirm the skills loaded."
