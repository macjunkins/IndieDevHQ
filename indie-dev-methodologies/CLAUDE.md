# CLAUDE.md - IndieDevHQ Methodology Framework

This file provides guidance to Claude Code when working with the IndieDevHQ methodology framework.

## Repository Overview

This is the **IndieDevHQ methodology framework** - a comprehensive knowledge base for AI-augmented solo software development. It serves as the primary methodology hub for the consolidated workspace.

## Architecture and Structure

### Directory Organization

- **01_Core_Workflow/**: AI-augmented development workflows and conversation practices
- **02_Documentation/**: Documentation standards and improvement features  
- **03_Implementation/**: Development tool integration and automation
- **04_Quality_Security/**: Quality assurance and security architecture
- **05_Project_Management/**: Project templates and management workflows
- **06_API_Integration/**: API guides and integration patterns
- **templates/**: Reusable project templates and scaffolds
- **scripts/**: Automation scripts for project initialization and management
- **.github/**: GitHub templates and workflow configurations

### Key Scripts

All scripts in `scripts/` directory are executable and ready for use:

```bash
# Project initialization
./scripts/init-project.sh <project-name> [tauri|electron|web] [target-directory]

# Repository conformity checking  
./scripts/check-conformity.sh [project-directory] [verbose]

# Documentation generation
./scripts/generate-docs.py [project-directory]

# GitHub automation setup
./scripts/gh-automation.sh [repo-path] [repo-name] [public|private]

# Story/task synchronization to GitHub issues
./scripts/sync-stories-to-issues.sh [repo-path] [dry-run]
```

## Development Philosophy

### Core Principles
- **AI-Assisted Workflows**: Extensive integration with Claude, ChatGPT, and local AI models
- **Documentation-First**: Comprehensive planning and knowledge capture
- **Prototype-Driven**: Build proof-of-concepts before full implementation
- **Multi-Platform**: Focus on macOS with cross-platform considerations
- **Tool Orchestration**: Use best tool for each job, integrate seamlessly

### Project Management Approach
- Strategic planning captured in markdown documents
- GitHub project management templates for task tracking
- AI system prompts for specialized assistance roles in `01_Core_Workflow/prompts/`
- Extensive use of templates and checklists in `templates/`

## Common Development Tasks

### Initialize New Project
```bash
# Create new Tauri project
./scripts/init-project.sh my-app tauri ~/Projects

# Create new web project
./scripts/init-project.sh my-webapp web ~/Projects

# Check project conformity
./scripts/check-conformity.sh ~/Projects/my-app
```

### GitHub Integration
```bash
# Set up GitHub repository with automation
./scripts/gh-automation.sh ~/Projects/my-app my-app public

# Sync project tasks to GitHub issues
./scripts/sync-stories-to-issues.sh ~/Projects/my-app false
```

### Documentation
```bash
# Generate project documentation
./scripts/generate-docs.py ~/Projects/my-app
```

## Template System

### Project Templates
- Located in `templates/project/`
- Includes GitHub repository structure template
- Supports Tauri, Electron, and web projects

### GitHub Templates
- Located in `templates/github/` 
- Bug report, feature request, and task templates
- Workflow templates for different project types in `.github/workflows/`

### System Prompts
- Located in `01_Core_Workflow/prompts/`
- Business mentor (Jenny) and project manager (Jeff) AI assistants
- Ready for use with AI development workflows

## Quality Assurance

### Standard GitHub Labels
The framework automatically sets up these standard labels:
- `enhancement` - New features
- `bug` - Issues and fixes
- `documentation` - Documentation improvements  
- `automation` - Automated processes
- `priority-high/medium/low` - Priority levels
- `status-blocked` - Blocked items

### Repository Conformity
All projects should include:
- README.md with project overview
- CLAUDE.md for AI assistance context
- .gitignore with appropriate patterns
- GitHub templates in `.github/` directory
- Proper project structure for detected type (Tauri/Electron/Web)

## AI Integration Points

### Local Development
- System prompts for specialized AI assistants
- Templates optimized for AI code generation
- Automated documentation generation
- Intelligent project initialization

### GitHub Integration  
- Automated issue creation from documentation
- Standard label management
- CI/CD workflows for different project types
- Pull request and issue templates

## Important Context

- **Created**: August 11, 2025 (Phase 2 implementation)
- **Framework**: IndieDevHQ methodology for solo developers
- **AI-Optimized**: Structured for efficient AI assistance
- **Multi-Project**: Supports Tauri, Electron, and web applications
- **GitHub-Integrated**: Full GitHub automation and project management

This methodology framework is designed to accelerate development through AI assistance while maintaining high code quality and project organization standards.