# Grab GitHub Issues into Your Workspace

This guide shows how to pull any GitHub issue (with comments) into a local Markdown file so we can use it as shared context directly in the editor.

- Uses GitHub CLI (gh) on macOS/zsh
- Saves issues under `session-logs/issues/`
- Includes an optional script and VS Code task for one-command usage

---

## 1) Prerequisites

- Install GitHub CLI and sign in
  - Install: `brew install gh`
  - Authenticate: `gh auth login`
- Run commands from the repo root (this folder)

---

## 2) Quick Start (one-off)

Grab an issue and save it as Markdown locally:

```bash
# From the repo root
mkdir -p session-logs/issues

# Replace 123 with your issue number; adjust --repo as needed
gh issue view 123 \
  --repo macjunkins/IndieDevHQ \
  --comments \
  > session-logs/issues/issue-123.md
```

Open the saved file in VS Code so it becomes context:

```bash
code session-logs/issues/issue-123.md \
  || open -a "Visual Studio Code" "session-logs/issues/issue-123.md"
```

Tips:
- List issues: `gh issue list --repo macjunkins/IndieDevHQ`
- Filter by label: `gh issue list --label "phase:3" --repo macjunkins/IndieDevHQ`

---

## 3) Reusable Script (recommended)

Add a small helper script for repeatable usage.

Create `scripts/grab-issue.sh` with:

```bash
#!/usr/bin/env bash
set -euo pipefail

NUM="${1:-}"
REPO="${2:-}"
OUT_DIR="session-logs/issues"

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI not found. Install with: brew install gh" >&2; exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "Run: gh auth login" >&2; exit 1
fi

if [[ -z "$NUM" ]]; then
  echo "Usage: scripts/grab-issue.sh <issue-number> [owner/repo]" >&2; exit 1
fi

if [[ -z "$REPO" ]]; then
  REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || true)"
  if [[ -z "$REPO" ]]; then
    echo "Provide owner/repo explicitly, e.g. macjunkins/IndieDevHQ" >&2; exit 1
  fi
fi

mkdir -p "$OUT_DIR"
OUT_FILE="$OUT_DIR/issue-$NUM.md"

{
  echo "# $REPO issue #$NUM"
  echo
  gh issue view "$NUM" --repo "$REPO" --comments
} > "$OUT_FILE"

echo "Saved: $OUT_FILE"
```

Make it executable:

```bash
chmod +x scripts/grab-issue.sh
```

Use it:

```bash
# Explicit repo
scripts/grab-issue.sh 123 macjunkins/IndieDevHQ

# Or rely on current repo context (inside this repo)
scripts/grab-issue.sh 123
```

---

## 4) VS Code Task (optional)

Add a task so you can run it from the Command Palette.

Create or update `.vscode/tasks.json`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Grab GitHub Issue",
      "type": "shell",
      "command": "bash",
      "args": [
        "-lc",
        "scripts/grab-issue.sh ${input:issueNumber} macjunkins/IndieDevHQ && (command -v code >/dev/null && code session-logs/issues/issue-${input:issueNumber}.md || open -a \"Visual Studio Code\" \"session-logs/issues/issue-${input:issueNumber}.md\")"
      ],
      "problemMatcher": []
    }
  ],
  "inputs": [
    {
      "id": "issueNumber",
      "type": "promptString",
      "description": "Issue number"
    }
  ]
}
```

Run it: Command Palette → “Tasks: Run Task” → “Grab GitHub Issue”.

---

## 5) Keep Saved Issues Out of Commits (optional)

Add to `.gitignore` if you don’t want to commit fetched issues:

```gitignore
session-logs/issues/
```

---

## 6) Advanced Variations

- Only body (no comments): `gh issue view 123 --repo macjunkins/IndieDevHQ > file.md`
- Fetch by URL: `gh issue view https://github.com/OWNER/REPO/issues/123 --comments > file.md`
- Search first: `gh issue list --search "label:bug state:open" --repo macjunkins/IndieDevHQ`

---

## 7) Troubleshooting

- “gh: command not found”: Install with Homebrew: `brew install gh`.
- “You are not logged in to any GitHub hosts”: run `gh auth login`.
- Private repo access issues: ensure the token has repo scope and you’re logged into the correct account.
- Rate limits: wait or authenticate to raise limits.

---

## 8) Workflow Tip

- Grab the issue into `session-logs/issues/issue-<num>.md`.
- Open it in the editor and proceed—its contents become shared context for discussion and implementation.

---

Want me to wire up the script and tasks for you now?


*Via CoPilot GPT-5 (Preview)*