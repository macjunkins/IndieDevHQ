# 🍏 When and Why to Use Xcode

**🎯 Purpose:** For Interface Builder 🖼️, Simulator testing 📱, Apple provisioning 🛡️, and App Store submission 🛒.

---

## 1️⃣ **Use Cases**

- 🏃‍♂️ Building and running apps on Simulator
- 📝 Configuring signing and provisioning profiles
- 🚀 Submitting to the App Store
- 🕵️‍♂️ Debugging with Instruments

---

## 2️⃣ **When to Open**

- 📱 Need to run the iOS Simulator
- 🖥️ SwiftUI previews not working in VS Code
- 🔑 Certificate or device profile problems
- 📦 App Store packaging

---

## 3️⃣ **Tips**

- 🆕 Keep Xcode updated via the Mac App Store
- 📂 Open `.xcodeproj` or `.xcworkspace` when needed
- ⚡ Use “Quick Actions” (⌘⇧O for file nav, ⌘R to run)

---

## 🍎 **Xcode + GitHub**

**🤝 Use Case:** App submission, provisioning, and team workflows via GitHub.

---

### 1️⃣ **Clone a GitHub Repo**

- 📁 `File > Open` → select cloned repo (use terminal or GitHub Desktop first)
- 🔗 OR: `Source Control > Clone` → paste GitHub URL

---

### 2️⃣ **Set Up Git Tracking**

If starting a new project:

- 🛠️ Create project in Xcode
- 💻 Open Terminal and:

    ```bash
    git init
    git remote add origin https://github.com/YOUR_USERNAME/app-name.git
    git add .
    git commit -m "Initial commit"
    git push -u origin main
    ```

---

### 3️⃣ **View Source Control**

- ✅ Enable: `Xcode > Settings > Source Control > Enable Source Control`
- 🧭 Use `Source Control Navigator` (⌘2)

---

## 🔐 GitHub Authentication Tips (Applies to All)

- 🖇️ Use GitHub CLI (`gh auth login`) to streamline auth across tools
- 🔑 Create a Personal Access Token at [github.com/settings/tokens](https://github.com/settings/tokens)
- 🗝️ Store credentials in Keychain or credential helper

