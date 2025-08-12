# Practical Implementation Examples for IndieDevHQ

Real-world examples demonstrating how to apply IndieDevHQ methodology across different project types and development scenarios.

## Overview

This guide provides concrete, step-by-step examples of implementing IndieDevHQ methodology in various development contexts. Each example includes commands, expected outputs, and troubleshooting tips.

## Example 1: Complete Tauri Desktop Application

### **Scenario**: Building a cross-platform desktop utility for file management

**Step 1: Project Initialization**
```bash
# Navigate to your projects directory
cd ~/Projects

# Initialize Tauri project with IndieDevHQ
./indie-dev-methodologies/scripts/init-project.sh FileManager tauri .

# Result: Creates complete project structure
FileManager/
├── README.md              # Generated with project info
├── CLAUDE.md              # AI assistant context
├── .github/               # Issue templates and workflows
├── src-tauri/            # Rust backend
├── src/                  # Frontend (HTML/CSS/JS)
└── .gitignore           # Project-appropriate ignores
```

**Step 2: Development Environment Setup**
```bash
cd FileManager

# Check project conformity
../indie-dev-methodologies/scripts/check-conformity.sh .

# Expected output:
# ✅ Git repository initialized
# ✅ Found README.md, .gitignore, CLAUDE.md
# ✅ GitHub templates configured
# 🔧 Detected project type: tauri

# Set up GitHub automation
../indie-dev-methodologies/scripts/gh-automation.sh . FileManager public

# This creates:
# - GitHub repository
# - Standard issue labels
# - CI/CD workflows for Tauri
# - Issue/PR templates
```

**Step 3: Development Workflow**
```bash
# Start development server
cargo tauri dev

# Development cycle with IndieDevHQ integration
# 1. Make code changes
# 2. Use AI assistance for architecture decisions
# 3. Run quality checks
../indie-dev-methodologies/scripts/check-conformity.sh .

# 4. Update documentation
../indie-dev-methodologies/scripts/generate-docs.py .

# 5. Commit and sync issues
git add .
git commit -m "feat: add file sorting functionality"
../indie-dev-methodologies/scripts/sync-stories-to-issues.sh . false
```

**Step 4: Deployment and Metrics**
```bash
# Build for production
cargo tauri build

# Generate development metrics
../indie-dev-methodologies/scripts/dev-metrics.py .

# Expected metrics dashboard shows:
# - Git activity analysis
# - Code quality assessment  
# - Testing coverage status
# - IndieDevHQ conformity validation
```

## Example 2: Swift Command-Line Utility

### **Scenario**: Creating a macOS productivity tool for developers

**Step 1: Swift Project Setup**
```bash
# Initialize Swift project
./indie-dev-methodologies/scripts/init-project.sh DevTool swift ~/Projects

cd ~/Projects/DevTool

# Verify Swift project structure
ls -la
# Shows: Package.swift, Sources/, Tests/, README.md, CLAUDE.md, .github/

# Build and test
swift build
swift test
swift run
```

**Step 2: Enhanced Swift Development**
```bash
# Add dependencies to Package.swift
# Edit Package.swift to include ArgumentParser
swift package resolve

# Create Xcode project when needed
swift package generate-xcodeproj
open DevTool.xcodeproj

# IndieDevHQ quality checks
../indie-dev-methodologies/scripts/check-conformity.sh .
# Validates Swift package structure
```

**Step 3: Apple Ecosystem Integration**
```bash
# Following Apple development methodology
# 1. Console app development and testing
swift build && swift run --help

# 2. Integration with Apple development workflow  
# Use VS Code with Swift extensions
code .

# 3. Documentation following Apple guidelines
../indie-dev-methodologies/scripts/generate-docs.py .
# Generates Apple-appropriate documentation
```

## Example 3: Multi-Platform Web Application

### **Scenario**: Progressive Web App with offline capabilities

**Step 1: Web Project Foundation**
```bash
# Initialize web project
./indie-dev-methodologies/scripts/init-project.sh MyPWA web ~/Projects

cd ~/Projects/MyPWA

# Set up modern web development structure
mkdir -p src/{components,hooks,services,utils}
mkdir -p public/{images,icons}

# Install dependencies (example)
npm init -y
npm install --save react react-dom
npm install --save-dev webpack webpack-cli typescript
```

