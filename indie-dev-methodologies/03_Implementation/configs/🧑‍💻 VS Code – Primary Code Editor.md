# 💻 VS Code as primary IDE

## **🎯 Purpose:** Write, debug, refactor

I messed around for countless hours with other IDE and generative AI tools and systems. Only to come back to VS Code to fix what I couldn't get done in them. Local Models and Tools are better. And GitHub with all the CoPilot bells and whistles will end up costing me the same amount of money as I was planning anyway.

### 1️⃣ **Install**

- ⬇️ Download from: [https://code.visualstudio.com](https://code.visualstudio.com/)
- 🧩 Install extensions:
  - 🦅 Swift support (`Swift Language`)
  - 🤖 GitHub Copilot (if enabled)
  - 📝 Markdown All in One (for notes, README editing)

### 2️⃣ **Configure**

- 🎨 Theme: Install `Gruvbox` from Extensions → Themes
- 💻 Terminal: Set integrated terminal to Warp (optional)

// settings.json
    ```json
    "terminal.integrated.defaultProfile.osx": "zsh",
    "terminal.external.osxExec": "warp",
    ```

### 3️⃣ **Shortcuts to Learn**

- 🔍 `⌘P` – Quick file open
- 🧭 `⌘ShiftP` – Command palette
- 💡 `⌃\`` – Toggle terminal
- 📚 `⌘B` – Toggle sidebar

### 4️⃣ **Workflow Tips**

- 🗂️ Use the Source Control tab for quick commits
- 🔗 Pair with GitHub repos via `Clone from GitHub`
- ⚡ Use tasks (`tasks.json`) for build commands

---

## 🧑‍💻 **VS Code + GitHub**

**🔧 Use Case:** Your main coding + Git environment.

### 1️⃣ **Clone a Repo**

- 🚀 `⌘⇧P` → `Git: Clone` → paste GitHub repo URL
- 📂 Choose local folder → VS Code will offer to open it

### 2️⃣ **Commit Workflow**

Use the **Source Control panel** (left sidebar):

- ➕ Stage: Click `+` next to files
- 📝 Commit: Add a message and click ✓
- ⬆️ Push: Click the "…", then `Push`

### 3️⃣ **Sync via Terminal**

```bash
git pull origin main
git add .
git commit -m "Your changes"
git push origin main
```

### 4️⃣ **GitHub Authentication**

- 🔑 When you first push/pull, GitHub will ask for authentication via your browser
- 🛡️ Use a Personal Access Token (PAT) if prompted

---
