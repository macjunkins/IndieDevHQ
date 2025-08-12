**Complete GitHub CLI Guide for macOS**

**Installation**

**Install via Homebrew (Recommended)**

brew install gh

**Install via MacPorts**

sudo port install gh

**Verify Installation**

gh --version

**Initial Setup & Authentication**

**Login to GitHub**

# Interactive login (recommended)

gh auth login

  

# Login with token

gh auth login --with-token < mytoken.txt

  

# Login to GitHub Enterprise

gh auth login --hostname github.company.com

**Check Authentication Status**

gh auth status

**Set Git Protocol**

# Use HTTPS (default)

gh config set git_protocol https

  

# Use SSH

gh config set git_protocol ssh

**Repository Management**

**Create Repository**

# Create repo in current directory

gh repo create

  

# Create repo with specific name

gh repo create my-new-repo

  

# Create public repo with description

gh repo create my-repo --public --description "My awesome project"

  

# Create private repo with README

gh repo create my-private-repo --private --add-readme

  

# Create repo from template

gh repo create my-new-repo --template owner/template-repo

**Clone Repository**

# Clone your own repo

gh repo clone my-repo

  

# Clone someone else's repo

gh repo clone owner/repo-name

  

# Clone to specific directory

gh repo clone owner/repo-name ./my-directory

**Fork Repository**

# Fork and clone

gh repo fork owner/repo-name --clone

  

# Fork without cloning

gh repo fork owner/repo-name

  

# Fork with custom name

gh repo fork owner/repo-name --fork-name my-fork

**Repository Information**

# View repo details

gh repo view

  

# View specific repo

gh repo view owner/repo-name

  

# View repo in browser

gh repo view --web

  

# List your repositories

gh repo list

  

# List repos for specific user/org

gh repo list microsoft

  

# Search repositories

gh repo list --search "machine learning" --language python

**Repository Settings**

# Enable/disable features

gh repo edit --enable-issues=true

gh repo edit --enable-wiki=false

gh repo edit --enable-projects=true

  

# Change visibility

gh repo edit --visibility private

gh repo edit --visibility public

  

# Archive repository

gh repo archive owner/repo-name

  

# Delete repository (be careful!)

gh repo delete owner/repo-name --confirm

**Issues Management**

**Create Issues**

# Interactive issue creation

gh issue create

  

# Create issue with title and body

gh issue create --title "Bug in login" --body "Users cannot log in with email"

  

# Create issue with labels and assignees

gh issue create --title "Feature request" --label "enhancement,priority:high" --assignee username

  

# Create issue from template

gh issue create --template bug_report.md

  

# Create issue with milestone

gh issue create --title "New feature" --milestone "v2.0"

**List and View Issues**

# List open issues

gh issue list

  

# List all issues (including closed)

gh issue list --state all

  

# List issues assigned to you

gh issue list --assignee @me

  

# List issues with specific label

gh issue list --label bug

  

# View specific issue

gh issue view 123

  

# View issue in browser

gh issue view 123 --web

**Manage Issues**

# Close issue

gh issue close 123

  

# Reopen issue

gh issue reopen 123

  

# Edit issue

gh issue edit 123 --title "New title" --body "New description"

  

# Add labels

gh issue edit 123 --add-label "bug,priority:high"

  

# Remove labels

gh issue edit 123 --remove-label "wontfix"

  

# Assign issue

gh issue edit 123 --add-assignee username

  

# Pin issue

gh issue pin 123

  

# Transfer issue to another repo

gh issue transfer 123 owner/other-repo

**Issue Templates**

# Create bug report issue

gh issue create \

  --title "Bug: Application crashes on startup" \

  --body "## Bug Description

$(cat << 'EOF'

The application crashes when starting up.

  

## Steps to Reproduce

1. Open the application

2. Wait for 5 seconds

3. Application crashes

  

## Expected Behavior

Application should start normally

  

## Environment

- OS: macOS 13.0

- Browser: Chrome 108

- Version: 1.2.3

EOF

)" \

  --label "bug,priority:high"

**Pull Requests**

**Create Pull Requests**

# Interactive PR creation

gh pr create

  

# Create PR with title and body

