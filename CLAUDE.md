# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

IndieDevHQ is a comprehensive AI-augmented solo development methodology framework. This repository serves as both a knowledge base and automation suite for indie developers seeking to optimize their workflow through AI assistance and systematic project management.

## Architecture and Structure

### Primary Components

- **`indie-dev-methodologies/`**: Core methodology framework with AI-augmented workflows
- **`dev-notebooks/`**: Development notebooks and planning documents
  - `ai-workflows/`: AI integration patterns and workflow documentation
  - `apple-development/`: Apple ecosystem development guides and certification paths
  - `ide-configs/`: Development environment configurations (VS Code, Cursor, Xcode)

### Key Scripts and Automation

All scripts are located in `indie-dev-methodologies/scripts/`:

```bash
# Project initialization for various platforms
./indie-dev-methodologies/scripts/init-project.sh <project-name> [tauri|swift|web|electron] [target-directory]

# Repository quality and conformity validation
./indie-dev-methodologies/scripts/check-conformity.sh [project-directory] [verbose]

# Automated documentation generation
./indie-dev-methodologies/scripts/generate-docs.py [project-directory]

# GitHub automation and repository setup
./indie-dev-methodologies/scripts/gh-automation.sh [repo-path] [repo-name] [public|private]

# GitHub issues synchronization
./indie-dev-methodologies/scripts/sync-stories-to-issues.sh [repo-path] [dry-run]

# Development metrics dashboard
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
- **`documentation/`**: Standard documentation templates

### Supported Project Types
- **Tauri**: Cross-platform desktop applications (HTML/CSS/JS frontend + Rust backend)
- **Swift**: Native Apple ecosystem applications and CLI tools
- **Electron**: Legacy desktop applications (maintenance mode)
- **Web**: Modern web applications with framework flexibility

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

## Common Development Workflows

### Initialize New Project
```bash
# Create Tauri desktop application
./indie-dev-methodologies/scripts/init-project.sh MyApp tauri ~/Projects

# Create Swift CLI tool or macOS app
./indie-dev-methodologies/scripts/init-project.sh MyTool swift ~/Projects

# Validate project structure
./indie-dev-methodologies/scripts/check-conformity.sh ~/Projects/MyApp
```

### GitHub Integration Setup
```bash
# Complete GitHub repository setup with automation
./indie-dev-methodologies/scripts/gh-automation.sh ~/Projects/MyApp MyApp public

# Sync project documentation to GitHub issues
./indie-dev-methodologies/scripts/sync-stories-to-issues.sh ~/Projects/MyApp false
```

### Documentation Generation
```bash
# Generate comprehensive project documentation
./indie-dev-methodologies/scripts/generate-docs.py ~/Projects/MyApp
```

## Important Context

### Current Development Phase
**Repository Status:** Phase 3 (Documentation Enhancement) - MKDocs Implementation  
**Priority:** Transforming into professional, searchable community resource  
**Target:** GitHub Pages deployment at `https://macjunkins.github.io/IndieDevHQ/`

### Project Independence Model
Each project folder is designed as a completely independent git repository:
- IndieDevHQ provides methodology templates and automation
- Individual projects maintain their own GitHub repositories and lifecycles
- Projects reference IndieDevHQ patterns conceptually, not through file dependencies

### Technology Focus Areas
- **Primary**: Swift for Apple ecosystem, modern web frameworks
- **Secondary**: Tauri + Rust for cross-platform desktop applications
- **Documentation**: MKDocs with Material theme for community site
- **Web**: Modern frameworks with IndieDevHQ methodology integration

### Development Environment
- **Primary Platform**: macOS (Apple Silicon/Intel)
- **Code Editor**: VS Code/Cursor with AI extensions (configurations in `dev-notebooks/ide-configs/`)
- **Terminal**: Warp with integrated AI assistance
- **Version Control**: Git with GitHub CLI automation
- **Documentation**: MKDocs with GitHub Pages CI/CD

### MKDocs Implementation Strategy
**Current Focus:** Implementing comprehensive documentation site structure:
- `docs/` directory with organized methodology framework
- Material theme with navigation tabs and search
- Automated GitHub Pages deployment
- Content migration from existing repository structure
- Professional presentation for community adoption

This methodology framework accelerates solo development through systematic AI integration while maintaining professional code quality and project organization standards.