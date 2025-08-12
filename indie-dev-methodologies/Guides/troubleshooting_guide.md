# IndieDevHQ Troubleshooting Guide

Comprehensive troubleshooting guide for common issues encountered when using IndieDevHQ methodology and automation scripts.

## Quick Diagnostic Commands

Before diving into specific issues, run these diagnostic commands to gather information:

```bash
# Check IndieDevHQ installation and permissions
ls -la ~/Projects/indie-dev-methodologies/scripts/

# Verify script executability
find ~/Projects/indie-dev-methodologies/scripts/ -type f \( -name "*.sh" -o -name "*.py" \) -exec test -x {} \; && echo "✅ Scripts are executable" || echo "❌ Some scripts not executable"

# Test basic functionality
~/Projects/indie-dev-methodologies/scripts/check-conformity.sh . --help 2>/dev/null && echo "✅ Scripts can run" || echo "❌ Scripts cannot execute"

# Check system dependencies
which git && echo "✅ Git available" || echo "❌ Git not found"
which gh && echo "✅ GitHub CLI available" || echo "❌ GitHub CLI not found"
python3 --version 2>/dev/null && echo "✅ Python3 available" || echo "❌ Python3 not found"
```

## Common Issues and Solutions

### 1. Script Permission Issues

#### **Problem**: "Permission denied" when running scripts
```bash
bash: ./scripts/init-project.sh: Permission denied
```

#### **Solution**: Make scripts executable
```bash
# Fix all script permissions at once
chmod +x ~/Projects/indie-dev-methodologies/scripts/*.sh
chmod +x ~/Projects/indie-dev-methodologies/scripts/*.py

# Verify permissions fixed
ls -la ~/Projects/indie-dev-methodologies/scripts/ | grep -E "\.(sh|py)$"
```

#### **Alternative**: Run with explicit interpreter
```bash
# For shell scripts
bash ~/Projects/indie-dev-methodologies/scripts/init-project.sh MyProject tauri

# For Python scripts  
python3 ~/Projects/indie-dev-methodologies/scripts/generate-docs.py .
```

### 2. GitHub CLI Issues

#### **Problem**: GitHub CLI not authenticated
```bash
Error: authentication required. Run: gh auth login
```

#### **Solution**: Set up GitHub authentication
```bash
# Login to GitHub CLI
gh auth login

# Choose authentication method (recommended: Login with a web browser)
# Follow the prompts to authenticate

# Verify authentication
gh auth status

# Expected output:
# ✓ Logged in to github.com as [username]
# ✓ Git operations for github.com configured to use https protocol.
```

#### **Problem**: GitHub CLI not installed
```bash
Command 'gh' not found
```

#### **Solution**: Install GitHub CLI
```bash
# macOS (using Homebrew)
brew install gh

# Alternative: Download from https://cli.github.com/

# Verify installation
gh --version
```

### 3. Git Repository Issues

#### **Problem**: Not in a git repository
```bash
fatal: not a git repository (or any of the parent directories): .git
```

#### **Solution**: Initialize git repository
```bash
# Initialize git in current directory
git init

# Add remote if needed
git remote add origin https://github.com/yourusername/yourrepo.git

# Verify git status
git status
```

#### **Problem**: Git not configured
```bash
Please tell me who you are
```

#### **Solution**: Configure Git identity
```bash
# Set global Git identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify configuration
git config --global --list | grep user
```

### 4. Project Detection Issues

#### **Problem**: Project type detected as "unknown"
```bash
🔧 Detected project type: unknown
⚠️ WARNING: Could not detect project type - manual verification needed
```

#### **Solution**: Add project-specific files or specify type manually
```bash
# For Tauri projects, ensure these files exist:
ls src-tauri/Cargo.toml  # Should exist for Tauri detection

# For Swift projects, ensure Package.swift exists:
ls Package.swift  # Should exist for Swift detection

# For web projects, ensure package.json exists:
ls package.json  # Should exist for web/electron detection

# Manual specification during project creation:
./scripts/init-project.sh MyProject tauri .  # Explicitly specify type
```

### 5. Python Script Issues

#### **Problem**: Python import errors
```bash
ModuleNotFoundError: No module named 'some_module'
```

