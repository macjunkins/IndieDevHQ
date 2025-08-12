# AI-Augmented Development Workflow

> _A comprehensive guide for solo developers using AI tools effectively in software development workflows._

---

## 🧭 Guiding Principles

### Core Philosophy
**No tool does everything. Orchestrate, don't consolidate.**

Each tool has a well-defined place in the stack. Tools can be swapped or reconfigured, but _roles remain consistent_.

### Key Insights
- **Token Efficiency**: Focus on structured, precise inputs rather than conversational overhead
- **Explicit Handoffs**: Force clear component definitions through limited context
- **Human-Driven Architecture**: Keep humans in control of system design and coordination
- **Feedback Loops**: Use Git and structured tracking to maintain alignment between planning and implementation

---

## 🧱 Core Tool Roles & Integration

### 🧠 1. **Strategic LLM (ChatGPT/Claude)**

**Role**: System Architect, Strategic Advisor, Document Generator

**Primary Use**:
- Design architecture & planning docs
- Translate ideas into prompts, roadmaps, and specs
- Be a thought partner to challenge or refine your logic
- Break down complex problems into manageable components

**What It's _Not_**:
- Your IDE
- A replacement for dedicated build/test tools
- A junior developer needing "context"

> 📘 _Teaching Note_: Think of this as your "AI cofounder." Use it for clarity, planning, design, and system thinking. Revisit old threads before starting new ones.

### 📝 2. **Markdown Files (`/docs/*.md`)**

**Role**: Single-source documentation

**Primary Use**:
- Store requirements, architecture, tech specs
- Maintain `user_stories.md` as the canonical prompt base
- Draft and refine prompts _before_ using in IDE AI

**What It's _Not_**:
- A task manager
- A UI for implementation

> 📘 _Teaching Note_: These files are referenceable by both humans and LLMs. Always update _before_ pushing changes to GitHub Issues or IDE prompts.

### 🧠 3. **User Stories (`user_stories.md`)**

**Role**: Prompt base, Task definition, Behavioral spec

**Primary Use**:
- Write stories in natural language (As a X, I want Y, so that Z)
- Use as raw prompts in Cursor/Kilo
- Sync to GitHub Issues via CLI

**What It's _Not_**:
- Fully technical specs
- Automatically actionable by CI/CD

> 📘 _Teaching Note_: Keep user stories short, specific, and AI-parseable. Use bullet points or YAML-style formatting for metadata (tags, priority, status).

### 🗂 4. **GitHub Issues**

**Role**: Trackable, actionable work units

**Primary Use**:
- Synced from `user_stories.md`
- Managed via GitHub Projects
- Used by Copilot to generate PRs or subtasks

**What It's _Not_**:
- Source of truth
- Planning tool

> 📘 _Teaching Note_: Don't write issues directly. Write them in Markdown, then sync via script. Keep them AI-readable and update them via the CLI.

### 📊 5. **GitHub Projects**

**Role**: Execution-level dev board

**Primary Use**:
- Sprint planning
- Track open issues
- Use GitHub-native features (automation, columns)

**What It's _Not_**:
- Strategic planning tool
- Personal task list

> 📘 _Teaching Note_: Treat this like a _team project board_. Keep columns clear (Backlog, In Progress, Done) and regularly triage from your synced issues.

### ⚙️ 6. **Cursor / Kilo (IDE + AI Agent)**

**Role**: Code implementer and prompt executor

**Primary Use**:
- Turn user stories into code
- Refactor existing modules
- Debug, test, and experiment with logic

**What It's _Not_**:
- Planner or spec writer
- Multi-file architect (use ChatGPT for that)

> 📘 _Teaching Note_: Think of these as _smart developers_. Feed them a user story + supporting doc. They thrive on small, focused tasks.

### 🧾 7. **Apple Reminders**

**Role**: Strategic overview and personal planner

**Primary Use**:
- Multi-project view
- Kanban-style prioritization (columns = stages)
- Track life + work balance

