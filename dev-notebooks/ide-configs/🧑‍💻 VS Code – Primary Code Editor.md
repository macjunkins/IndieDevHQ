# Visual Studio Code as Primary IDE

## Purpose

Establish Visual Studio Code (VS Code) as the primary editor for authoring, debugging, and refactoring across heterogeneous projects, with first-class Git and GitHub workflows.

## Justification: Why VS Code

- Breadth of language and framework support via a mature extension ecosystem (fast onboarding for mixed stacks).
- Integrated Git client with native support for GitHub authentication, reviews, pull requests, and issues.
- Consistent, keyboard-driven workflow (Command Palette, Quick Open) that scales from small edits to large refactors.
- Built-in debugger, terminal, and task runner reduce context switching and external tooling overhead.
- Light, cross-platform footprint suitable for local-first development and offline workflows.
- Optional AI assistance through GitHub Copilot without requiring a separate IDE.

---

## Installation

1. Download and install: https://code.visualstudio.com
2. Recommended extensions:
   - Swift Language (Swift support)
   - GitHub Copilot (if enabled)
   - GitHub Pull Requests and Issues (deep GitHub integration)
   - Markdown All in One (documentation and README authoring)

## Configuration

- Theme: Install "Gruvbox" from Extensions → Themes.
- Terminal: Use zsh by default; optionally configure Warp as the external terminal.

Add to settings.json:

```json
{
  "terminal.integrated.defaultProfile.osx": "zsh",
  "terminal.external.osxExec": "warp"
}
```

## Core Shortcuts

- ⌘P — Quick Open files
- ⌘⇧P — Command Palette
- ⌃` — Toggle integrated terminal
- ⌘B — Toggle Explorer sidebar

---

## Git and GitHub Workflow

VS Code provides a complete GitHub workflow without leaving the editor. Authenticate once and use source control, PR review, and issue triage directly in the UI.

### Authentication

- Sign in when prompted (browser-based OAuth). Use a Personal Access Token (PAT) if requested.

### Clone

- ⌘⇧P → "Git: Clone" → paste GitHub repository URL → choose a local folder → open in VS Code.

### Commit and Push (Source Control View)

1. Stage changes (click + next to a file or Stage All).
2. Enter a commit message and commit.
3. Push via the … menu → Push.

### Sync via Terminal (alternative)

```bash
git pull origin main
git add .
git commit -m "Your changes"
git push origin main
```

### Pull Requests and Reviews

- Install "GitHub Pull Requests and Issues".
- Create branches, open PRs, request reviews, comment, and approve from within VS Code.
- Check out PR branches locally for validation before merging.

---

## Tasks and Automation

Use tasks.json to standardize build/test commands and enable one-keystroke runs. Example skeleton:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "build",
      "type": "shell",
      "command": "echo replace-with-your-build",
      "group": "build"
    }
  ]
}
```

Trigger tasks via ⌘⇧P → "Tasks: Run Task" or bind to a shortcut.

---

## Operating Guidance

- Prefer the Source Control view for routine commits; use the terminal for advanced Git operations.
- Keep extension set minimal and purposeful to maintain performance.
- Use workspace settings (project-level .vscode) to keep team defaults consistent.

## Troubleshooting

- If push/pull prompts repeatedly, re-run GitHub sign-in (Accounts menu) or update the PAT.
- Verify the repository remote (origin) and default branch (main) when configuring sync tasks.

---

## Summary

VS Code consolidates editing, debugging, terminal, and Git/GitHub workflows in a single environment. This reduces tool switching, improves execution speed, and supports a local-first development approach with optional GitHub-native collaboration features.