#### **Solution**: Check Python environment
```bash
# Verify Python version (3.6+ required)
python3 --version

# Check if modules are available
python3 -c "import json, subprocess, pathlib; print('✅ Required modules available')"

# If modules missing, they're part of Python standard library
# Update Python or check installation
```

#### **Problem**: Python script encoding issues
```bash
UnicodeDecodeError: 'utf-8' codec can't decode byte
```

#### **Solution**: Ensure files are UTF-8 encoded
```bash
# Check file encoding
file -bi path/to/problematic/file

# Convert to UTF-8 if needed
iconv -f iso-8859-1 -t utf-8 problematic_file > fixed_file
```

### 6. Template and Configuration Issues

#### **Problem**: Templates not found or corrupted
```bash
cp: cannot access 'templates/project/*': No such file or directory
```

#### **Solution**: Verify IndieDevHQ structure
```bash
# Check if templates exist
ls -la ~/Projects/indie-dev-methodologies/templates/

# If missing, templates directory might be incomplete
# Ensure IndieDevHQ is properly set up:
ls -la ~/Projects/indie-dev-methodologies/
# Should show: scripts/, templates/, .github/, 01_Core_Workflow/, etc.
```

#### **Problem**: CLAUDE.md generation issues
```bash
cat: CLAUDE.md: No such file or directory
```

#### **Solution**: Check script execution path and permissions
```bash
# Run from correct directory
cd ~/Projects/your-project

# Use absolute path to script
~/Projects/indie-dev-methodologies/scripts/init-project.sh MyProject tauri .

# Check if script completed successfully
echo $?  # Should return 0 for success
```

### 7. Automation Script Failures

#### **Problem**: Script exits with errors
```bash
./scripts/check-conformity.sh: line 45: syntax error near unexpected token
```

#### **Solution**: Check script integrity and shell compatibility
```bash
# Verify shell compatibility (scripts require bash)
echo $SHELL  # Should show bash path

# Run with explicit bash
bash ~/Projects/indie-dev-methodologies/scripts/check-conformity.sh .

# Check for script corruption
head -1 ~/Projects/indie-dev-methodologies/scripts/check-conformity.sh
# Should show: #!/bin/bash
```

#### **Problem**: Scripts can't find dependencies
```bash
Command 'swift' not found
Command 'cargo' not found
Command 'npm' not found
```

#### **Solution**: Install missing dependencies
```bash
# For Swift development
xcode-select --install  # Install Xcode command line tools

# For Rust/Tauri development
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# For Node.js/web development
# Install Node.js from https://nodejs.org/ or use:
brew install node

# Verify installations
swift --version
cargo --version
npm --version
```

### 8. Documentation Generation Issues

#### **Problem**: Documentation script produces empty output
```bash
✅ Generated: docs/PROJECT_OVERVIEW.md
# But file is empty or incomplete
```

#### **Solution**: Check project content and git history
```bash
# Ensure git repository has commits
git log --oneline | head -5

# Verify project has source files
find . -name "*.swift" -o -name "*.rs" -o -name "*.js" -o -name "*.ts" | wc -l

# Run script with verbose output (if available)
python3 ~/Projects/indie-dev-methodologies/scripts/generate-docs.py . --verbose
```

### 9. Metrics Dashboard Issues

#### **Problem**: Metrics show zero values incorrectly
```bash
📊 Quick Summary:
   📈 0 commits (30 days)  # But you know there are commits
```

#### **Solution**: Verify git configuration and repository state
```bash
# Check git log directly
git log --since="30 days ago" --oneline | wc -l

# Verify you're in the correct repository
git remote -v

# Check for uncommitted changes
git status

# Ensure script has correct permissions and access
ls -la ~/Projects/indie-dev-methodologies/scripts/dev-metrics.py
```

### 10. AI Integration Issues

#### **Problem**: CLAUDE.md not providing good AI context
```bash
# AI responses are generic or unhelpful
```

#### **Solution**: Enhance CLAUDE.md with project-specific information
```bash
# Add more specific context to CLAUDE.md
cat >> CLAUDE.md << EOF

## Project-Specific Context
- Architecture: [Describe your architecture]
- Key Technologies: [List main frameworks/libraries]
- Current Focus: [What you're working on]
- Common Issues: [Known problems or constraints]
- Development Patterns: [Preferred approaches]
EOF
```

