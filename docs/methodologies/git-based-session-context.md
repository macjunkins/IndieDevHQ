# Git-Based Session Context Management

## Decision Summary

**Date**: August 24, 2025  
**Status**: Adopted  
**Context**: IndieDevHQ methodology enhancement

## Problem

Traditional session logs create documentation overhead and token inefficiency:
- Separate session log files require maintenance and storage
- Duplicate information already captured in Git history
- Claude Code sessions require expensive token usage to read lengthy logs
- Context information scattered across multiple file types

## Solution

Leverage Git's natural documentation flow as the primary session context mechanism:

### Implementation Strategy

1. **Verbose Commit Messages**
   - Explain what changed and why in each commit
   - Include decision reasoning in commit descriptions
   - Use conventional commit format when appropriate

2. **Detailed Pull Request Descriptions**
   - Document larger changes and architectural decisions
   - Explain the "why" behind feature implementations
   - Include testing approach and considerations

3. **Context Surfacing for AI Sessions**
   - Use `git log --oneline -10` for recent work overview
   - Reference specific PRs: `gh pr view <number>` for detailed context
   - Point to relevant commits for specific decisions

4. **Documentation Hierarchy**
   - `README.md` - Current project state and setup instructions
   - `CLAUDE.md` - Development guidance and AI context
   - Git history - Session-by-session decisions and changes
   - PR descriptions - Feature-level documentation

## Benefits

- **Eliminates duplicate documentation** - context lives with the code
- **Token-efficient AI sessions** - only read relevant history
- **Natural workflow integration** - uses Git's existing strengths  
- **Searchable through GitHub** - better discoverability
- **Reduces maintenance overhead** - fewer files to manage

## Implementation Notes

- This approach requires discipline in commit message quality
- PR descriptions become more critical for complex features
- Initial learning curve for verbose Git practices
- May need tooling to efficiently surface relevant context

## Integration with IndieDevHQ Methodology

This decision aligns with the core principle of "orchestrating tools" rather than creating parallel systems. Git already provides version control, history tracking, and change documentation - we leverage these existing capabilities rather than building duplicate systems.

## Next Steps

- Update project templates to include commit message guidelines
- Create examples of effective verbose commits and PR descriptions
- Test the approach across active projects (Todge-Tauri, ForgeDesk)
- Gather feedback on context surfacing efficiency in AI sessions