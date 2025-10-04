# LLM Specification Driven Development Toolkit - Installation Guide

A vendor-neutral installation guide for setting up SDD prompts with Amazon Q Developer and GitHub Copilot.

## Quick Install

### Amazon Q Developer (Global Installation)

Install prompts and `.specify/` directory globally for Amazon Q Developer. Copy and paste this command:

```bash
mkdir -p ~/.aws/amazonq/prompts && \
cd /tmp && \
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git && \
cp sdd-llm-toolkit/prompts/*.md ~/.aws/amazonq/prompts/ && \
if [ ! -d ~/.aws/amazonq/.specify ]; then \
  cp -r sdd-llm-toolkit/.specify ~/.aws/amazonq/; \
else \
  rsync -av --exclude='memory/' sdd-llm-toolkit/.specify/ ~/.aws/amazonq/.specify/; \
fi && \
cp -r sdd-llm-toolkit/sdd-toolkit ~/.aws/amazonq/ && \
rm -rf sdd-llm-toolkit && \
echo "✅ Amazon Q prompts, .specify directory, and sdd-toolkit installed successfully!"
```

**What this does:**

- Creates `~/.aws/amazonq/prompts/` directory
- Clones the latest toolkit from GitHub
- Copies all prompt files (`.md`)
- Copies the complete `.specify/` directory structure (preserves existing `memory/` folder if present)
- Copies the `sdd-toolkit/` directory (update scripts and documentation)
- Cleans up temporary files
- Provides confirmation message

### GitHub Copilot (Project-Local Installation)

Install prompts and `.specify/` directory in your current project. Navigate to your project directory first, then copy and paste this command:

```bash
cd /tmp && \
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git && \
cd - && \
mkdir -p .github/prompts && \
for file in /tmp/sdd-llm-toolkit/prompts/*.md; do \
  cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"; \
done && \
if [ ! -d .specify ]; then \
  cp -r /tmp/sdd-llm-toolkit/.specify .; \
else \
  rsync -av --exclude='memory/' /tmp/sdd-llm-toolkit/.specify/ .specify/; \
fi && \
cp -r /tmp/sdd-llm-toolkit/sdd-toolkit . && \
rm -rf /tmp/sdd-llm-toolkit && \
echo "✅ GitHub Copilot prompts, .specify directory, and sdd-toolkit installed successfully!"
```

**What this does:**

- Clones the latest toolkit from GitHub
- Creates `.github/prompts/` directory in your project
- Copies all prompt files with `.prompt.md` extension (Copilot requirement)
- Copies the complete `.specify/` directory structure to your project (preserves existing `memory/` folder if present)
- Copies the `sdd-toolkit/` directory (update scripts and documentation)
- Cleans up temporary files
- Provides confirmation message

## Local Install (From Cloned Repository)

If you've already cloned this repository locally, run these commands from the toolkit repository directory:

### Amazon Q Developer

Install prompts globally for Amazon Q Developer:

```bash
mkdir -p ~/.aws/amazonq/prompts && \
cp prompts/*.md ~/.aws/amazonq/prompts/ && \
if [ ! -d ~/.aws/amazonq/.specify ]; then \
  cp -r .specify ~/.aws/amazonq/; \
else \
  rsync -av --exclude='memory/' .specify/ ~/.aws/amazonq/.specify/; \
fi && \
cp -r sdd-toolkit ~/.aws/amazonq/ && \
echo "✅ Amazon Q prompts, .specify directory, and sdd-toolkit installed successfully!"
```

**Note:** This command preserves your existing `.specify/memory/` directory (including `constitution.md`) if it already exists.

### GitHub Copilot (Install to Your Project)

Navigate to your target project directory, then run this command (replace `/path/to/sdd-llm-toolkit` with the actual path to this cloned repository):

