#!/bin/bash
# GitHub Issues Synchronization Script for IndieDevHQ
# Synchronizes project stories/tasks to GitHub issues with standardized labels

set -e

REPO_PATH="${1:-$PWD}"
DRY_RUN="${2:-false}"

cd "$REPO_PATH"

echo "🔄 Syncing stories to GitHub issues"
echo "📍 Repository: $(basename "$REPO_PATH")"
echo "🧪 Dry run: $DRY_RUN"

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not a git repository"
    exit 1
fi

# Check if GitHub CLI is available
if ! command -v gh &> /dev/null; then
    echo "❌ Error: GitHub CLI (gh) is not installed"
    echo "Install: https://cli.github.com/"
    exit 1
fi

# Check if we're logged into GitHub
if ! gh auth status &> /dev/null; then
    echo "❌ Error: Not logged into GitHub CLI"
    echo "Run: gh auth login"
    exit 1
fi

# Get remote repository information
REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
if [ -z "$REMOTE_URL" ]; then
    echo "❌ Error: No remote origin configured"
    exit 1
fi

echo "🔗 Remote: $REMOTE_URL"

# Standard IndieDevHQ label set (minimal but essential)
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

echo ""
echo "🏷️  Checking and creating standard labels..."

# Function to create or update labels
setup_labels() {
    for label in "${!STANDARD_LABELS[@]}"; do
        IFS='|' read -r description color <<< "${STANDARD_LABELS[$label]}"
        
        # Check if label exists
        EXISTING_LABEL=$(gh label list --json name --jq ".[] | select(.name == \"$label\") | .name" 2>/dev/null || echo "")
        
        if [ -n "$EXISTING_LABEL" ]; then
            echo "   ✅ Label exists: $label"
        else
            if [ "$DRY_RUN" = "true" ]; then
                echo "   🧪 [DRY RUN] Would create label: $label"
            else
                echo "   ➕ Creating label: $label"
                gh label create "$label" --description "$description" --color "$color"
            fi
        fi
    done
}

setup_labels

echo ""
echo "📋 Looking for story files..."

# Look for story files (markdown files in docs, stories, or project root)
STORY_FILES=(
    "docs/ROADMAP.md"
    "docs/TODO.md"
    "ROADMAP.md"
    "TODO.md"
    "stories/*.md"
    "docs/stories/*.md"
)

FOUND_STORIES=0
ISSUES_CREATED=0

for pattern in "${STORY_FILES[@]}"; do
    for file in $pattern 2>/dev/null; do
        if [ -f "$file" ]; then
            echo "📋 Found story file: $file"
            FOUND_STORIES=$((FOUND_STORIES + 1))
            
            # Extract todo items from markdown (lines starting with - [ ] or - [x])
            TODO_ITEMS=$(grep -n "^- \[ \]" "$file" || true)
            DONE_ITEMS=$(grep -n "^- \[x\]" "$file" || true)
            
            if [ -n "$TODO_ITEMS" ]; then
                echo "   📝 Found $(echo "$TODO_ITEMS" | wc -l) open tasks"
                
                # Process each todo item
                while IFS= read -r line; do
                    LINE_NUM=$(echo "$line" | cut -d: -f1)
                    TASK_TEXT=$(echo "$line" | cut -d: -f2- | sed 's/^- \[ \] //')
                    
                    if [ ${#TASK_TEXT} -gt 10 ]; then
                        # Create issue title from task text (truncate if too long)
                        ISSUE_TITLE="${TASK_TEXT:0:80}"
                        if [ ${#TASK_TEXT} -gt 80 ]; then
                            ISSUE_TITLE="$ISSUE_TITLE..."
                        fi
                        
                        # Determine appropriate labels based on task content
                        LABELS="documentation,automation"
                        
                        # Auto-detect priority and type from task text
                        if echo "$TASK_TEXT" | grep -qi -E "(urgent|critical|high.priority|asap)"; then
                            LABELS="$LABELS,priority-high"
                        elif echo "$TASK_TEXT" | grep -qi -E "(low.priority|nice.to.have|optional)"; then
                            LABELS="$LABELS,priority-low"
                        else
                            LABELS="$LABELS,priority-medium"
                        fi
                        
                        if echo "$TASK_TEXT" | grep -qi -E "(bug|fix|error|issue)"; then
                            LABELS="$LABELS,bug"
                        elif echo "$TASK_TEXT" | grep -qi -E "(feature|add|create|implement)"; then
                            LABELS="$LABELS,enhancement"
                        fi
                        
                        if echo "$TASK_TEXT" | grep -qi -E "(blocked|waiting|dependency)"; then
                            LABELS="$LABELS,status-blocked"
                        fi
                        
                        # Create issue body with context
                        ISSUE_BODY="**Source**: \`$file:$LINE_NUM\`

**Task Description**: $TASK_TEXT

**Context**: Automatically imported from project documentation

**File Path**: \`$file\`
**Line**: $LINE_NUM

---
*This issue was automatically created from project documentation by IndieDevHQ sync tools.*

*Original task*:
\`\`\`
- [ ] $TASK_TEXT
\`\`\`"

                        if [ "$DRY_RUN" = "true" ]; then
                            echo "   🧪 [DRY RUN] Would create issue: $ISSUE_TITLE"
                            echo "   🧪 [DRY RUN] Labels: $LABELS"
                        else
                            # Check if issue already exists (search by title or source reference)
                            EXISTING_ISSUE=$(gh issue list --search "\"$file:$LINE_NUM\"" --json number,title --jq '.[0].number' 2>/dev/null || echo "")
                            
                            if [ -n "$EXISTING_ISSUE" ]; then
                                echo "   ⏭️  Issue already exists: #$EXISTING_ISSUE"
                            else
                                echo "   ➕ Creating issue: $ISSUE_TITLE"
                                echo "   🏷️  Labels: $LABELS"
                                gh issue create --title "$ISSUE_TITLE" --body "$ISSUE_BODY" --label "$LABELS"
                                ISSUES_CREATED=$((ISSUES_CREATED + 1))
                            fi
                        fi
                    fi
                done <<< "$TODO_ITEMS"
            fi
            
            if [ -n "$DONE_ITEMS" ]; then
                echo "   ✅ Found $(echo "$DONE_ITEMS" | wc -l) completed tasks"
            fi
        fi
    done
done

echo ""
echo "📊 Summary:"
if [ $FOUND_STORIES -eq 0 ]; then
    echo "⚠️  No story files found"
    echo "   Create files like ROADMAP.md, TODO.md, or docs/stories/*.md"
    echo "   Use markdown task syntax: - [ ] Task description"
else
    echo "✅ Story synchronization completed"
    echo "📁 Processed $FOUND_STORIES story files"
    
    if [ "$DRY_RUN" = "true" ]; then
        echo "🧪 This was a dry run - no issues were created"
        echo "   Run without 'true' as second argument to create issues"
    else
        echo "➕ Created $ISSUES_CREATED new issues"
    fi
fi

echo ""
echo "🏷️  Standard labels are now configured for this repository"
echo "   Use these labels when creating issues manually or through automation"