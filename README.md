# LLM Specification Driven Development Toolkit

Vendor-neutral Specification Driven Development (SDD) workflow toolkit for collaborating with multiple AI coding assistants (currently Amazon Q Developer & GitHub Copilot) using consistent prompts and a spec→plan→tasks→implement loop.

## About

Specification Driven Development (SDD) is a methodology that shifts AI-assisted work upstream: you first create an explicit specification, then derive design artifacts, from which reproducible task lists are generated, and only then execute implementation. This toolkit packages that flow into portable markdown prompts and helper scripts for multiple Large Language Model (LLM) developer assistants.

## Key Features

Consistent, auditable, specification-first workflow across different AI assistants:

- Multi-vendor prompt distribution (Amazon Q + GitHub Copilot) with identical semantics
- Unified command-style verbs (`@specify`, `@plan`, `@tasks`, `@implement`, etc.)
- Reference folder mechanism (`@specify -ref <folder>`) to inject structured domain context across the entire workflow
- Slightly reworded title & docs to emphasize portability and neutrality
- Installation instructions show parallel vendor setup instead of single-platform GitHub Actions usage
- Keeps attribution, intent, and constitutional methodology from the original project

If you maintain or use another AI assistant, add support by placing these markdown prompt files into that tool's custom prompt directory or ingestion mechanism.

## Upstream Attribution

