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
    echo "[1/3] Updating existing installation to $PINNED_TAG..."
    cd "$SKILL_DIR"
    git fetch origin tag "$PINNED_TAG" || {
        echo "ERROR: Cannot fetch tag $PINNED_TAG. Check network and try again."
        exit 1
    }
    git checkout --detach "$PINNED_TAG" || {
        echo "ERROR: Tag $PINNED_TAG not found on remote."
        echo "This installer is pinned to a specific version for safety."
        echo "To install the latest development version, use manual install:"
        echo "  git clone $REPO_URL $SKILL_DIR"
        exit 1
    }
else
    echo "[1/3] Cloning $PINNED_TAG to $SKILL_DIR ..."
    git clone --branch "$PINNED_TAG" --depth 1 "$REPO_URL" "$SKILL_DIR" || {
        echo "ERROR: Cannot clone tag $PINNED_TAG."
        echo "The tag may not exist yet on GitHub. Check:"
        echo "  git ls-remote --tags $REPO_URL"
        exit 1
    }
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
