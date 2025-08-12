# 🧭 AI-Augmented Solo Developer Workflow

> **No one tool does it all. Orchestrate a stack. Own your flow.**  
> Each tool in your ecosystem has a clear, focused role. You use the best of what each does without bloating or duplicating effort. AI fits into this stack as a force multiplier—not a full replacement.

---

## 🎯 Purpose & Scope

This document serves as the **master reference** for AI-augmented solo software development. It consolidates the core philosophy, tool orchestration strategies, and workflow patterns that enable productive solo development with AI assistance.

**What this covers:**
- Core philosophy and principles for AI-tool integration
- Tool charter and role definitions for your development stack
- The meta-loop system for feedback-driven development
- Git-based traceability and workflow strategies
- Quick start guide for implementing this system

**Related documents:**
- [Implementation & Automation](../03_Implementation/implementation_automation.md) - Technical setup and scripts
- [Documentation Standards](../02_Documentation/documentation_standards.md) - Documentation frameworks  
- [Project Management](../05_Project_Management/project_management.md) - Templates and workflows

---

## 🧠 Core Philosophy

### The Orchestra Principle
You're not just picking tools—you're designing a **workflow ecosystem** that mirrors a full product team:

| Role | Tools | Purpose |
|------|-------|---------|
| **PM** | Apple Reminders + Roadmaps | Strategic planning & life balance (30k ft view) |
| **Designer** | User Stories + AI UI prompts | User experience and interface design |
| **Engineer** | IDE + Cursor/Kilo | Code-level implementation & refinement |
| **QA** | AI test generation | Quality assurance and testing |
| **DevOps** | gh CLI + build automation | Automation and deployment |

### Key Insights
- **Token Efficiency**: Focus on structured, precise inputs rather than conversational overhead
- **Explicit Handoffs**: Force clear component definitions through limited context
- **Human-Driven Architecture**: Keep humans in control of system design and coordination
- **Feedback Loops**: Use Git and structured tracking to maintain alignment between planning and implementation

### Three-Tool Framework for AI Integration
All AI tools fit into three fundamental types:
1. **Question**: Inquiry and analysis tools (ChatGPT for strategy)
2. **Agent**: Implementation and execution tools (Cursor/Kilo for coding)  
3. **Explain**: Documentation and clarification tools (AI for docs/comments)

---

## 🔄 The Meta-Loop System

Your system isn't just tools—it's a feedback loop:

```text
Vision / Requirements → User Stories → GitHub Issues
            ↓                     ↓
     Prompt AI agents → Generate code/tests
            ↓                     ↓
     Commit / PR / Feedback → Back to Stories
```

You're minimizing overhead, maximizing reuse, and keeping **you** at the center of the loop, not the tools.

---

## 🧱 Core Documentation Stack

You're building a lean, prompt-friendly set of docs to power AI agents, code generation, and planning.

| Doc Name | Purpose |
|----------|---------|
| `vision.md` | Long-term direction and rationale |
| `requirements.md` | What the software should do |
| `architecture.md` | System-level design and technology choices |
| `roadmap.md` | Release and milestone planning |
| `user_stories/` | Milestone-scoped stories = prompt + task base |
| `test_plan.md` | How functionality is verified |
| `api_spec.yaml` | API contracts (if applicable) |
| `story_to_code_map.md` | Traceability between stories and code |

---

## 🧩 Milestone-Based Story Organization

You proposed—and we validated—a scalable structure to control story sprawl:

```
/docs/user_stories/
  ├── milestone_0_1_alpha.md
  ├── milestone_0_2_usb_flash.md
  ├── milestone_0_3_qemu_test.md
  └── milestone_0_4_gui_shell.md
```

**Benefits:**
- Keeps story files small and focused
- Aligns with GitHub Milestones, PRs, and Projects
- Helps with sprint planning and AI prompt targeting
- Allows tracking by feature domain or version scope

---

## 🧠 User Stories as AI Prompts

### Why User Stories Make Great Prompts
User stories naturally follow a structure that works well for LLMs:
> "As a [type of user], I want to [do something], so that [benefit]."

This gives:
- **Role** → context for behavior
- **Action** → the core feature
- **Goal** → the "why" behind it

### Using Stories As-Is
**Yes, you should often use the user story _as the prompt itself_.**

Example:
> _"As a user, I want to flash a USB with an ISO so that I can install KilnOS."_

This already contains:
- a clear actor (`user`)
- a concrete action (`flash a USB with an ISO`)
- a goal (`install KilnOS`)

### Template Workflow: Turning Stories into Prompts
1. **Write the user story**
2. **Tag it with type** (feature, bug, devops, UI, etc.)
3. **Convert to a system-level prompt** (or use as-is)
4. **Feed to IDE AI or planning assistant**

Confirmed that:
- You **can and should** use user stories as direct AI prompts
- Structured stories help IDE AI tools (Cursor, Kilo, Copilot) perform better
- Markdown format with metadata makes stories reusable, trackable, and actionable

**Example format:**
```md
### 🔧 Story: Flash ISO to USB

- **As a** user  
- **I want to** flash an ISO to a USB  
- **So that** I can install KilnOS

**Tags**: flash, iso, UX  
**Status**: To Do
```

---

## 🧰 Tool Charter

Each tool has a clearly defined role in your stack:

