# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

IndieDevHQ is a comprehensive AI-augmented solo development methodology framework. This repository serves as both a knowledge base and automation suite for indie developers seeking to optimize their workflow through AI assistance and systematic project management.

## Architecture and Structure

### Primary Components

- **`indie-dev-methodologies/`**: Core methodology framework with AI-augmented workflows organized into 6 main sections
- **`docs/`**: MKDocs-powered documentation site for GitHub Pages deployment
- **`dev-notebooks/`**: Development notebooks and planning documents
- **`session-logs/`**: Development session logs and progress tracking

### Key Directory Structure

```
indie-dev-methodologies/
├── 01_Core_Workflow/         # AI-augmented development workflows and conversation practices
├── 02_Documentation/         # Documentation standards and improvement features
├── 03_Implementation/        # Development tool integration and automation
├── 04_Quality_Security/      # Quality assurance and security architecture
├── 05_Project_Management/    # Project templates and management workflows
├── 06_API_Integration/       # API guides and integration patterns
├── scripts/                  # Production-ready automation scripts
└── templates/                # Project scaffolding and GitHub templates

docs/                         # MKDocs documentation site
├── methodologies/            # Core development methodologies
├── playbooks/               # AI prompting and coding playbooks
├── patterns/                # AI integration patterns
├── automation/              # Scripts and GitHub integration
└── standards/               # Quality and conformity standards
```

## Common Commands

### Documentation Site (MKDocs)
```bash
# Install dependencies
pip install -r requirements.txt

# Serve documentation locally
mkdocs serve

# Build documentation site
mkdocs build

# Deploy to GitHub Pages
mkdocs gh-deploy
```

### Project Automation Scripts
All scripts are located in `indie-dev-methodologies/scripts/`:

```bash
# Initialize new project (supports tauri, swift, web, electron)
./indie-dev-methodologies/scripts/init-project.sh <project-name> [project-type] [target-directory]

# Validate repository conformity and quality
./indie-dev-methodologies/scripts/check-conformity.sh [project-directory] [verbose]

# Generate comprehensive project documentation
./indie-dev-methodologies/scripts/generate-docs.py [project-directory]

# Setup GitHub repository with full automation
./indie-dev-methodologies/scripts/gh-automation.sh [repo-path] [repo-name] [public|private]

# Sync project documentation to GitHub issues
./indie-dev-methodologies/scripts/sync-stories-to-issues.sh [repo-path] [dry-run]

# Generate development metrics dashboard
./indie-dev-methodologies/scripts/dev-metrics.py [project-directory]
```

## Development Philosophy

### Core Principles
- **Tool Orchestration**: "No one tool does it all. Orchestrate a stack. Own your flow."
- **AI-Augmented Workflows**: Systematic integration of AI tools (Claude, ChatGPT, GitHub Copilot) as force multipliers
- **Documentation-First**: Comprehensive planning captured in markdown with AI-optimized structure
- **Cross-Platform Native**: Focus on Tauri + Rust for desktop applications, Swift for Apple ecosystem
- **Self-Contained Projects**: Each project repository maintains independent lifecycle and GitHub presence

### AI Integration Strategy
- **Strategic AI**: Claude/ChatGPT for architecture, planning, documentation (system prompts in `01_Core_Workflow/prompts/`)
- **Tactical AI**: GitHub Copilot for inline code suggestions with CLAUDE.md context
- **Local AI**: LM Studio integration for offline development assistance
- **Specialized Assistants**: Jenny (business mentor) and Jeff (project manager) system prompts

## Template System

### Project Templates
Located in `indie-dev-methodologies/templates/`:
- **`project/`**: Base project structures for all supported platforms
- **`github/`**: GitHub issue templates (bug reports, feature requests, tasks)
- **`automation/`**: CI/CD workflows for different project types

### Supported Project Types
- **Tauri**: Cross-platform desktop applications (HTML/CSS/JS frontend + Rust backend)
- **Swift**: Native Apple ecosystem applications and CLI tools
- **Web**: Modern web applications with framework flexibility
- **Electron**: Legacy desktop applications (maintenance mode)

## Quality Assurance Framework

### Repository Conformity Standards
All projects should include:
- `README.md` with project overview and setup instructions
- `CLAUDE.md` for AI assistance context and development guidance
- `.gitignore` with platform-appropriate exclusions
- GitHub templates in `.github/` directory
- Proper project structure for detected type

### Standard GitHub Labels
Automatically configured through `gh-automation.sh`:
- `enhancement`, `bug`, `documentation`, `automation`
- `priority-high/medium/low`
- `status-blocked`

## Technology Stack

### Documentation Platform
- **MKDocs**: Static site generator with Material theme
- **GitHub Pages**: Automated deployment via GitHub Actions
- **Material Theme**: Professional documentation appearance with navigation tabs and search

### Supported Development Platforms
- **Primary**: Swift for Apple ecosystem, modern web frameworks
- **Secondary**: Tauri + Rust for cross-platform desktop applications
- **Documentation**: MKDocs with Material theme for community site
- **Web**: Modern frameworks with IndieDevHQ methodology integration

## Current Development Phase

**Repository Status:** Phase 3 (Documentation Enhancement) - MKDocs Implementation  
**Priority:** Transforming into professional, searchable community resource  
**Target:** GitHub Pages deployment at `https://macjunkins.github.io/IndieDevHQ/`

### Project Independence Model
Each project folder is designed as a completely independent git repository:
- IndieDevHQ provides methodology templates and automation
- Individual projects maintain their own GitHub repositories and lifecycles
- Projects reference IndieDevHQ patterns conceptually, not through file dependencies

## Development Environment

- **Primary Platform**: macOS (Apple Silicon/Intel)
- **Code Editor**: VS Code/Cursor with AI extensions (configurations in `dev-notebooks/ide-configs/`)
- **Terminal**: Warp with integrated AI assistance
- **Version Control**: Git with GitHub CLI automation
- **Documentation**: MKDocs with GitHub Pages CI/CD

## Important Context

This methodology framework accelerates solo development through systematic AI integration while maintaining professional code quality and project organization standards. The repository serves as both a practical toolkit and comprehensive knowledge base for AI-augmented development workflows.