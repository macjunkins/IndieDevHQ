#!/bin/bash
# Repository Conformity Checker for IndieDevHQ
# Validates project structure against IndieDevHQ standards

set -e

PROJECT_DIR="${1:-$PWD}"
VERBOSE="${2:-false}"

cd "$PROJECT_DIR"

echo "🔍 Checking repository conformity for: $(basename "$PROJECT_DIR")"
echo "📍 Path: $PROJECT_DIR"

ERRORS=0
WARNINGS=0

# Function to log errors
log_error() {
    echo "❌ ERROR: $1"
    ((ERRORS++))
}

# Function to log warnings  
log_warning() {
    echo "⚠️  WARNING: $1"
    ((WARNINGS++))
}

# Function to log success
log_success() {
    if [ "$VERBOSE" = "true" ]; then
        echo "✅ $1"
    fi
}

echo ""
echo "=== Git Repository Structure ==="

# Check if git repository
if [ ! -d ".git" ]; then
    log_error "Not a git repository"
else
    log_success "Git repository initialized"
fi

# Check for essential files
essential_files=("README.md" ".gitignore")
for file in "${essential_files[@]}"; do
    if [ -f "$file" ]; then
        log_success "Found $file"
    else
        log_error "Missing required file: $file"
    fi
done

# Check CLAUDE.md for AI assistance
if [ -f "CLAUDE.md" ]; then
    log_success "Found CLAUDE.md for AI assistance"
else
    log_warning "Missing CLAUDE.md - AI assistance context not available"
fi

echo ""
echo "=== GitHub Integration ==="

# Check GitHub templates
if [ -d ".github" ]; then
    log_success "GitHub templates directory exists"
    
    if [ -d ".github/ISSUE_TEMPLATE" ]; then
        log_success "Issue templates configured"
    else
        log_warning "No issue templates found"
    fi
    
    if [ -d ".github/workflows" ]; then
        log_success "GitHub Actions workflows directory exists"
    else
        log_warning "No GitHub Actions workflows"
    fi
else
    log_warning "No GitHub templates configured"
fi

echo ""
echo "=== Project Structure ==="

# Detect project type
PROJECT_TYPE="unknown"
if [ -f "src-tauri/Cargo.toml" ]; then
    PROJECT_TYPE="tauri"
elif [ -f "package.json" ] && grep -q "electron" package.json 2>/dev/null; then
    PROJECT_TYPE="electron"  
elif [ -f "package.json" ]; then
    PROJECT_TYPE="web"
fi

echo "🔧 Detected project type: $PROJECT_TYPE"

# Project-specific checks
case $PROJECT_TYPE in
    "tauri")
        if [ -d "src-tauri" ]; then
            log_success "Tauri backend directory exists"
        else
            log_error "Tauri project missing src-tauri directory"
        fi
        
        if [ -f "src-tauri/Cargo.toml" ]; then
            log_success "Cargo.toml found"
        else
            log_error "Missing Cargo.toml in src-tauri"
        fi
        ;;
        
    "electron")
        if [ -f "main.js" ] || [ -f "src/main.js" ]; then
            log_success "Electron main process file found"
        else
            log_error "Missing Electron main process file"
        fi
        ;;
        
    "web")
        if [ -d "src" ]; then
            log_success "Source directory exists"
        else
            log_warning "No src directory found"
        fi
        ;;
        
    "unknown")
        log_warning "Could not detect project type - manual verification needed"
        ;;
esac

echo ""
echo "=== Package Management ==="

if [ -f "package.json" ]; then
    log_success "package.json found"
    
    # Check for common scripts
    if grep -q '"dev":' package.json; then
        log_success "Development script configured"
    else
        log_warning "No development script found in package.json"
    fi
    
    if grep -q '"build":' package.json; then
        log_success "Build script configured"  
    else
        log_warning "No build script found in package.json"
    fi
else
    if [ "$PROJECT_TYPE" != "unknown" ]; then
        log_error "Missing package.json for $PROJECT_TYPE project"
    fi
fi

# Check for lock files
if [ -f "package-lock.json" ] || [ -f "yarn.lock" ] || [ -f "pnpm-lock.yaml" ]; then
    log_success "Package lock file found"
else
    log_warning "No package lock file - dependencies not locked"
fi

echo ""
echo "=== Security & Quality ==="

# Check gitignore patterns
if [ -f ".gitignore" ]; then
    critical_patterns=("node_modules" "target" ".DS_Store")
    for pattern in "${critical_patterns[@]}"; do
        if grep -q "$pattern" .gitignore; then
            log_success ".gitignore includes $pattern"
        else
            log_warning ".gitignore missing pattern: $pattern"
        fi
    done
fi

echo ""
echo "=== Summary ==="
echo "📊 Conformity Check Results:"
echo "   ✅ Successes: $(grep -c "✅" <<< "$output" 2>/dev/null || echo "N/A")"
echo "   ⚠️  Warnings: $WARNINGS"  
echo "   ❌ Errors: $ERRORS"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo ""
    echo "🎉 Perfect! Repository fully conforms to IndieDevHQ standards."
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo ""
    echo "😊 Good! Repository conforms with minor warnings."
    exit 0
else
    echo ""
    echo "🚨 Issues found. Please address errors before proceeding."
    exit 1
fi