```bash
TOOLKIT_PATH="/path/to/sdd-llm-toolkit" && \
mkdir -p .github/prompts && \
for file in "$TOOLKIT_PATH"/prompts/*.md; do \
  cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"; \
done && \
if [ ! -d .specify ]; then \
  cp -r "$TOOLKIT_PATH/.specify" .; \
else \
  rsync -av --exclude='memory/' "$TOOLKIT_PATH/.specify/" .specify/; \
fi && \
cp -r "$TOOLKIT_PATH/sdd-toolkit" . && \
echo "✅ GitHub Copilot prompts, .specify directory, and sdd-toolkit installed successfully!"
```

**Note:**

- Replace `/path/to/sdd-llm-toolkit` with the actual path to the cloned toolkit repository
- This installs prompts to `.github/prompts/` (Copilot requirement), `.specify/`, and `sdd-toolkit/` in your project
- Preserves existing `.specify/memory/` directory (including `constitution.md`) if it already exists
- Does NOT copy the `prompts/` folder to your project

## Manual Install

**For Amazon Q Developer:**

Run from the toolkit repository directory:

```bash
mkdir -p ~/.aws/amazonq/prompts
cp prompts/*.md ~/.aws/amazonq/prompts/
cp -r .specify ~/.aws/amazonq/
cp -r sdd-toolkit ~/.aws/amazonq/
```

**For GitHub Copilot:**

Navigate to your target project, then run (replace `/path/to/sdd-llm-toolkit`):

```bash
TOOLKIT_PATH="/path/to/sdd-llm-toolkit" && \
mkdir -p .github/prompts && \
for file in "$TOOLKIT_PATH"/prompts/*.md; do \
  cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"; \
done && \
cp -r "$TOOLKIT_PATH/.specify" . && \
cp -r "$TOOLKIT_PATH/sdd-toolkit" . && \
echo "✅ GitHub Copilot prompts, .specify directory, and sdd-toolkit installed successfully!"
```

**Note:** Does NOT copy the `prompts/` folder to your project - only installs to `.github/prompts/`, `.specify/`, and `sdd-toolkit/`.

## Verify Installation

**Amazon Q Developer:**

```bash
ls -la ~/.aws/amazonq/prompts/
```

**GitHub Copilot:**

```bash
ls -la .github/prompts/
```

You should see the following prompts: `audit.md`, `constitution.md`, `drift.md`, `implement.md`, `plan.md`, `specify.md`, `tasks.md`

(Note: GitHub Copilot prompts will have `.prompt.md` extension)

## Quick Test

Type `@constitution` in your IDE to test the installation.

## Available Prompts

- `@audit` - Generate compliance audit and TODO list
- `@constitution` - Update project constitution with versioning
- `@drift` - Detect specification drift and validate implementation
- `@specify` - Create feature specifications from descriptions
- `@plan` - Generate implementation plans and design artifacts
- `@tasks` - Create dependency-ordered task breakdowns
- `@implement` - Execute implementation following task plan

## Prerequisites

- Amazon Q Developer or GitHub Copilot extension installed in your IDE
- Project with `.specify/` directory structure
- macOS, Linux, or WSL environment with zsh/bash shell access

## Project Structure

This toolkit requires the following directory structure:

```
.specify/
├── memory/              # Constitution and audit logs
├── reference/           # Domain context files (injected via @specify-reference)
├── scripts/bash/        # Helper scripts
└── templates/           # Markdown templates for prompts
```

The `.specify/` directory is automatically created when you first use the prompts.

## Next Steps

1. Read [PROMPTS_HOWTO.md](./PROMPTS_HOWTO.md) for detailed usage guide
2. Review [PROMPTS_SUMMARY.md](./PROMPTS_SUMMARY.md) for a quick reference
3. Start with: `@constitution` to set up project governance (optional)
4. Then: `@specify <your feature description>` to begin feature development
5. Follow the workflow: specify → plan → tasks → implement → audit

## Troubleshooting

**Prompts not found in Amazon Q:**

- Verify `~/.aws/amazonq/prompts/` directory exists
- Check file permissions: `chmod 644 ~/.aws/amazonq/prompts/*.md`
- Restart your IDE after installation

**Prompts not found in GitHub Copilot:**