**What It's _Not_**:
- Code-level tracker
- Integrated with GitHub or IDE

> 📘 _Teaching Note_: Treat this like your "mission control." Reminders hold what GitHub doesn't—vision, reflection, context switching.

---

## 🔄 Three-Tool Framework for AI Integration

**Core Categories**: All AI tools fit into three fundamental types:
1. **Question**: Inquiry and analysis tools
2. **Agent**: Implementation and execution tools  
3. **Explain**: Documentation and clarification tools

### Phase 1: Question the Problem
- What problem am I actually solving?
- What does success look like?
- What are the real constraints (time, complexity, dependencies)?
- What's the absolute minimum that would be useful?

### Phase 2: Explain the Solution Space
- Document core workflows and user interactions
- Map what needs to persist vs. what's ephemeral
- Define scope boundaries clearly
- Create dependency structure and build order

### Phase 3: Agent Implementation
- Build one component at a time per specifications
- Test against specifications
- Fix/iterate based on results
- Progress through dependency chain

---

## 🎯 User Stories as Prompts

### Why User Stories Make Great Prompts

User stories naturally follow a structure that works well for LLMs:

> "As a [type of user], I want to [do something], so that [benefit]."

This gives:
- **Role** → context for behavior
- **Action** → the core feature
- **Goal** → the "why" behind it

LLMs love that kind of structure. It helps generate code, tests, UI, and documentation that all align with the user's intent.

### Using User Stories As-Is

**Yes, you should often use the user story _as the prompt itself_.**

Example:
> _"As a user, I want to flash a USB with an ISO so that I can install KilnOS."_

This already contains:
- a clear actor (`user`)
- a concrete action (`flash a USB with an ISO`)
- a goal (`install KilnOS`)

That's exactly the kind of high-level instruction that modern models are built to understand and reason from.

### Template Workflow: Turning Stories into Prompts

1. **Write the user story**
2. **Tag it with type** (feature, bug, devops, UI, etc.)
3. **Convert to a system-level prompt** (or use as-is)
4. **Feed to IDE AI or planning assistant**

### File Structure Suggestion

Maintain a file like `/docs/user_stories.md` with format:

```md
## User Story: Flash USB with ISO

**Story**:  
As a user, I want to flash a USB with an ISO so I can install KilnOS.

**Prompt**:  
Write a Tauri-compatible Rust function that selects an ISO file, selects a USB device, and flashes the ISO to that device. Include safety checks and user feedback.

**Status**: In Progress
```

---

## 🔁 Git-Based Feedback Loops

### Story Completion Tracking

```bash
# See which stories have actual commits
git log --grep="milestone_0_2" --oneline --since="1 month ago"

# Track story velocity by counting commits per milestone
git log --grep="Story:" --pretty=format:"%h %s %cr" --since="2 weeks ago"
```

### Development Time Analysis

```bash
# See your commit frequency by day/hour to identify productive periods
git log --pretty=format:"%h %ad %s" --date=format:"%Y-%m-%d %H" | sort

# Identify long gaps between commits (might indicate blocked stories)
git log --pretty=format:"%cr %s" -10
```

### Automated Feedback Scripts

**Weekly Development Retrospective**:

```bash
#!/bin/bash
# weekly_retro.sh
echo "=== This Week's Development ==="
git log --since="1 week ago" --pretty=format:"- %s (%cr)" --grep="Story:"

echo -e "\n=== Milestone Progress ==="
for milestone in $(git log --grep="milestone_" --pretty=format:"%s" | sed 's/.*milestone_\([0-9_]*\).*/milestone_\1/' | sort -u); do
    count=$(git log --grep="$milestone" --oneline | wc -l)
    echo "$milestone: $count commits"
done
```

### Story Deviation Detection

```bash
# Find commits without story references
git log --since="1 week ago" --pretty=format:"%h %s" | grep -v -i "story\|milestone"
```

### Commit Message Convention

Use story identifiers in commit messages:

