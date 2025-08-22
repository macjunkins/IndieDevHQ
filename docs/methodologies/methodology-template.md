# Methodology Template

**Purpose**: Template for creating consistent, actionable development methodologies.  
**When to use**: Creating new methodology documentation for IndieDevHQ.  
**Prerequisites**: Understanding of IndieDevHQ patterns and quality standards.

## Steps

1. **Define Purpose**: One-sentence outcome the methodology provides
2. **Identify Triggers**: When and why to use this methodology
3. **List Prerequisites**: Required tools, environment, and knowledge
4. **Document Process**: Step-by-step implementation guide
5. **Provide Examples**: Copy-ready prompts and code samples
6. **Quality Validation**: Checklists and verification steps

## Template Structure

```markdown
# {Methodology Name}

**Purpose**: One-sentence outcome the solo dev gets.  
**When to use**: Preconditions & signals.  
**Prerequisites**: Tools, repo state, model access.

## Steps
1. Trigger
2. Inputs (links to prompts, scripts)
3. Actions (copy-pasteable command blocks)
4. Outputs (artifacts, PRs, docs)

## Prompts
```text
<Copy-ready prompt for Claude/ChatGPT>
```

## Automation (optional)
- Scripts / Actions / Make targets to run the flow

## Quality Checklist
- [ ] Lints pass
- [ ] Tests updated
- [ ] Docs updated (this site)
```

## Quality Standards

Every methodology must include:
- Clear, actionable steps
- Copy-ready prompts and commands
- Quality validation checklist
- Tool-agnostic approach where possible

*This template ensures consistency across all IndieDevHQ methodologies.*