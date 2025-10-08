#!/bin/bash

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --target)
      TARGET_DIR="$2"
      shift 2
      ;;
    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

# Set default target if not provided
if [[ -z "$TARGET_DIR" ]]; then
  TARGET_DIR="."
fi

# Clone repository to temp directory
SDD_LLM_TOOLKIT="sdd-llm-toolkit"
TEMP_DIR=$(mktemp -d)
echo "Cloning repository to $TEMP_DIR/$SDD_LLM_TOOLKIT"

cd "$TEMP_DIR"
git clone --depth 1 https://github.com/firstcommit730/$SDD_LLM_TOOLKIT.git
cd $SDD_LLM_TOOLKIT

# Copy prompts for Amazon Q
mkdir -p ~/.aws/amazonq/prompts
cp prompts/*.md ~/.aws/amazonq/prompts/

ls -al 

echo "Copying files to $TARGET_DIR"
# Copy SpecKit's .specify directory to target
cp -rf .specify "$TARGET_DIR"

# Cleanup
echo "Deleting $TEMP_DIR/$SDD_LLM_TOOLKIT"
rm -rf "$TEMP_DIR/$SDD_LLM_TOOLKIT"

echo "Installation completed for Amazon Q"