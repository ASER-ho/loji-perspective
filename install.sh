#!/usr/bin/env bash
# Loji Perspective Skill - One-click install
# https://github.com/ASER-ho/loji-perspective

set -e

SKILL_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}/loji-perspective"
REPO_URL="https://github.com/ASER-ho/loji-perspective.git"

echo "=== Loji Perspective Skill Installer ==="
echo ""

# Clone or update
if [ -d "$SKILL_DIR/.git" ]; then
    echo "[1/3] Updating existing installation..."
    cd "$SKILL_DIR"
    git pull origin master
else
    echo "[1/3] Cloning to $SKILL_DIR ..."
    git clone "$REPO_URL" "$SKILL_DIR"
    cd "$SKILL_DIR"
fi

# Initialize memory file
echo "[2/3] Setting up local memory..."
if [ ! -f "$SKILL_DIR/memory.md" ]; then
    cp "$SKILL_DIR/memory.template.md" "$SKILL_DIR/memory.md"
    echo "       memory.md created from template."
else
    echo "       memory.md already exists — skipping."
fi

# Verify
echo "[3/3] Verifying installation..."
if [ -f "$SKILL_DIR/SKILL.md" ]; then
    SKILL_LINES=$(wc -l < "$SKILL_DIR/SKILL.md")
    echo "       SKILL.md: $SKILL_LINES lines"
    echo "       memory.md: $( [ -f "$SKILL_DIR/memory.md" ] && echo 'present' || echo 'missing' )"
    echo "       references/: $(ls "$SKILL_DIR/references/" 2>/dev/null | wc -l | tr -d ' ') files"
    echo "       evals/: $(ls "$SKILL_DIR/evals/" 2>/dev/null | wc -l | tr -d ' ') files"
    echo "       examples/: $(ls "$SKILL_DIR/examples/" 2>/dev/null | wc -l | tr -d ' ') files"
    echo ""
    echo "=== Installation complete ==="
    echo "Try: '征酱，你好' in a new conversation"
else
    echo "ERROR: SKILL.md not found. Installation may have failed."
    exit 1
fi