**Step 2: Development Workflow Integration**
```bash
# Development with AI assistance
# 1. Use Claude/ChatGPT for architecture planning
# 2. Use Cursor/Copilot for component implementation
# 3. Apply IndieDevHQ quality standards

# Quality validation
../indie-dev-methodologies/scripts/check-conformity.sh .

# Continuous documentation
../indie-dev-methodologies/scripts/generate-docs.py .

# Metrics tracking
../indie-dev-methodologies/scripts/dev-metrics.py .
```

## Example 4: Legacy Project Migration

### **Scenario**: Migrating existing project to IndieDevHQ methodology

**Step 1: Assessment and Setup**
```bash
# Navigate to existing project
cd ~/Projects/MyExistingApp

# Run IndieDevHQ conformity check
~/Projects/indie-dev-methodologies/scripts/check-conformity.sh .

# Expected output shows gaps:
# ❌ Missing CLAUDE.md
# ⚠️ No GitHub templates
# ❌ Non-standard project structure
```

**Step 2: Gradual Migration**
```bash
# Add IndieDevHQ documentation
cp ~/Projects/indie-dev-methodologies/templates/project/* .

# Set up GitHub integration
~/Projects/indie-dev-methodologies/scripts/gh-automation.sh . MyExistingApp public

# Update .gitignore for project type
# (Edit .gitignore based on project type)

# Create CLAUDE.md with project context
# (Customize based on project specifics)
```

**Step 3: Workflow Integration**
```bash
# Start using IndieDevHQ scripts gradually
~/Projects/indie-dev-methodologies/scripts/generate-docs.py .
~/Projects/indie-dev-methodologies/scripts/sync-stories-to-issues.sh . true  # Dry run first

# Monitor improvement with metrics
~/Projects/indie-dev-methodologies/scripts/dev-metrics.py .
```

## Example 5: Team Collaboration Setup

### **Scenario**: Adapting IndieDevHQ for small team development

**Step 1: Repository Configuration**
```bash
# Set up shared repository with IndieDevHQ
./indie-dev-methodologies/scripts/init-project.sh TeamProject tauri ~/Projects

cd ~/Projects/TeamProject

# Configure for team collaboration
./indie-dev-methodologies/scripts/gh-automation.sh . TeamProject private

# Set up team-specific GitHub settings
gh repo edit --enable-wiki --enable-projects
```

**Step 2: Team Workflow Standards**
```bash
# Create team-specific documentation
cat >> TEAM_GUIDELINES.md << EOF
# Team Development Guidelines

## Daily Workflow
1. Run conformity checks: \`../indie-dev-methodologies/scripts/check-conformity.sh .\`
2. Update documentation: \`../indie-dev-methodologies/scripts/generate-docs.py .\`
3. Sync GitHub issues: \`../indie-dev-methodologies/scripts/sync-stories-to-issues.sh . false\`

## Code Review Process
- Use CLAUDE.md for context in PR reviews
- Run metrics dashboard before major releases
- Follow IndieDevHQ quality standards

## AI Usage Guidelines
- Use Claude/ChatGPT for architecture decisions
- Document AI-assisted decisions in commit messages
- Share system prompts across team members
EOF
```

**Step 3: Continuous Integration**
```bash
# Automated quality checks in CI/CD
# The GitHub workflows created by gh-automation.sh include:
# - Automated conformity checking
# - Documentation validation
# - Multi-platform builds (for Tauri)
# - Metrics reporting
```

## Example 6: Multi-Project Workspace Management

### **Scenario**: Managing multiple related projects with IndieDevHQ

**Step 1: Workspace Organization**
```bash
# Create workspace structure
mkdir -p ~/Projects/MyCompanyProjects/{mobile-app,web-app,desktop-app,shared-libs}

# Initialize each project with appropriate type
cd ~/Projects/MyCompanyProjects

./indie-dev-methodologies/scripts/init-project.sh MobileApp swift mobile-app
./indie-dev-methodologies/scripts/init-project.sh WebApp web web-app  
./indie-dev-methodologies/scripts/init-project.sh DesktopApp tauri desktop-app
```

