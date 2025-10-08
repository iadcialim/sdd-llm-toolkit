#!/bin/bash

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --ai)
      AI_OPTION="$2"
      shift 2
      ;;
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

# Validate required parameters
if [[ "$AI_OPTION" != "amazonq" && "$AI_OPTION" != "copilot" ]]; then
  echo "Error: --ai must be either 'amazonq' or 'copilot'"
  echo "Usage: $0 --ai <amazonq|copilot> [--target <directory>]"
  exit 1
fi

# Set default target if not provided
if [[ -z "$TARGET_DIR" ]]; then
  TARGET_DIR="."
fi

# Clone repository to temp directory
SDD_LLM_TOOLKIT="sdd-llm-toolkit"
TEMP_DIR=$(mktemp -d)
echo "Cloning repository to $TEMP_DIR"

cd "$TEMP_DIR"
git clone --depth 1 https://github.com/firstcommit730/$SDD_LLM_TOOLKIT.git
cd $SDD_LLM_TOOLKIT

# Execute installation based on AI option
if [[ "$AI_OPTION" == "amazonq" ]]; then
  mkdir -p ~/.aws/amazonq/prompts
  cp prompts/*.md ~/.aws/amazonq/prompts/
elif [[ "$AI_OPTION" == "copilot" ]]; then
  mkdir -p .github/prompts
  for file in prompts/*.md; do
    cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"
  done
  
fi

# Copy SpecKit's .specify directory to target
cp -rf .specify "$TARGET_DIR"

# Cleanup
rm -rf "$TEMP_DIR/$SDD_LLM_TOOLKIT"

echo "Installation completed for $AI_OPTION"