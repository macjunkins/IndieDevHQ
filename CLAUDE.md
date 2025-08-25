# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

IndieDevHQ is **John's personal AI development infrastructure** - tools, templates, and workflows for building applications (todge-tauri, ForgeDesk, etc.) with systematic AI assistance while maintaining professional code quality.

## Architecture and Structure

### Primary Components

- **`indie-dev-methodologies/`**: Personal AI workflows and development reference organized into 6 main sections
- **`dev-notebooks/`**: Personal development notes, IDE configurations, and Apple development workflows

### Key Directory Structure

```
indie-dev-methodologies/
├── 01_Core_Workflow/         # AI-augmented development workflows and conversation practices
├── 02_Documentation/         # Documentation standards and improvement features
├── 03_Implementation/        # Development tool integration and automation
├── 04_Quality_Security/      # Quality assurance and security architecture
├── 05_Project_Management/    # Project templates and management workflows
├── 06_API_Integration/       # API guides and integration patterns
├── scripts/                  # Personal automation tools (project init, quality checks)
└── templates/                # Project scaffolding and GitHub templates

dev-notebooks/                # Personal development infrastructure
├── apple-development/        # Apple ecosystem development workflows
└── ide-configs/              # VS Code, Xcode configuration and preferences
```

## Common Commands

### Personal Automation Scripts
All scripts located in `indie-dev-methodologies/scripts/` for productive development workflow:

```bash
# Initialize new project with full setup
./indie-dev-methodologies/scripts/init-project.sh <project-name> [tauri|swift|web] [target-directory]

# Validate repository quality and conformity  
./indie-dev-methodologies/scripts/check-conformity.sh [project-directory] [verbose]

# Generate project documentation
./indie-dev-methodologies/scripts/generate-docs.py [project-directory]

# Setup GitHub repository with automation
./indie-dev-methodologies/scripts/gh-automation.sh [repo-path] [repo-name] [public|private]

# Sync project tasks to GitHub issues
./indie-dev-methodologies/scripts/sync-stories-to-issues.sh [repo-path] [dry-run]

# Development metrics and analytics
./indie-dev-methodologies/scripts/dev-metrics.py [project-directory]
```

## Development Philosophy

### Core Principles
- **Tool Orchestration**: "No one tool does it all. Orchestrate a stack. Own your flow."
- **AI-Augmented Workflows**: Systematic integration of AI tools (Claude, ChatGPT, GitHub Copilot) for personal productivity
- **Documentation-First**: Professional planning and knowledge capture for quality code standards
- **Cross-Platform Focus**: Tauri + Rust for desktop applications, Swift for Apple ecosystem
- **Project Independence**: Each application maintains independent lifecycle and professional appearance

### Personal AI Integration
- **Strategic AI**: Claude/ChatGPT for architecture, planning, documentation (system prompts in `01_Core_Workflow/prompts/`)
- **Tactical AI**: GitHub Copilot for inline code suggestions with CLAUDE.md context
- **Specialized Assistants**: Jenny (business mentor) and Jeff (project manager) for development guidance
- **Personal Productivity**: AI workflows optimized for building todge-tauri, ForgeDesk, etc.

## Personal Template System

### Project Templates
Located in `indie-dev-methodologies/templates/`:
- **`project/`**: Personal project scaffolding for consistent structure
- **`github/`**: Issue templates (bug reports, feature requests, tasks)

### Supported Project Types for Personal Development
- **Tauri**: Cross-platform desktop applications (todge-tauri, phoenix-usb-flasher)
- **Swift**: Apple ecosystem applications (ForgeDesk, Cashly)
- **Web**: Modern web applications for project documentation and interfaces

## Personal Quality Standards

### Repository Conformity for Professional Appearance
All personal projects should include:
- `README.md` with clear project overview and setup instructions
- `CLAUDE.md` for AI assistance context and development guidance
- `.gitignore` with platform-appropriate exclusions
- GitHub templates in `.github/` directory for consistent workflow
- Proper project structure for detected type (Tauri/Swift/Web)

### Standard GitHub Labels
Automatically configured through `gh-automation.sh` for consistent project management:
- `enhancement`, `bug`, `documentation`, `automation`
- `priority-high/medium/low`
- `status-blocked`

## Personal Technology Stack

### Development Platforms
- **Primary**: Swift for Apple ecosystem applications (ForgeDesk, Cashly)
- **Cross-platform**: Tauri + Rust for desktop applications (todge-tauri, phoenix-usb-flasher)
- **Web**: Modern frameworks for project documentation and interfaces
- **AI Integration**: Claude, ChatGPT, and GitHub Copilot workflows

## Personal Project Philosophy

**Repository Purpose:** Personal AI development infrastructure for building useful applications
**Focus:** Professional code quality and systematic AI integration for personal productivity
**Applications:** todge-tauri, ForgeDesk, Cashly, and other personal projects

### Project Independence Model
Each application is designed as a completely independent repository:
- IndieDevHQ provides personal templates and automation tools
- Individual projects maintain their own GitHub repositories and lifecycles  
- Projects use IndieDevHQ patterns for consistency without file dependencies

## Personal Development Environment

- **Primary Platform**: macOS (Apple Silicon/Intel)
- **Code Editor**: VS Code/Cursor with AI extensions (configurations in `dev-notebooks/ide-configs/`)
- **Terminal**: Warp with integrated AI assistance
- **Version Control**: Git with GitHub CLI automation for personal project management

## Key Context for AI Assistance

This personal development infrastructure accelerates building applications (todge-tauri, ForgeDesk, Cashly) through systematic AI integration while maintaining professional code quality. The repository serves as both practical tooling and reference for AI-augmented personal development workflows.

**Focus Areas:**
- **Current Priority**: todge-tauri (prescription management app) 
- **Secondary Projects**: ForgeDesk (project management), Cashly (financial tools)
- **Personal Productivity**: AI workflows for efficient solo development with professional standards