- Ensure prompts are in `.github/prompts/` (project-local, not global)
- Verify files have `.prompt.md` extension
- Restart your IDE after installation

**Script errors:**

- Ensure you're in the project root directory
- Make scripts executable: `chmod +x .specify/scripts/bash/*.sh`
- Verify zsh or bash is available: `echo $SHELL`

**Permission denied:**

- Check directory permissions: `ls -la ~/.aws/amazonq/` or `ls -la .github/`
- Ensure you have write access to the target directories

## Uninstallation

**Remove Amazon Q prompts:**

```bash
rm -rf ~/.aws/amazonq/prompts
```

**Remove GitHub Copilot prompts:**

```bash
rm -rf .github/prompts
```

## Updating to Latest Version

### Using Update Scripts (Recommended)

The easiest way to update is using the automated update scripts:

**For GitHub Copilot:**

```bash
curl -sSL https://raw.githubusercontent.com/firstcommit730/sdd-llm-toolkit/main/sdd-toolkit/sdd-update-copilot.sh | bash
```

Or if you have the repository cloned:

```bash
./sdd-toolkit/sdd-update-copilot.sh
```

**For Amazon Q Developer:**

```bash
curl -sSL https://raw.githubusercontent.com/firstcommit730/sdd-llm-toolkit/main/sdd-toolkit/sdd-update-amazonq.sh | bash
```

Or if you have the repository cloned:

```bash
./sdd-toolkit/sdd-update-amazonq.sh
```

### Manual Update (From GitHub Repository)

#### Amazon Q Developer (Global)

Pull the latest prompts and update your global Amazon Q installation:

```bash
# Update Amazon Q prompts from repository
cd /tmp && \
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git && \
rm -rf ~/.aws/amazonq/prompts/*.md && \
cp sdd-llm-toolkit/prompts/*.md ~/.aws/amazonq/prompts/ && \
rm -rf ~/.aws/amazonq/.specify && \
cp -r sdd-llm-toolkit/.specify ~/.aws/amazonq/ && \
rm -rf ~/.aws/amazonq/sdd-toolkit && \
cp -r sdd-llm-toolkit/sdd-toolkit ~/.aws/amazonq/ && \
rm -rf sdd-llm-toolkit && \
echo "✅ Amazon Q prompts, .specify directory, and sdd-toolkit updated successfully!"
```

#### GitHub Copilot (Project-Local)

Pull the latest prompts and update your project's Copilot installation:

```bash
# Update GitHub Copilot prompts in current project
cd /tmp && \
git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git && \
cd - && \
rm -rf .github/prompts/*.prompt.md && \
mkdir -p .github/prompts && \
for file in /tmp/sdd-llm-toolkit/prompts/*.md; do \
  cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"; \
done && \
rm -rf .specify/templates .specify/scripts && \
cp -r /tmp/sdd-llm-toolkit/.specify/templates .specify/ && \
cp -r /tmp/sdd-llm-toolkit/.specify/scripts .specify/ && \
rm -rf sdd-toolkit && \
cp -r /tmp/sdd-llm-toolkit/sdd-toolkit . && \
rm -rf /tmp/sdd-llm-toolkit && \
echo "✅ GitHub Copilot prompts, .specify directory, and sdd-toolkit updated successfully!"
```

**Note:** The update commands will:

- Remove existing prompt files to avoid conflicts
- Pull the latest version from the repository
- **Preserve** your `.specify/memory/` directory (constitution and audits)
- Update `.specify/templates/` and `.specify/scripts/` to the latest versions
- Update `sdd-toolkit/` directory (update scripts and documentation)

**⚠️ Warning:** If you've customized any templates in `.specify/templates/`, back them up before updating, as they will be overwritten.

## Source Files

Prompt files are located at: `prompts/*.md`

All prompts are vendor-neutral markdown files that work with multiple AI assistants.

## Attribution

This toolkit is inspired by and derived from [github/spec-kit](https://github.com/github/spec-kit), adapted for multi-vendor support and portability.
