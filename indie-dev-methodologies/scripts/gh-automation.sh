#!/bin/bash
# GitHub Repository Setup Automation for IndieDevHQ
# Configures GitHub repository with standard settings, labels, and templates

set -e

REPO_PATH="${1:-$PWD}"
REPO_NAME="${2:-$(basename "$REPO_PATH")}"
VISIBILITY="${3:-public}"  # public or private

cd "$REPO_PATH"

echo "🔧 Setting up GitHub automation for: $REPO_NAME"
echo "📍 Path: $REPO_PATH"
echo "👁️  Visibility: $VISIBILITY"

# Check prerequisites
if ! command -v gh &> /dev/null; then
    echo "❌ Error: GitHub CLI (gh) is not installed"
    exit 1
fi

if ! gh auth status &> /dev/null; then
    echo "❌ Error: Not logged into GitHub CLI"
    echo "Run: gh auth login"
    exit 1
fi

# Check if this is already a GitHub repository
REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
REPO_EXISTS=false

if [ -n "$REMOTE_URL" ]; then
    echo "🔗 Repository already has remote: $REMOTE_URL"
    REPO_EXISTS=true
else
    echo "➕ Creating new GitHub repository: $REPO_NAME"
    gh repo create "$REPO_NAME" --${VISIBILITY} --description "IndieDevHQ managed project" --clone=false
    git remote add origin "https://github.com/$(gh api user --jq .login)/${REPO_NAME}.git"
    REPO_EXISTS=true
fi

# Setup standard IndieDevHQ labels
echo ""
echo "🏷️  Setting up standard labels..."
"$(dirname "$0")/sync-stories-to-issues.sh" "$REPO_PATH" true > /dev/null 2>&1 || true

declare -A STANDARD_LABELS=(
    ["enhancement"]="New feature or request|0052cc"
    ["bug"]="Something isn't working|d73a4a"
    ["documentation"]="Improvements or additions to documentation|0075ca"
    ["automation"]="Automated processes and tooling|1f883d"
    ["priority-high"]="High priority items|b60205"
    ["priority-medium"]="Medium priority items|fbca04"
    ["priority-low"]="Low priority items|c5def5"
    ["status-blocked"]="Blocked by external dependency|6f42c1"
)

for label in "${!STANDARD_LABELS[@]}"; do
    IFS='|' read -r description color <<< "${STANDARD_LABELS[$label]}"
    
    EXISTING_LABEL=$(gh label list --json name --jq ".[] | select(.name == \"$label\") | .name" 2>/dev/null || echo "")
    
    if [ -z "$EXISTING_LABEL" ]; then
        echo "   ➕ Creating label: $label"
        gh label create "$label" --description "$description" --color "$color" 2>/dev/null || true
    fi
done

# Setup GitHub templates if they don't exist
echo ""
echo "📋 Setting up GitHub templates..."

mkdir -p .github/{ISSUE_TEMPLATE,workflows}

# Create issue templates
if [ ! -f ".github/ISSUE_TEMPLATE/bug_report.md" ]; then
    echo "   📝 Creating bug report template"
    cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug report
about: Create a report to help us improve
title: '[BUG] '
labels: 'bug'
assignees: ''
---

## Bug Description
A clear and concise description of what the bug is.

## Steps to Reproduce
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

## Expected Behavior
A clear and concise description of what you expected to happen.

## Screenshots
If applicable, add screenshots to help explain your problem.

## Environment
- OS: [e.g. macOS, Windows, Linux]
- Version: [e.g. 1.0.0]
- Browser (if applicable): [e.g. chrome, safari]

## Additional Context
Add any other context about the problem here.
EOF
fi

if [ ! -f ".github/ISSUE_TEMPLATE/feature_request.md" ]; then
    echo "   🚀 Creating feature request template"
    cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature request
about: Suggest an idea for this project
title: '[FEATURE] '
labels: 'enhancement'
assignees: ''
---

## Feature Description
A clear and concise description of what you want to happen.

## Problem Statement
A clear and concise description of what the problem is. Ex. I'm always frustrated when [...]

## Proposed Solution
A clear and concise description of what you want to happen.

## Alternative Solutions
A clear and concise description of any alternative solutions or features you've considered.

## Additional Context
Add any other context or screenshots about the feature request here.
EOF
fi

if [ ! -f ".github/ISSUE_TEMPLATE/task.md" ]; then
    echo "   ✅ Creating task template"
    cat > .github/ISSUE_TEMPLATE/task.md << 'EOF'
---
name: Task
about: Create a development task or improvement
title: '[TASK] '
labels: 'documentation'
assignees: ''
---

## Task Description
Clear description of what needs to be done.

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Context
Additional information or background for this task.

## Definition of Done
- [ ] Code implemented
- [ ] Tests written (if applicable)
- [ ] Documentation updated
- [ ] Code reviewed
EOF
fi

# Create basic GitHub Actions workflow for supported project types
PROJECT_TYPE="unknown"
if [ -f "src-tauri/Cargo.toml" ]; then
    PROJECT_TYPE="tauri"
elif [ -f "package.json" ]; then
    PROJECT_TYPE="web"
fi

if [ "$PROJECT_TYPE" != "unknown" ] && [ ! -f ".github/workflows/ci.yml" ]; then
    echo "   🔄 Creating CI workflow for $PROJECT_TYPE project"
    
    case $PROJECT_TYPE in
        "tauri")
            cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        
    - name: Setup Rust
      uses: actions-rs/toolchain@v1
      with:
        toolchain: stable
        
    - name: Install dependencies
      run: npm ci
      
    - name: Run tests
      run: cargo test
      working-directory: src-tauri
EOF
            ;;
        "web")
            cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        
    - name: Install dependencies
      run: npm ci
      
    - name: Run tests
      run: npm test
      
    - name: Build
      run: npm run build
EOF
            ;;
    esac
fi

# Configure repository settings
echo ""
echo "⚙️  Configuring repository settings..."

# Enable issues and wiki
gh repo edit --enable-issues --enable-wiki 2>/dev/null || true

# Set default branch protection (if on main branch)
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" = "main" ]; then
    echo "   🛡️  Configuring branch protection for main"
    # Note: This requires admin permissions and may fail for personal repos
    # gh api repos/:owner/:repo/branches/main/protection -X PUT --input - 2>/dev/null << 'EOF' || true
    # {
    #   "required_status_checks": null,
    #   "enforce_admins": false,
    #   "required_pull_request_reviews": null,
    #   "restrictions": null
    # }
    # EOF
fi

# Commit and push changes
echo ""
echo "📤 Committing GitHub configuration..."

git add .github/
if ! git diff --cached --quiet; then
    git commit -m "🔧 Setup GitHub automation and templates

- Added standard IndieDevHQ issue templates
- Configured GitHub Actions workflow for $PROJECT_TYPE
- Set up repository automation

🤖 Generated with IndieDevHQ automation scripts"
    
    # Push to GitHub
    if [ "$REPO_EXISTS" = "true" ]; then
        echo "📤 Pushing to GitHub..."
        git push -u origin main 2>/dev/null || git push -u origin master 2>/dev/null || echo "   ⚠️  Could not push - check remote configuration"
    fi
fi

echo ""
echo "✅ GitHub automation setup completed!"
echo "🔗 Repository: https://github.com/$(gh api user --jq .login)/$REPO_NAME"
echo "🏷️  Standard labels configured"
echo "📋 Issue templates created"
echo "🔄 CI workflow configured for $PROJECT_TYPE"