**Example user story**:
```md
### 🔧 Story: Flash ISO to USB
ID: US-0.2-001
```

**Commit message**:
```
feat: implement USB flashing core [US-0.2-001]
```

### Story-to-Code Mapping

Create a `story_to_code_map.md`:

```md
# 📦 Story-to-Code Map

| Story ID       | Status     | Commits     | Files Changed            |
|----------------|------------|-------------|---------------------------|
| US-0.2-001     | ✅ Done     | `54a1cf2`   | `flash.rs`, `main.rs`     |
| US-0.2-002     | 🔲 Pending  | —           | —                         |
```

---

## 🚀 GitHub Flow Integration

### Why GitHub Flow Fits Your Use Case

| Benefit | Why It Works for You |
|---------|---------------------|
| **Lightweight** | You don't need heavyweight workflows like Git Flow |
| **Issue-focused** | Pairs perfectly with your user stories → GitHub Issues pipeline |
| **AI-compatible** | Copilot can auto-open PRs from branches tied to issues |
| **Solo-friendly** | Doesn't require complex merging or coordination |

### Strategic Tweaks

#### 1. **Branch Naming from User Stories**

```bash
feature/0.2-flash-iso-to-usb
bugfix/0.2-checksum-verification
refactor/0.3-boot-sequence
```

Or use issue IDs if syncing with GitHub issues:
```
feature/23-flash-iso
```

#### 2. **Use Draft PRs with AI + Copilot**

- Open a **draft PR** early
- Let GitHub Copilot suggest improvements or subtasks
- Use the PR as a workspace for implementation and testing

#### 3. **Milestone-Scoped PRs**

- Tie each PR to a milestone in GitHub
- Helps track progress in `Projects` + verify all stories in the milestone are complete
- Makes auto-changelog generation easier later

#### 4. **Keep `main` Production-Stable**

- Merge PRs only when work is tested and tied to a completed story
- Optionally use a `develop` branch for large batches or risky features

### Recommended Git Strategy

```yaml
Default Branch: main

Branch Types:
  - feature/<milestone>-<short-name>
  - bugfix/<milestone>-<short-name>
  - refactor/<milestone>-<short-name>

Workflow:
  1. Sync stories to GitHub Issues
  2. Create a branch per issue
  3. Commit with clear messages referencing the story
  4. Open a draft PR tied to milestone + issue
  5. Merge to `main` when complete and reviewed
```

### PR Template

```md
# .github/PULL_REQUEST_TEMPLATE.md

## Linked Issue(s)
Closes #23 – Flash ISO to USB

## Description
Implements user story:
_As a user, I want to flash a USB with an ISO so I can install KilnOS._

## Checklist
- [x] Flashing logic implemented
- [x] USB device detection complete
- [x] Error handling added
- [x] Tested on macOS

## Milestone
0.2 – USB Flashing
```

---

## 🧠 Token Efficiency & Cost Optimization

### The Token Economics Crisis

**Current Industry Problems**:
- AWS IDE generates extensive specification files before any code is written
- Token usage becomes prohibitively high for even small features
- Similar issues affect other agentic tools and vine-style implementations
- Creates massive overhead before any actual productive work occurs

**The Scalability Problem**:
- Specification generation: thousands of tokens
- Refinement cycles: additional thousands
- Implementation planning: even more tokens
- By the time actual coding begins, enormous token budgets are consumed

### Solution: Local Models with Explicit Task Decomposition

**Strategic Advantages of Local Models**:
- Fixed costs instead of per-token pricing
- Ability to be "wasteful" with tokens during exploration
- Faster iteration cycles without API latency
- Complete control over the development process

**Task Decomposition Philosophy**:
- Break work into minimal viable specifications
- Use hierarchical approach: high-level spec → component specs → implementation units
- Each level should be independently actionable and testable
- Avoid over-specification upfront

### Single-File, Single-Task Methodology

**Revolutionary Approach**: Instead of maintaining project-wide context, constrain each AI interaction to a single file containing a single, well-defined task.

