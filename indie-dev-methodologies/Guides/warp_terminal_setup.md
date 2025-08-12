# Warp Terminal Setup for IndieDevHQ

Modern terminal replacement optimized for AI-augmented development workflows.

## Overview

**Purpose**: Modern terminal for development tasks, Git commands, and automation scripts  
**Integration**: Works seamlessly with IndieDevHQ automation and AI workflows  
**Benefits**: Visual command blocks, AI assistance, and enhanced Git integration

## Installation & Setup

### 1. **Install Warp**
- Download from: [https://warp.dev](https://warp.dev/)
- Sign in with GitHub for cloud settings backup
- Recommended for all IndieDevHQ users on macOS

### 2. **Configuration**
- Set your shell (`zsh` recommended)
- Configure keybindings (Warp > Settings)
- Enable workflows for IndieDevHQ automation scripts

### 3. **IndieDevHQ Integration**
Set up aliases for common IndieDevHQ commands:

```bash
# Add to your shell profile (~/.zshrc or ~/.bashrc)
alias idh-init='./scripts/init-project.sh'
alias idh-check='./scripts/check-conformity.sh'
alias idh-docs='./scripts/generate-docs.py'
alias idh-sync='./scripts/sync-stories-to-issues.sh'
alias idh-setup='./scripts/gh-automation.sh'
```

## Power Features

### **AI Command Search**
- Press `⌘K` and describe what you want to do
- Perfect for discovering IndieDevHQ script options
- Example: "initialize a new Tauri project"

### **Visual Command Blocks**
- Commands and outputs are visually grouped
- Easy to track IndieDevHQ automation script progress
- Great for debugging script execution

### **Split Panes**
- Use `⌘D` (horizontal) / `⌘ShiftD` (vertical)
- Monitor multiple IndieDevHQ processes simultaneously
- Example: Run conformity checks while initializing projects

## IndieDevHQ Workflow Integration

### **Project Initialization**
```bash
# Navigate to your projects directory
cd ~/Projects

# Initialize new project with IndieDevHQ
./indie-dev-methodologies/scripts/init-project.sh my-app tauri .

# Check project conformity
./indie-dev-methodologies/scripts/check-conformity.sh ./my-app
```

### **Daily Development Workflow**
```bash
# Update and check repository
git pull origin main
./indie-dev-methodologies/scripts/check-conformity.sh .

# Generate documentation
./indie-dev-methodologies/scripts/generate-docs.py .

# Sync tasks to GitHub issues
./indie-dev-methodologies/scripts/sync-stories-to-issues.sh . false
```

### **GitHub Integration**
```bash
# Set up complete GitHub automation
./indie-dev-methodologies/scripts/gh-automation.sh . my-repo public

# Use GitHub CLI with Warp's enhanced output
gh repo list
gh issue list
gh pr create
```

## Pro Tips for IndieDevHQ Users

### **Command Suggestions**
- Use Warp's `⌘K` to discover IndieDevHQ script options
- Create custom workflows for common IndieDevHQ patterns
- Save frequently used automation sequences as snippets

### **Git Workflow Enhancement**
```bash
# Enhanced git workflow with visual feedback
git status                          # See changes with Warp's visual formatting
git add .
git commit -m "feat: new feature"   # Follow conventional commit format
git push origin feature-branch
```

### **Automation Script Monitoring**
- Use split panes to monitor long-running scripts
- Visual command blocks make debugging easier
- Enhanced output formatting for script results

## Advanced Configuration

### **Custom Workflows**
Create Warp workflows for IndieDevHQ operations:

1. Open Warp Settings > Workflows
2. Create new workflow for "IndieDevHQ Project Init"
3. Add command template:
```bash
cd ~/Projects && ./indie-dev-methodologies/scripts/init-project.sh {{project_name}} {{project_type}} .
```

### **Environment Setup**
```bash
# Add to shell profile for IndieDevHQ integration
export INDIEDEVHQ_PATH="~/Projects/indie-dev-methodologies"
export PATH="$INDIEDEVHQ_PATH/scripts:$PATH"

# Enable IndieDevHQ script autocompletion (if available)
source "$INDIEDEVHQ_PATH/completions/bash_completion"
```

## Troubleshooting

### **Common Issues**
- **Script not found**: Ensure you're running from the correct directory or use absolute paths
- **Permission denied**: Make sure scripts are executable (`chmod +x scripts/*.sh`)
- **GitHub CLI not configured**: Run `gh auth login` before using GitHub automation

### **Performance Tips**
- Use Warp's command history (`⌘R`) to quickly repeat IndieDevHQ commands
- Leverage AI command search for discovering new script features
- Set up workflows for repetitive IndieDevHQ operations

## Integration with Other Tools

### **VS Code Integration**
- Use Warp as VS Code's integrated terminal
- Better visualization of IndieDevHQ script output
- Enhanced Git integration within VS Code projects

### **AI Workflow Enhancement**
- Perfect companion to IndieDevHQ's AI-augmented workflows
- Use AI command search to discover automation possibilities
- Visual feedback improves AI development iteration cycles

---

*This guide integrates Warp terminal with IndieDevHQ methodology for optimal development experience.*