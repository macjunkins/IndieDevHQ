# Git Cheat Sheet – GitHub Edition

A comprehensive reference for Git and GitHub workflows optimized for IndieDevHQ methodology.

## 🔧 **Setup**

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
```

## 📁 **Start a New Project**

```bash
git init
git remote add origin https://github.com/YOUR_USERNAME/your-repo.git
```

### 🚀 **Clone a Repo**

```bash
git clone https://github.com/YOUR_USERNAME/your-repo.git
cd your-repo
```

### ✅ **Check Status & Changes**

```bash
git status              # See what's changed
git diff                # See unstaged changes
git diff --staged       # See staged changes
```

### 📦 **Add & Commit**

```bash
git add .                         # Stage all changes
git add filename.swift            # Stage specific file
git commit -m "Describe the change"
```

### 🔄 **Push to GitHub**

```bash
git push origin main              # Push commits to main
git push -u origin main           # First time push (sets upstream)
```

### 📥 **Pull from GitHub**

```bash
git pull origin main
```

### 🌱 **Branches**

```bash
git branch                        # List local branches
git branch new-feature            # Create a branch
git checkout new-feature          # Switch to a branch
git checkout -b new-feature       # Create + switch to branch
```

### 🔁 **Merge Changes**

```bash
git checkout main
git pull origin main              # Ensure up to date
git merge new-feature             # Merge a branch into main
```

### 💣 **Undo & Fix**

```bash
git restore filename.swift        # Discard changes to a file
git reset HEAD~1                  # Undo last commit (keep changes)
git reset --hard HEAD             # Reset to last commit (⚠️ permanent)
```

### 🧼 **Clean Up**

```bash
git branch -d new-feature         # Delete local branch
git push origin --delete new-feature  # Delete remote branch
```

### 🔐 **Authentication**

```bash
gh auth login                     # GitHub CLI login (recommended)
```

Or use a [Personal Access Token](https://github.com/settings/tokens) if prompted in VS Code or terminal.

### 🧠 Pro Tips

- `git log --oneline` – Short commit history
- `git stash` – Save uncommitted changes temporarily
- `.gitignore` – Add files/folders to exclude from Git (e.g., `.DS_Store`, `*.xcuserstate`)
- `git remote -v` – Show current GitHub remotes

## IndieDevHQ Integration

This cheat sheet integrates with the IndieDevHQ methodology:

- **Use with automation scripts**: `./scripts/init-project.sh` creates repositories following these patterns
- **GitHub integration**: `./scripts/gh-automation.sh` automates many of these setup steps
- **Quality checks**: `./scripts/check-conformity.sh` validates repository structure
- **See also**: [GitHub CLI Guide](github_cli_guide_macos.md) for advanced automation

---

*Integrated from dev-notebooks/git-workflows/ for IndieDevHQ Phase 4 enhancement*