| Tool | Role | Strengths | What It's NOT |
|------|------|-----------|---------------|
| **ChatGPT/Claude** | Strategy, architecture, planning, teaching | System thinking, complex analysis, documentation | Your IDE, build tool, or junior developer |
| **Markdown docs** | Source of truth, version-controlled prompts | Referenceable by humans and LLMs, version controlled | Task manager or UI for implementation |
| **GitHub Issues** | Task management + Copilot input | Trackable, actionable work units | Source of truth or planning tool |
| **GitHub Projects** | Development workflow + sprint board | Execution-level dev board, GitHub-native features | Strategic planning or personal task list |
| **Cursor / Kilo** | Code generation, refactoring, and local AI agent | Turn user stories into code, debugging | Planner, spec writer, or multi-file architect |
| **Copilot (Issues)** | Optional agent for PR and subtask suggestion | Generate PRs from branches tied to issues | Source of truth or comprehensive planner |
| **Apple Reminders** | High-level personal planner (30k ft strategy) | Multi-project view, kanban-style prioritization | Code-level tracker or GitHub integration |

### Tool Usage Guidelines

**Strategic LLM (ChatGPT/Claude)**
- Use for: System architecture, strategic decisions, complex problem breakdown
- Think of as: Your "AI cofounder" for clarity, planning, design, and system thinking
- Best practice: Revisit old threads before starting new conversations

**User Stories (`user_stories.md`)**
- Use for: Prompt base, task definition, behavioral specifications
- Keep: Short, specific, and AI-parseable with bullet points or YAML-style metadata
- Sync to: GitHub Issues via CLI for trackable work units

**IDE AI (Cursor/Kilo)**
- Use for: Code implementation from user stories, refactoring, debugging
- Think of as: Smart developers who thrive on small, focused tasks
- Feed them: User story + supporting documentation for best results

---

## 🔀 Git Strategy

You're adopting a **refined GitHub Flow**:

- Branch per story or issue, scoped by milestone:
  ```
  feature/0.2-flash-iso
  bugfix/0.3-checksum-verification
  ```
- PRs tied to issues and milestones
- Use **draft PRs** with Copilot or AI feedback early in the cycle
- Auto-generate changelogs with `release-drafter`
- PR template includes story reference and milestone info

---

## 🧱 Folder Structure Summary

```
/docs
  ├── 00_vision.md
  ├── 01_requirements.md
  ├── 02_architecture.md
  ├── 03_roadmap.md
  ├── 04_user_stories/
  │     ├── milestone_0_1_alpha.md
  │     ├── milestone_0_2_usb_flash.md
  │     └── ...
  ├── 05_test_plan.md
  ├── 06_api_spec.yaml
  ├── 07_story_to_code_map.md

/.github
  ├── PULL_REQUEST_TEMPLATE.md
  └── release-drafter.yml (optional)

/scripts
  └── sync_stories_to_issues.sh (TBD)
```

---

## 🚀 What This Enables

- **Precision**: Right tool for the task, right time
- **Scalability**: As your projects grow, your system won't break
- **Resilience**: Tools can be swapped or updated without collapsing your flow
- **Control**: You're not dependent on one platform's opinionated workflow

---

## ✅ What's Working

- You've created a flexible, modular system that works with both humans and AI
- The docs feed directly into issues → code → PRs
- You avoid over-documentation while preserving clarity
- You stay tool-agnostic and replaceable (important for resilience)

---

## ⚠️ Areas to Keep in Mind

- Consider writing a script to sync GitHub Issues **back** to a changelog or summary
- Story-to-code traceability needs discipline (track implemented stories manually or via comment tags)
- Copilot may suggest weak PRs if story or code context is vague

---

## 📌 Next Steps

### Phase 1: Setup (Week 1)
- [ ] Create `/docs/user_stories.md` with proper format
- [ ] Set up GitHub Issues sync script
- [ ] Configure VS Code tasks for daily review
- [ ] Create PR template

### Phase 2: Implementation (Week 2-3)
- [ ] Write first batch of user stories
- [ ] Sync to GitHub Issues
- [ ] Create branches following naming convention
- [ ] Implement first feature using this workflow

### Phase 3: Optimization (Week 4)
- [ ] Review metrics and adjust workflow
- [ ] Create story-to-code mapping
- [ ] Set up automated changelog generation
- [ ] Document lessons learned

### Phase 4: Scaling (Ongoing)
- [ ] Apply to multiple concurrent projects
- [ ] Refine prompt templates based on success patterns
- [ ] Share workflow with team/collaborators
- [ ] Continuous improvement based on feedback

---

## 🎯 Quick Start Guide

### For New Projects
1. **Copy this entire folder** into any new repository for instant workflow setup
2. **Start with the overview** to understand the system before diving into details
3. **Use milestone-based organization** to keep user stories manageable
4. **Implement Git traceability** using the commit message conventions
5. **Regular quality reviews** to ensure the system remains effective

### Daily Workflow
```bash
# Quick daily review - add this as a VS Code task or alias
git log --oneline --since="yesterday" && echo -e "\nToday's focus: $(cat docs/user_stories/*.md | grep -A1 'Status.*In Progress')"
```

### Teaching Documentation Summary
| Task | Where to Go | What to Do |
|------|-------------|------------|
| Write a new feature idea | `user_stories.md` | Follow the "As a user..." format |
| Design architecture | `architecture.md` + ChatGPT | Use ChatGPT to sketch, then refine in Markdown |
| Plan implementation | Sync stories to GitHub Issues | Use CLI to create structured tasks |
| Write code | Cursor or Kilo | Feed user story + context, edit/refactor with AI |
| Track dev progress | GitHub Projects | Move issues through workflow |
| Track life/project goals | Apple Reminders | Use columns for "Now / Later / Someday" |

1. **Finalize documentation structure** (see [`../02_Documentation/documentation_standards.md`](../02_Documentation/documentation_standards.md))
2. **Implement automation scripts** (see [`../03_Implementation/implementation_automation.md`](../03_Implementation/implementation_automation.md))
3. **Set up quality validation** (see [`../04_Quality_Security/quality_assurance.md`](../04_Quality_Security/quality_assurance.md))
4. **Create project templates** for easy reuse across repositories 