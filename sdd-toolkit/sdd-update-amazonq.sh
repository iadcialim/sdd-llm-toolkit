#!/usr/bin/env bash
#
# sdd-update-amazonq.sh
# Update Amazon Q Developer prompts and .specify directory from the SDD toolkit repository
#
# Usage: ./sdd-update-amazonq.sh
#

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🔄 Updating Amazon Q Developer SDD Toolkit...${NC}"

# Create temporary directory
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

echo -e "${YELLOW}📥 Cloning latest version from GitHub...${NC}"
cd "$TMP_DIR"
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git

# Create Amazon Q prompts directory if it doesn't exist
AMAZONQ_DIR="$HOME/.aws/amazonq"
mkdir -p "$AMAZONQ_DIR/prompts"

# Backup existing files if they exist
if [ "$(ls -A $AMAZONQ_DIR/prompts 2>/dev/null)" ]; then
    echo -e "${YELLOW}📦 Backing up existing prompts...${NC}"
    BACKUP_DIR="$AMAZONQ_DIR/prompts.backup.$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    cp -r "$AMAZONQ_DIR/prompts"/* "$BACKUP_DIR/" 2>/dev/null || true
    echo -e "${GREEN}✓ Backup created at: $BACKUP_DIR${NC}"
fi

# Remove old prompt files
echo -e "${YELLOW}🗑️  Removing old prompt files...${NC}"
rm -rf "$AMAZONQ_DIR/prompts"/*.md 2>/dev/null || true

# Copy new prompts
echo -e "${YELLOW}📝 Copying new prompt files...${NC}"
for file in "$TMP_DIR"/sdd-llm-toolkit/prompts/*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        cp "$file" "$AMAZONQ_DIR/prompts/$filename"
        echo -e "${GREEN}  ✓ ${filename}${NC}"
    fi
done

# Update .specify directory (preserve memory folder)
echo -e "${YELLOW}📂 Updating .specify directory...${NC}"

# Check if .specify exists and use appropriate method
if [ ! -d "$AMAZONQ_DIR/.specify" ]; then
    # First time install - copy everything
    cp -r "$TMP_DIR"/sdd-llm-toolkit/.specify "$AMAZONQ_DIR/"
    echo -e "${GREEN}  ✓ Installed .specify directory${NC}"
else
    # Update existing - preserve memory folder using rsync
    rsync -av --exclude='memory/' "$TMP_DIR"/sdd-llm-toolkit/.specify/ "$AMAZONQ_DIR/.specify/"
    echo -e "${GREEN}  ✓ Updated .specify directory (preserved memory folder)${NC}"
fi

# Make scripts executable
chmod +x "$AMAZONQ_DIR/.specify/scripts/bash"/*.sh 2>/dev/null || true

# Create reference directory if it doesn't exist
mkdir -p "$AMAZONQ_DIR/.specify/reference"

# Update sdd-toolkit directory
rm -rf "$AMAZONQ_DIR/sdd-toolkit" 2>/dev/null || true
cp -r "$TMP_DIR"/sdd-llm-toolkit/sdd-toolkit "$AMAZONQ_DIR/"
echo -e "${GREEN}  ✓ Updated sdd-toolkit directory${NC}"

echo -e "${GREEN}✅ Amazon Q Developer SDD Toolkit updated successfully!${NC}"
echo ""
echo -e "${YELLOW}📋 Updated components:${NC}"
echo -e "  • Prompts: ~/.aws/amazonq/prompts/*.md"
echo -e "  • Templates: ~/.aws/amazonq/.specify/templates/"
echo -e "  • Scripts: ~/.aws/amazonq/.specify/scripts/"
echo -e "  • Update scripts: ~/.aws/amazonq/sdd-toolkit/"
echo -e "  • Preserved: ~/.aws/amazonq/.specify/memory/ (constitution & audits)"
echo ""
echo -e "${YELLOW}💡 Next steps:${NC}"
echo -e "  1. Restart your IDE to reload the prompts"
echo -e "  2. Test with: @constitution"
echo -e "  3. Verify installation: ls -la ~/.aws/amazonq/prompts/"