## Advanced Troubleshooting

### Debug Mode for Scripts

Add debug output to scripts by modifying the first line:

```bash
# Enable bash debug mode
#!/bin/bash -x

# Or run with debug flag
bash -x ~/Projects/indie-dev-methodologies/scripts/script-name.sh
```

### Logging Script Execution

Create a debugging wrapper:

```bash
# Create debug wrapper
cat > debug-script.sh << 'EOF'
#!/bin/bash
SCRIPT="$1"
shift
echo "Running: $SCRIPT $@"
echo "Working directory: $(pwd)"
echo "Environment: PATH=$PATH"
"$SCRIPT" "$@" 2>&1 | tee "debug-$(basename "$SCRIPT").log"
echo "Exit code: $?"
EOF

chmod +x debug-script.sh

# Use wrapper for debugging
./debug-script.sh ~/Projects/indie-dev-methodologies/scripts/init-project.sh MyProject tauri
```

### System Environment Validation

```bash
# Complete system check for IndieDevHQ
cat > system-check.sh << 'EOF'
#!/bin/bash
echo "🔍 IndieDevHQ System Check"
echo "========================="

# Operating System
echo "OS: $(uname -s) $(uname -r)"

# Shell
echo "Shell: $SHELL"

# Required tools
echo "Checking required tools..."
for tool in git gh python3 bash; do
    if command -v $tool > /dev/null; then
        echo "✅ $tool: $(command -v $tool)"
    else  
        echo "❌ $tool: Not found"
    fi
done

# Optional tools (project-specific)
echo "Checking optional tools..."
for tool in swift cargo npm node xcode-select; do
    if command -v $tool > /dev/null; then
        echo "✅ $tool: $(command -v $tool)"
    else
        echo "⚠️  $tool: Not found (may be needed for specific project types)"
    fi
done

# IndieDevHQ structure
echo "Checking IndieDevHQ structure..."
INDIEDEVHQ_PATH="$HOME/Projects/indie-dev-methodologies"
if [ -d "$INDIEDEVHQ_PATH" ]; then
    echo "✅ IndieDevHQ found at: $INDIEDEVHQ_PATH"
    
    # Check key directories
    for dir in scripts templates .github 01_Core_Workflow; do
        if [ -d "$INDIEDEVHQ_PATH/$dir" ]; then
            echo "✅ $dir directory exists"
        else
            echo "❌ $dir directory missing"
        fi
    done
    
    # Check script executability
    EXEC_SCRIPTS=$(find "$INDIEDEVHQ_PATH/scripts" -type f -executable | wc -l)
    TOTAL_SCRIPTS=$(find "$INDIEDEVHQ_PATH/scripts" -type f \( -name "*.sh" -o -name "*.py" \) | wc -l)
    echo "✅ Scripts: $EXEC_SCRIPTS/$TOTAL_SCRIPTS executable"
    
else
    echo "❌ IndieDevHQ not found at expected location: $INDIEDEVHQ_PATH"
fi

echo "========================="
echo "System check completed"
EOF

chmod +x system-check.sh
./system-check.sh
```

## Getting Help

### Community Resources
- **GitHub Issues**: Report bugs in IndieDevHQ repository
- **Documentation**: Check cross-references guide for related topics
- **Examples**: Review practical implementation examples for similar use cases

### Self-Help Checklist
1. ✅ Run system check script above
2. ✅ Verify all dependencies installed
3. ✅ Check script permissions and paths  
4. ✅ Confirm git repository state
5. ✅ Review error messages carefully
6. ✅ Try manual execution of failing commands
7. ✅ Check for recent changes that might have broken setup

### Creating Effective Bug Reports

When reporting issues, include:

```bash
# Generate system information
cat > bug-report.md << EOF
# IndieDevHQ Bug Report

## Environment
- OS: $(uname -s) $(uname -r)
- Shell: $SHELL
- Git: $(git --version)
- Python: $(python3 --version 2>/dev/null || echo "Not available")

## Issue Description
[Describe the problem]

## Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Error Output
\`\`\`
[Paste error messages here]
\`\`\`

## Additional Context
[Any other relevant information]
EOF
```

---

*This troubleshooting guide covers the most common issues encountered when using IndieDevHQ. Keep this guide updated as new issues are discovered and resolved.*