gh pr create --title "Fix login bug" --body "This PR fixes the login issue by updating the authentication logic"

  

# Create draft PR

gh pr create --draft --title "Work in progress"

  

# Create PR to specific branch

gh pr create --base develop --head feature-branch

  

# Create PR with reviewers

gh pr create --reviewer username1,username2

  

# Create PR with labels

gh pr create --label "bug,ready-for-review"

**List and View Pull Requests**

# List open PRs

gh pr list

  

# List all PRs

gh pr list --state all

  

# List PRs by author

gh pr list --author username

  

# List PRs assigned to you for review

gh pr list --search "review-requested:@me"

  

# View specific PR

gh pr view 456

  

# View PR diff

gh pr diff 456

  

# View PR in browser

gh pr view 456 --web

**Manage Pull Requests**

# Checkout PR locally

gh pr checkout 456

  

# Merge PR

gh pr merge 456

  

# Merge with specific strategy

gh pr merge 456 --squash

gh pr merge 456 --rebase

gh pr merge 456 --merge

  

# Close PR without merging

gh pr close 456

  

# Reopen PR

gh pr reopen 456

  

# Edit PR

gh pr edit 456 --title "New title" --body "Updated description"

  

# Mark PR as ready for review

gh pr ready 456

  

# Convert to draft

gh pr edit 456 --add-label "draft"

**Pull Request Reviews**

# Review PR

gh pr review 456

  

# Approve PR

gh pr review 456 --approve

  

# Request changes

gh pr review 456 --request-changes --body "Please fix the formatting"

  

# Comment on PR

gh pr review 456 --comment --body "Looks good overall"

  

# View PR reviews

gh pr view 456 --json reviews

**PR Status Checks**

# View PR status

gh pr status

  

# View specific PR checks

gh pr checks 456

  

# Watch PR checks

gh pr checks 456 --watch

**Releases**

**Create Releases**

# Interactive release creation

gh release create

  

# Create release with tag

gh release create v1.0.0

  

# Create release with title and notes

gh release create v1.0.0 --title "Version 1.0.0" --notes "Initial release"

  

# Create release with assets

gh release create v1.0.0 ./dist/app.zip ./dist/app.tar.gz

  

# Create prerelease

gh release create v1.0.0-beta --prerelease

  

# Create release from specific commit

gh release create v1.0.0 --target main

  

# Generate release notes automatically

gh release create v1.0.0 --generate-notes

**Manage Releases**

# List releases

gh release list

  

# View specific release

gh release view v1.0.0

  

# Download release assets

gh release download v1.0.0

  

# Download specific asset

gh release download v1.0.0 --pattern "*.zip"

  

# Edit release

gh release edit v1.0.0 --title "New title"

  

# Delete release

gh release delete v1.0.0 --yes

**Upload Release Assets**

# Upload single file

gh release upload v1.0.0 ./dist/app.zip

  

# Upload multiple files