Inspired by and originally derived from the excellent upstream project: [github/spec-kit](https://github.com/github/spec-kit). This toolkit reworks distribution, naming, and multi-vendor support while retaining the spirit of the original specification-first workflow.

## Quick Start

1. **Install prompts:**

   **Amazon Q Developer (Global):**

   ```bash
   mkdir -p ~/.aws/amazonq/prompts && \
   cd /tmp && \
   git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git && \
   cp sdd-llm-toolkit/prompts/*.md ~/.aws/amazonq/prompts/ && \
   if [ ! -d ~/.aws/amazonq/.specify ]; then \
     rsync -av --exclude='memory/constitution.md' sdd-llm-toolkit/.specify/ ~/.aws/amazonq/.specify/; \
   else \
     rsync -av --exclude='memory/' sdd-llm-toolkit/.specify/ ~/.aws/amazonq/.specify/; \
   fi && \
   cp -r sdd-llm-toolkit/sdd-toolkit ~/.aws/amazonq/ && \
   rm -rf sdd-llm-toolkit
   ```

   **GitHub Copilot (Project-Local):**

   ```bash
   cd /tmp && \
   git clone --depth 1 https://github.com/firstcommit730/sdd-llm-toolkit.git && \
   cd - && \
   mkdir -p .github/prompts && \
   for file in /tmp/sdd-llm-toolkit/prompts/*.md; do \
     cp "$file" .github/prompts/"$(basename "$file" .md).prompt.md"; \
   done && \
   if [ ! -d .specify ]; then \
     rsync -av --exclude='memory/constitution.md' /tmp/sdd-llm-toolkit/.specify/ .specify/; \
   else \
     rsync -av --exclude='memory/' /tmp/sdd-llm-toolkit/.specify/ .specify/; \
   fi && \
   cp -r /tmp/sdd-llm-toolkit/sdd-toolkit . && \
   rm -rf /tmp/sdd-llm-toolkit
   ```

   See [INSTALL.md](./INSTALL.md) for detailed installation instructions.

2. **Start developing:**
   ```
   @specify Add user authentication system
   @plan
   @tasks
   @implement
   @audit
   ```

## Workflow Diagrams

### Standard Workflow

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   @specify  │───▶│    @plan     │───▶│   @tasks    │───▶│ @implement  │───▶│   @audit    │
│             │    │              │    │             │    │             │    │             │
│ Creates     │    │ Generates    │    │ Creates     │    │ Executes    │    │ Validates   │
│ spec.md     │    │ design docs  │    │ tasks.md    │    │ code        │    │ quality     │
└─────────────┘    └──────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

### Enhanced Workflow with Reference Context

```
┌─────────────────┐    ┌──────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    @specify     │───▶│    @plan     │───▶│   @tasks    │───▶│ @implement  │───▶│   @audit    │
│  -ref <folder>  │    │              │    │             │    │             │    │             │
│                 │    │              │    │             │    │             │    │             │
│ Loads reference │    │ Uses stored  │    │ Applies     │    │ Executes    │    │ Validates   │
│ folder ONCE     │    │ Reference    │    │ Reference   │    │ code        │    │ quality     │
│ Summarizes into │    │ Context from │    │ Context     │    │             │    │             │
│ spec.md         │    │ spec.md      │    │ patterns    │    │             │    │             │
└─────────────────┘    └──────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
        │                      │                   │
        ▼                      │                   │
┌─────────────────┐            │                   │
│ Reference       │            │                   │
│ Context Section │◀───────────┴───────────────────┘
│ in spec.md      │
│                 │  • Architecture & Patterns
│ Stored ONCE,    │  • Code Examples & Interfaces
│ Used 3x         │  • Configuration & Setup
│                 │  • Testing Approaches
└─────────────────┘  • Referenced Files
```

## Example Commands

**Standard Workflow:**

```bash
@specify Add JWT-based user authentication with login/logout
@plan
@tasks
@implement
@audit
```

**Enhanced with Reference Context:**

```bash
# 1. Create reference folder with requirements (optional - can be done once and reused)
mkdir -p .specify/reference/user-authentication
# Edit .specify/reference/user-authentication/README.md with requirements

# 2. Create specification with reference context
@specify Add JWT-based user authentication with login/logout -ref user-authentication

# 3. Generate plan (uses Reference Context from spec, no re-loading)
@plan

# 4. Create tasks (uses Reference Context from spec, no re-loading)
@tasks

# 5. Execute implementation
@implement

# 6. Validate implementation quality
@audit
```

This generates design documents, creates a task list, and implements the feature following your project's constitutional principles. Reference folders in `.specify/reference/` provide structured context that is loaded once during specification and reused throughout the workflow.

## Reference Context System

The toolkit uses an optimized reference context system that **loads once and reuses**:

### How It Works

1. **During `@specify -ref <folder>`**:

   - Loads all files from `.specify/reference/<folder>/`
   - Extracts and categorizes insights:
     - Architecture & Patterns
     - Code Examples & Interfaces
     - Configuration & Setup
     - Testing Approaches
   - Stores comprehensive summary in spec.md's **Reference Context** section

2. **During `@plan` and `@tasks`**:
   - Reads the Reference Context section from spec.md
   - Uses pre-analyzed insights without re-loading files
   - 50-70% faster with consistent context across stages

### Benefits

- **Performance**: Files loaded once instead of 3 times (67% reduction)
- **Consistency**: Single source of truth across all stages
- **Transparency**: All insights documented and reviewable in spec.md
- **Efficiency**: Reduced token usage and faster execution

### Creating Reference Folders

Create structured requirement folders to enhance your workflow:

```bash
# Create folder structure
mkdir -p .specify/reference/your-domain-name

# Create README.md with requirements
cat > .specify/reference/your-domain-name/README.md << 'EOF'
# Your Domain Requirements

## Primary User Story
As a [user], I want [goal] so that [benefit].

## Acceptance Criteria
- [ ] Must have: [requirement]
- [ ] Should have: [requirement]

## Key Entities
- **Entity1**: fields, relationships
- **Entity2**: fields, relationships

## Technical Constraints
- Performance: [requirements]
- Security: [requirements]
EOF

# Use in workflow
@specify Your feature description -ref your-domain-name
```

## Available Prompts

| Prompt          | Purpose                                                        | Usage                                                              |
| --------------- | -------------------------------------------------------------- | ------------------------------------------------------------------ |
| `@constitution` | Create/update project constitution with versioning             | `@constitution`                                                    |
| `@drift`        | Detect constitutional drift and generate realignment TODO list | `@drift`                                                           |
| `@specify`      | Create feature specifications from descriptions                | `@specify <description>` or `@specify <description> -ref <folder>` |
| `@plan`         | Generate implementation plans and design artifacts             | `@plan`                                                            |
| `@tasks`        | Create dependency-ordered task breakdowns                      | `@tasks`                                                           |
| `@implement`    | Execute implementation following task plan                     | `@implement`                                                       |
| `@audit`        | Validate implementation against specification                  | `@audit`                                                           |

### Prompt Details

**Constitution Management**

- Manages project principles and governance
- Supports semantic versioning (MAJOR.MINOR.PATCH)
- Validates consistency across templates
- Generates sync impact reports

**Drift Detection**

- Detects drift between project state and constitutional requirements
- Identifies gaps and violations
- Prioritizes drift items by severity (Critical/High/Medium/Low)
- Includes security drift checks
- Generates `.specify/specs/CONSTITUTION_DRIFT.md` with realignment tasks
- Overwrites existing drift report on each run for fresh analysis

**Specification Creation**

- Creates feature branches automatically
- Supports reference context via `-ref <folder>`
- Generates structured spec.md with requirements
- Optimized: Loads reference files once, stores summary

**Implementation Planning**

- Generates multi-phase design artifacts
- Integrates constitutional requirements
- Uses Reference Context from spec (no re-loading)
- Creates: research.md, data-model.md, contracts/, quickstart.md

**Task Generation**

- Dependency-ordered task lists (TDD approach)
- Marks parallel tasks with [P]
- Uses Reference Context patterns
- Phase-based: Setup → Tests → Core → Integration → Polish

**Implementation Execution**

- Executes tasks in dependency order
- Marks completed tasks as [X]
- Respects parallel vs sequential constraints
- Progress tracking and error handling

**Implementation Audit**

- Validates implementation against specification after `@implement`
- Checks requirements coverage, acceptance criteria, task completion
- Audits code quality, testing, error handling, and security
- Calculates compliance metrics (requirements %, task %, test coverage)
- Identifies issues by severity (Critical/High/Medium/Low)
- Generates quality scores and production readiness assessment
- Creates feature-specific `AUDIT.md` in `.specify/specs/<feature>/`
- Overwrites existing audit report on each run for fresh validation

## Documentation

- [Installation Guide](./INSTALL.md)
- [Usage Guide](./PROMPTS_HOWTO.md)
- [Prompt Summary](./PROMPTS_SUMMARY.md)
- [Update Scripts](./sdd-toolkit/README.md)

## Automated Updates

The `sdd-toolkit/` directory contains automated update scripts to keep your installation current:

- **Update Scripts**: `sdd-update-copilot.sh`, `sdd-update-amazonq.sh`

Scripts can be run directly from GitHub using curl, or locally if you've cloned the repository. See [sdd-toolkit/README.md](./sdd-toolkit/README.md) for details.

## Credits

This work is based on the original [Spec-Kit](https://github.com/github/spec-kit) by GitHub. All credit for the methodology and workflow design goes to the original authors.

## License

Same as original Spec-Kit project.