**Task File Structure**:
```
Task: [Specific implementation goal]
Inputs: [Explicit data types and sources]
Outputs: [Expected results and formats]
Dependencies: [What must exist beforehand]
Success Criteria: [How to verify completion]
```

**Benefits**:
- Agent cannot see broader project, forcing clear interface definitions
- No access to other components requires explicit inputs/outputs
- Limited scope contains failure modes
- Fresh context prevents accumulated confusion
- Human handles all coordination and architecture decisions

---

## 📊 Metrics That Matter for Solo Development

### Story Completion Rate
- Planned stories vs. completed stories per milestone
- Time from story creation to first commit
- Stories that get abandoned or significantly changed

### Code Quality Indicators
- Commits that are pure refactoring (might indicate initial approach was wrong)
- Bug fix commits (look for patterns in what breaks)
- Documentation commits (are you keeping docs in sync?)

### Velocity Patterns
- Your most productive times of day/week
- How long features actually take vs. estimates
- Context switching costs (rapid milestone changes)

### Simple Daily Practice

```bash
# Quick daily review - add this as a VS Code task or alias
git log --oneline --since="yesterday" && echo -e "\nToday's focus: $(cat docs/user_stories/*.md | grep -A1 'Status.*In Progress')"
```

---

## 🧰 Teaching Documentation Summary

| Task | Where to Go | What to Do |
|------|-------------|------------|
| Write a new feature idea | `user_stories.md` | Follow the "As a user..." format |
| Design architecture | `architecture.md` + ChatGPT | Use ChatGPT to sketch, then refine in Markdown |
| Plan implementation | Sync stories to GitHub Issues | Use CLI to create structured tasks |
| Write code | Cursor or Kilo | Feed user story + context, edit/refactor with AI |
| Track dev progress | GitHub Projects | Move issues through workflow |
| Track life/project goals | Apple Reminders | Use columns for "Now / Later / Someday" |

---

## 🔄 Bonus: Optional Enhancements

### CLI Script: `generate_issues_from_stories.sh`
Reads from `user_stories.md`, pushes to GitHub Issues

### Prompt Templates
- `"Implement the following story: <paste>. Use Rust + Tauri and follow KilnOS architecture."`

### Story-to-Code Mapping
Track which functions or PRs implement which stories

### GitLens Integration
- Custom Git Log Views
- Commit Message Templates
- VS Code tasks for story progress review

---

## 🎯 Critical Insights and Paradigm Shifts

### Industry Direction vs. Proposed Approach
- **Current Paradigm**: Make AI smarter to handle more context and complexity
- **Alternative Paradigm**: Make human-AI interface simpler and more explicit

### Key Philosophical Difference
- Industry treats AI as junior developer needing to "get up to speed"
- Proposed approach treats AI as specialized tool for precise specification transformation

### Core Recognition
The difficult part of software development isn't writing code—it's determining what to build and how pieces should fit together. This is inherently human work that shouldn't be offloaded to AI.

### Optimization Target
Long-term maintainability and understanding rather than short-term feature velocity.

---

## 🚀 Implementation Strategy

### Experimental Approach
Test this workflow end-to-end on actual projects while tracking:
- Time spent on specification vs. implementation vs. debugging
- Long-term maintainability benefits
- Scalability across multiple concurrent projects
- Actual vs. perceived time savings

### Flexibility Considerations
- Start with rigorous planning but allow dial-back if overhead becomes burdensome
- Focus on projects where problem is well-understood rather than exploratory work
- Consider hybrid approaches for different project types

### Success Metrics
- Reduction in "what was I thinking?" moments when returning to old code
- Overall project completion rates and quality
- Sustainable practice over extended time periods
- Effective integration of AI assistance without loss of code comprehension

---

## 📋 Action Items Checklist

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

*This consolidated workflow provides a comprehensive framework for AI-augmented development that balances efficiency with maintainability, human control with AI assistance, and short-term velocity with long-term sustainability.* 