gh release upload v1.0.0 ./dist/*.zip

  

# Upload with custom display name

gh release upload v1.0.0 ./app.zip#"Application Bundle"

**GitHub Actions & Workflows**

**View Workflows**

# List workflows

gh workflow list

  

# View workflow details

gh workflow view main.yml

  

# View workflow in browser

gh workflow view main.yml --web

**Manage Workflow Runs**

# List recent runs

gh run list

  

# List runs for specific workflow

gh run list --workflow=main.yml

  

# View specific run

gh run view 123456789

  

# View run logs

gh run view 123456789 --log

  

# Download run artifacts

gh run download 123456789

  

# Cancel run

gh run cancel 123456789

  

# Rerun failed jobs

gh run rerun 123456789 --failed

  

# Watch run in real-time

gh run watch 123456789

**Trigger Workflows**

# Trigger workflow dispatch

gh workflow run main.yml

  

# Trigger with inputs

gh workflow run main.yml --field environment=production --field version=v1.0.0

**Gists**

**Create Gists**

# Create gist from file

gh gist create script.sh

  

# Create gist from stdin

echo "console.log('Hello World')" | gh gist create --filename hello.js

  

# Create public gist

gh gist create --public script.sh

  

# Create gist with description

gh gist create script.sh --desc "Useful shell script"

**Manage Gists**

# List your gists

gh gist list

  

# View gist

gh gist view abc123

  

# Edit gist

gh gist edit abc123

  

# Clone gist

gh gist clone abc123

  

# Delete gist

gh gist delete abc123

**Advanced Features**

**GitHub Codespaces**

# List codespaces

gh codespace list

  

# Create codespace

gh codespace create

  

# Connect to codespace

gh codespace ssh

  

# Delete codespace

gh codespace delete --codespace name

**GitHub Copilot**

# Explain command

gh copilot explain "git rebase -i HEAD~3"

  

# Suggest command

gh copilot suggest "compress a directory"

**API Access**

# Make API request

gh api /user

  

# Get repository info

gh api repos/:owner/:repo

  

# Create issue via API

gh api repos/:owner/:repo/issues --field title="API Bug" --field body="Found via API"

  

# Paginate through results

gh api --paginate /user/repos

**Configuration & Aliases**

**Configuration**

# List all config

gh config list

  

# Set editor

gh config set editor "code --wait"

  

# Set default protocol

gh config set git_protocol ssh

  

# Set pager

gh config set pager "less -R"

**Useful Aliases**

# Create aliases

gh alias set pv 'pr view'

gh alias set pc 'pr create'

gh alias set pm 'pr merge'

gh alias set ic 'issue create'

gh alias set il 'issue list'

  

# Complex aliases

gh alias set prc 'pr create --title "$1" --body-file "$2"'

gh alias set sync '!git checkout main && git pull origin main'

  

# List aliases

gh alias list

  

# Delete alias

gh alias delete pv

**Environment Variables**

# Set in your shell profile (~/.zshrc or ~/.bash_profile)

export GH_EDITOR="code --wait"

export GH_BROWSER="open"

export GH_PAGER="less -R"

  

# For GitHub Enterprise

export GH_HOST="github.company.com"

**Workflow Templates**

**Daily Development Workflow**

#!/bin/bash

# Save as ~/bin/gh-start-work

  

# Start working on a new feature

BRANCH_NAME="feature/$1"

git checkout -b $BRANCH_NAME

git push -u origin $BRANCH_NAME

  

# Create draft PR

gh pr create --draft --title "WIP: $1" --body "Work in progress for $1"

  

echo "Started work on branch: $BRANCH_NAME"

echo "Draft PR created"

**Release Workflow**

#!/bin/bash

# Save as ~/bin/gh-release

  

VERSION=$1

CHANGELOG_FILE="CHANGELOG.md"

  

# Create release with auto-generated notes

gh release create $VERSION \

  --title "Release $VERSION" \

  --generate-notes \

  --notes-file $CHANGELOG_FILE

  

# Upload build artifacts if they exist

if [ -d "dist" ]; then

  gh release upload $VERSION dist/*

fi

  

echo "Release $VERSION created successfully"

**Issue Triage Template**

#!/bin/bash

# Save as ~/bin/gh-triage

  

# List issues that need triage

echo "Issues needing triage:"

gh issue list --label "needs-triage" --json number,title,author

  

# Quick commands for triage

echo -e "\nTriage commands:"

echo "gh issue edit <number> --add-label 'bug' --add-assignee username"

echo "gh issue edit <number> --add-label 'enhancement' --milestone v2.0"

echo "gh issue close <number> --comment 'Closing as duplicate of #123'"

**Troubleshooting**

**Common Issues**

# Refresh authentication

gh auth refresh

  

# Check connectivity

gh auth status

  

# Reset configuration

rm ~/.config/gh/config.yml

gh auth login

  

# Debug mode

GH_DEBUG=1 gh repo list

  

# Use different config location

GH_CONFIG_DIR=/tmp/gh-config gh auth login

**Multiple Accounts**

# Login to different hosts

gh auth login --hostname github.com

gh auth login --hostname github.enterprise.com

  

# Switch between accounts

gh auth switch --hostname github.com

gh auth switch --hostname github.enterprise.com

This guide covers the most commonly used GitHub CLI commands and workflows. Remember to run gh help or gh <command> --help for detailed information about any specific command.