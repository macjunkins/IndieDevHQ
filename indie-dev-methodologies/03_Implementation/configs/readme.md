# 🧑‍💻 Personal IDE Notebook

> A comprehensive guide to my development environment setup, workflows, and IDE preferences for sustainable, local-first development.

## 📚 Overview

This repository serves as my personal knowledge base for IDE configuration, development workflows, and tool comparisons. It's designed for developers who prioritize **local-first development**, **ecosystem independence**, and **long-term sustainability** over hype-driven tool choices.

## 🎯 Philosophy

- **Local-first**: Prefer tools that work offline and don't lock you into cloud ecosystems
- **Ecosystem independence**: Avoid vendor lock-in when possible
- **Sustainable workflows**: Choose tools that scale with your needs over time
- **Practical over perfect**: Use the right tool for the job, even if it means switching contexts

## 🛠️ Development Stack

### Primary IDE: VS Code
- **Purpose**: Main coding, debugging, and refactoring environment
- **Strengths**: Extensible, lightweight, excellent Git integration
- **Extensions**: Swift support, GitHub Copilot, Markdown All in One
- **Theme**: Gruvbox for reduced eye strain
- **Terminal**: Integrated with Warp (optional)

### Specialized: Xcode
- **Purpose**: iOS development, Interface Builder, Simulator testing
- **When to use**: App Store submission, provisioning profiles, SwiftUI previews
- **Integration**: Git workflows via Source Control Navigator

### AI Assistants: Juni vs Copilot
- **Juni (JetBrains)**: Better for local-first, ecosystem independence, full-stack flexibility
- **Copilot (GitHub)**: Excellent for JavaScript/TypeScript, cloud-first workflows
- **Recommendation**: Juni for Rust/Tauri/Kotlin, Copilot for web/Electron development

## 📁 Repository Structure

```
IDE Notebook/
├── 🧑‍💻 VS Code – Primary Code Editor.md    # VS Code setup and workflows
├── 🍎 Xcode – Use Only When Necessary.md     # Xcode configuration and use cases
├── Junie_vs_CoPilot.md                       # AI assistant comparison
└── readme.md                                 # This file
```

## 🚀 Quick Start

### VS Code Setup
1. Download from [code.visualstudio.com](https://code.visualstudio.com/)
2. Install essential extensions:
   - Swift Language support
   - GitHub Copilot (if enabled)
   - Markdown All in One
3. Configure theme and terminal preferences
4. Learn key shortcuts: `⌘P`, `⌘ShiftP`, `⌃\``, `⌘B`

### Git Workflow
- Use Source Control panel for quick commits
- Clone repos directly from GitHub
- Authenticate with Personal Access Token when needed

## 🔧 Key Workflows

### VS Code + GitHub
1. **Clone**: `⌘⇧P` → `Git: Clone` → paste repo URL
2. **Commit**: Use Source Control panel → stage files → add message → commit
3. **Push**: Source Control panel → "..." → Push

### Xcode + GitHub
1. **Clone**: File → Open → select cloned repo
2. **Setup**: Enable Source Control in Xcode Settings
3. **Navigate**: Use Source Control Navigator (`⌘2`)

## 🧠 AI Assistant Strategy

### Juni (Recommended for Local-First)
- **Best for**: Rust/Tauri, Kotlin/Compose, full-stack projects
- **Advantages**: IDE-aware, ecosystem independent, local LLM support coming
- **Use case**: Primary development environment

### Copilot (Web/Electron Focus)
- **Best for**: JavaScript/TypeScript, Electron apps, quick prototyping
- **Advantages**: Excellent freeform generation, GitHub integration
- **Use case**: VS Code workflows, web development

## 📖 Detailed Guides

- **[VS Code Setup](./🧑‍💻%20VS%20Code%20–%20Primary%20Code%20Editor.md)**: Complete configuration and workflow guide
- **[Xcode Usage](./🍎%20Xcode%20–%20Use%20Only%20When%20Necessary.md)**: When and how to use Xcode effectively
- **[AI Assistant Comparison](./Junie_vs_CoPilot.md)**: Detailed Juni vs Copilot analysis

## 🎨 Customization

### VS Code Settings
```json
{
  "terminal.integrated.defaultProfile.osx": "zsh",
  "terminal.external.osxExec": "warp"
}
```

### Theme Preferences
- **VS Code**: Gruvbox theme for reduced eye strain
- **Terminal**: Warp integration for enhanced terminal experience

## 🔐 Authentication

### GitHub Setup
1. Use GitHub CLI: `gh auth login`
2. Create Personal Access Token at [github.com/settings/tokens](https://github.com/settings/tokens)
3. Store credentials in Keychain or credential helper

## 🤝 Contributing

This is a personal notebook, but if you find it useful:
- Fork the repository
- Add your own IDE configurations and workflows
- Share improvements via pull requests

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

---

**💡 Tip**: This notebook is designed to evolve with your development needs. Update it as you discover new tools, workflows, or configurations that improve your productivity.

**🔗 Related**: Check out the individual markdown files for detailed guides on each IDE and tool.
