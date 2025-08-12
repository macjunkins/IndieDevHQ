#!/bin/bash
# Project Initialization Script for IndieDevHQ
# Creates a new project with all necessary structure and templates

set -e

PROJECT_NAME="$1"
PROJECT_TYPE="${2:-tauri}"  # tauri, electron, web, or swift
PROJECT_DIR="${3:-$PWD}"

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 <project-name> [project-type] [target-directory]"
    echo "Project types: tauri (default), electron, web, swift"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$(dirname "$SCRIPT_DIR")/templates"
TARGET_PATH="$PROJECT_DIR/$PROJECT_NAME"

echo "🚀 Initializing project: $PROJECT_NAME"
echo "📁 Project type: $PROJECT_TYPE"
echo "📍 Target directory: $TARGET_PATH"

# Create project directory
mkdir -p "$TARGET_PATH"
cd "$TARGET_PATH"

# Copy base project structure
if [ -d "$TEMPLATES_DIR/project" ]; then
    cp -r "$TEMPLATES_DIR/project/"* .
fi

# Initialize git repository
git init

# Create project-type specific .gitignore
case $PROJECT_TYPE in
    "swift")
        cat > .gitignore << EOF
.build/
*.xcodeproj
.swiftpm/
.DS_Store
EOF
        ;;
    *)
        cat > .gitignore << EOF
node_modules/
target/
.DS_Store
dist/
EOF
        ;;
esac

# Copy GitHub templates
if [ -d "$TEMPLATES_DIR/github" ]; then
    mkdir -p .github
    cp -r "$TEMPLATES_DIR/github/"* .github/
fi

# Project-specific initialization
case $PROJECT_TYPE in
    "tauri")
        echo "🦀 Setting up Tauri project structure"
        # Create Tauri-specific structure if not exists
        mkdir -p src-tauri/src
        mkdir -p src
        ;;
    "electron")
        echo "⚡ Setting up Electron project structure" 
        mkdir -p src/main src/renderer
        ;;
    "web")
        echo "🌐 Setting up Web project structure"
        mkdir -p src/components src/styles src/utils
        ;;
    "swift")
        echo "🍎 Setting up Swift console application"
        # Initialize Swift package
        swift package init --type executable --name "$PROJECT_NAME"
        ;;
esac

# Create basic README
cat > README.md << EOF
# $PROJECT_NAME

A $PROJECT_TYPE application built with IndieDevHQ methodology.

## Development

\`\`\`bash
# Install dependencies
npm install

# Start development server
npm run dev
\`\`\`

## Build

\`\`\`bash
# Build for production
npm run build
\`\`\`

## Project Structure

Generated using IndieDevHQ project initialization scripts.
EOF

# Create comprehensive CLAUDE.md with embedded IndieDevHQ methodology
cat > CLAUDE.md << EOF
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

**$PROJECT_NAME** is a $PROJECT_TYPE application built using IndieDevHQ methodology. This project is designed to be completely self-contained with its own git repository and GitHub presence.

**Architecture**: IndieDevHQ methodology with AI-augmented development workflows
**Created**: $(date +"%Y-%m-%d")
**Technology Stack**: $PROJECT_TYPE

## Development Philosophy (IndieDevHQ Methodology)

### Core Principles
- **AI-Assisted Workflows**: Extensive integration with Claude, ChatGPT, and local AI models
- **Documentation-First**: Comprehensive planning and knowledge capture
- **CLI-First Development**: Build command-line tools before GUI wrappers for faster MVP
- **Prototype-Driven**: Build proof-of-concepts before full implementation
- **Cross-Platform Native**: Focus on native performance with web UI technologies

### Project Management Approach
- Strategic planning captured in markdown documents
- AI system prompts for specialized assistance
- Extensive use of templates and automation
- Session summaries for development progress tracking

## Common Development Commands

### $PROJECT_TYPE Specific Commands
EOF

case $PROJECT_TYPE in
    "tauri")
        cat >> CLAUDE.md << 'EOF'
- `cargo tauri dev` - Start development server
- `cargo tauri build` - Build for production
EOF
        ;;
    "electron")
        cat >> CLAUDE.md << 'EOF'
- `npm run dev` - Start development server
- `npm run build` - Build for production
EOF
        ;;
    "web")
        cat >> CLAUDE.md << 'EOF'
- `npm run dev` - Start development server  
- `npm run build` - Build for production
EOF
        ;;
    "swift")
        cat >> CLAUDE.md << 'EOF'
- `swift build` - Build the application
- `swift run` - Run the application
- `swift test` - Run tests
- `swift package generate-xcodeproj` - Generate Xcode project
EOF
        ;;
esac

cat >> CLAUDE.md << EOF

### Quality Assurance
\`\`\`bash
# Check project conformity
./scripts/check-conformity.sh

# Run tests (when implemented)
npm test
# OR for Rust projects
cargo test
\`\`\`

## Architecture and Project Structure

This project follows IndieDevHQ methodology patterns:

### Technology Migration Strategy
- **Current**: $PROJECT_TYPE for cross-platform development
- **Philosophy**: Native performance with web UI technologies
- **Deployment**: Self-contained applications with minimal dependencies

### Security and Safety Considerations
- Input validation for all user-provided data
- Proper error handling and user feedback
- Secure state management
- Privacy-focused design (local-first when possible)

### Development Workflow Integration
- **AI Assistance**: This CLAUDE.md enables AI-augmented development
- **Documentation**: Maintain comprehensive planning and progress documentation
- **Testing**: Implement testing strategies appropriate for $PROJECT_TYPE applications
- **Deployment**: Configure for target platforms (macOS primary, cross-platform secondary)

## IndieDevHQ Methodology Context

### Project Independence
This project is designed to be completely self-contained:
- Own git repository and GitHub presence
- Independent development lifecycle
- Self-managed dependencies and toolchain
- GitHub Pages enabled for project documentation

### AI-Augmented Development
- Use Claude Code for development assistance
- Reference IndieDevHQ patterns conceptually (no file dependencies)
- Leverage automation scripts for project management
- Maintain development session documentation

### Community Integration
- Built using IndieDevHQ methodology framework
- Can reference IndieDevHQ templates and patterns
- Contributes to indie developer community knowledge
- Maintains independence while following established patterns

## Important Context

- **Generated**: $(date +"%Y-%m-%d %H:%M:%S") using IndieDevHQ init scripts
- **Methodology**: IndieDevHQ framework for AI-augmented indie development
- **Independence**: Self-contained project with own git repository
- **Community**: Follows IndieDevHQ patterns while maintaining project autonomy
EOF

echo "✅ Project $PROJECT_NAME initialized successfully!"
echo "📍 Location: $TARGET_PATH"
echo "🔧 Next steps:"
echo "   cd $PROJECT_NAME"
echo "   # Add your project-specific setup commands here"
