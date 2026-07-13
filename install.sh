#!/usr/bin/env bash
# Loji Perspective Skill - Installer
# https://github.com/ASER-ho/loji-perspective
#
# Pinned to v0.3.1. DO NOT pipe from curl to bash on mutable master.
# Download this script, review it, then run it.

set -e

SKILL_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}/loji-perspective"
REPO_URL="https://github.com/ASER-ho/loji-perspective.git"
PINNED_TAG="v0.3.1"

echo "=== Loji Perspective Skill Installer ==="
echo "Version: $PINNED_TAG"
echo "Target:  $SKILL_DIR"
echo ""

# Clone or update
if [ -d "$SKILL_DIR/.git" ]; then
    echo "[1/3] Updating existing installation..."
    cd "$SKILL_DIR"
    git fetch origin tag "$PINNED_TAG" 2>/dev/null || true
    git checkout "$PINNED_TAG" 2>/dev/null || git pull origin master
else
    echo "[1/3] Cloning $PINNED_TAG to $SKILL_DIR ..."
    git clone --branch "$PINNED_TAG" "$REPO_URL" "$SKILL_DIR" 2>/dev/null || \
    git clone "$REPO_URL" "$SKILL_DIR"
    cd "$SKILL_DIR"
    git checkout "$PINNED_TAG" 2>/dev/null || true
fi

# Initialize memory file
echo "[2/3] Setting up local memory..."
if [ ! -f "$SKILL_DIR/memory.md" ]; then
    cp "$SKILL_DIR/memory.template.md" "$SKILL_DIR/memory.md"
    echo "       memory.md created from template."
else
    echo "       memory.md already exists — skipping."
fi

# Installation summary (not verification)
echo "[3/3] Installation summary..."
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
    echo ""
    echo "Note: This is an installation summary, not a security verification."
    echo "For full validation, run the eval suite: see evals/RUBRIC.md"
else
    echo "ERROR: SKILL.md not found. Installation may have failed."
    exit 1
fi