**Step 2: Cross-Project Management**
```bash
# Create workspace-level scripts
cat > ~/Projects/MyCompanyProjects/check-all-projects.sh << 'EOF'
#!/bin/bash
echo "🔍 Checking all projects in workspace..."

for project in mobile-app web-app desktop-app; do
    echo "Checking $project..."
    cd "$project"
    ../indie-dev-methodologies/scripts/check-conformity.sh .
    ../indie-dev-methodologies/scripts/dev-metrics.py . | grep "Quick Summary:" -A 10
    cd ..
    echo ""
done
EOF

chmod +x check-all-projects.sh
```

**Step 3: Unified Development Workflow**
```bash
# Daily workspace checks
./check-all-projects.sh

# Generate workspace-wide metrics
for project in mobile-app web-app desktop-app; do
    echo "=== $project ===" >> WORKSPACE_METRICS.md
    ./indie-dev-methodologies/scripts/dev-metrics.py "$project" | tail -10 >> WORKSPACE_METRICS.md
    echo "" >> WORKSPACE_METRICS.md
done
```

## Common Implementation Patterns

### **Pattern 1: AI-First Development**
```bash
# Start each feature with AI planning session
# 1. Define requirements with Claude/ChatGPT
# 2. Generate initial architecture and code structure  
# 3. Use Cursor/Copilot for implementation
# 4. Validate with IndieDevHQ quality checks
# 5. Document decisions in CLAUDE.md
```

### **Pattern 2: Documentation-Driven Development**
```bash
# Always start with documentation
# 1. Update README.md with new feature plans
# 2. Create user stories in markdown format
# 3. Generate GitHub issues from stories
./indie-dev-methodologies/scripts/sync-stories-to-issues.sh . false
# 4. Implement features following documented plan
# 5. Update docs after implementation
./indie-dev-methodologies/scripts/generate-docs.py .
```

### **Pattern 3: Quality-First Approach**
```bash
# Continuous quality validation
# 1. Run conformity checks before starting work
./indie-dev-methodologies/scripts/check-conformity.sh .
# 2. Implement feature with quality standards in mind
# 3. Generate metrics to track quality trends
./indie-dev-methodologies/scripts/dev-metrics.py .
# 4. Address quality issues before moving to next feature
```

## Troubleshooting Implementation Issues

### **Issue**: Script permissions denied
```bash
# Solution: Make scripts executable
chmod +x ~/Projects/indie-dev-methodologies/scripts/*.sh
chmod +x ~/Projects/indie-dev-methodologies/scripts/*.py
```

### **Issue**: GitHub CLI not configured
```bash
# Solution: Set up GitHub CLI
gh auth login
gh config set git_protocol ssh  # Optional: use SSH
```

### **Issue**: Project type not detected correctly
```bash
# Solution: Manually specify project type or add detection patterns
# Edit scripts/init-project.sh or scripts/check-conformity.sh
# Add your specific file patterns for detection
```

### **Issue**: AI context not working optimally
```bash
# Solution: Keep CLAUDE.md updated
# 1. Add project-specific context regularly
# 2. Include architecture decisions and constraints
# 3. Update after major changes or milestones
```

## Best Practices from Real Usage

### **Documentation Maintenance**
- Run `generate-docs.py` after major changes
- Keep CLAUDE.md updated with current project state
- Use metrics dashboard to identify documentation gaps

### **Quality Monitoring**  
- Check conformity before releases
- Monitor metrics trends over time
- Address quality issues promptly

### **AI Integration**
- Use structured prompts for consistency
- Document AI-assisted decisions
- Balance AI assistance with human oversight

### **Team Coordination**
- Standardize on IndieDevHQ scripts across team
- Share system prompts and AI practices
- Use GitHub integration for transparent project management

---

*These examples demonstrate real-world application of IndieDevHQ methodology across various development scenarios. Adapt the patterns to your specific needs and project requirements.*