# IndieDevHQ Frequently Asked Questions

Comprehensive answers to common questions about IndieDevHQ methodology, tools, and implementation.

## General Questions

### **Q: What is IndieDevHQ and who is it for?**

**A:** IndieDevHQ is a comprehensive development methodology designed for solo developers and small teams building software products. It combines:
- AI-augmented development workflows
- Automated project management and quality assurance
- Cross-platform development strategies (Apple, Web, Desktop)
- Documentation-first development practices

**Best for:** Independent developers, startup founders, small development teams, and anyone wanting to build software products efficiently with AI assistance.

### **Q: How is IndieDevHQ different from other development frameworks?**

**A:** IndieDevHQ is unique because it:
- **AI-First Approach**: Built around AI-augmented development from the ground up
- **Platform Agnostic**: Supports Tauri, Swift, Electron, and web development
- **Automation Focus**: Extensive automation scripts for common development tasks
- **Solo Developer Optimized**: Designed for individual productivity, not large teams
- **Documentation Integrated**: AI-readable documentation that improves over time

### **Q: Do I need to use all parts of IndieDevHQ?**

**A:** No! IndieDevHQ is modular. You can:
- Use individual scripts (`init-project.sh`, `check-conformity.sh`) as standalone tools
- Adopt specific sections (AI workflows, quality assurance, project management)
- Gradually integrate more components as you find them valuable
- Customize templates and scripts for your specific needs

## Getting Started

### **Q: How do I install and set up IndieDevHQ?**

**A:** Installation steps:
1. **Clone or download** the IndieDevHQ repository to `~/Projects/indie-dev-methodologies/`
2. **Make scripts executable**: `chmod +x ~/Projects/indie-dev-methodologies/scripts/*`
3. **Install dependencies**:
   - Git (required)
   - GitHub CLI (`gh`) for GitHub integration
   - Python 3 for metrics and documentation scripts
   - Project-specific tools (Swift, Rust, Node.js) as needed

4. **Test installation**: `./scripts/check-conformity.sh --help`

### **Q: What are the system requirements?**

**A:** Minimum requirements:
- **Operating System**: macOS (primary), Linux (supported), Windows (limited)
- **Git**: Version 2.0+
- **Python**: 3.6+
- **Bash**: 4.0+ (for automation scripts)

**Optional but recommended**:
- GitHub CLI for repository automation
- VS Code or Cursor for AI-enhanced coding
- Terminal replacement like Warp for better workflow

### **Q: Can I use IndieDevHQ with existing projects?**

**A:** Yes! IndieDevHQ can be gradually integrated into existing projects:

1. **Assessment**: Run `./scripts/check-conformity.sh .` to see current status
2. **Documentation**: Add `README.md` and `CLAUDE.md` files  
3. **GitHub Integration**: Use `./scripts/gh-automation.sh` to set up standard workflows
4. **Quality Monitoring**: Start using `./scripts/dev-metrics.py` for insights
5. **Gradual Adoption**: Integrate additional components over time

## Project Types and Technologies

### **Q: What project types does IndieDevHQ support?**

**A:** Currently supported project types:
- **Tauri**: Cross-platform desktop applications with Rust backends
- **Swift**: macOS console applications and iOS development
- **Web**: Modern web applications (React, Vue, vanilla JS/TS)
- **Electron**: Legacy desktop applications (maintenance mode)

**Planned support**: Flutter, Go applications, Python projects

### **Q: Why does IndieDevHQ favor certain technologies like Tauri and Swift?**

**A:** Technology choices are based on:
- **Performance**: Native performance with modern development experience
- **Cross-platform capability**: Write once, run on multiple platforms
- **AI compatibility**: Technologies that work well with AI code generation
- **Future-proofing**: Technologies with strong ecosystem and community support
- **Solo developer efficiency**: Tools that maximize individual productivity

### **Q: Can I add support for other programming languages?**

**A:** Absolutely! IndieDevHQ is designed to be extensible:

1. **Modify detection logic** in `scripts/init-project.sh` and `scripts/check-conformity.sh`
2. **Add project templates** in `templates/` directory
3. **Create language-specific workflows** in `.github/workflows/`
4. **Update documentation** and CLAUDE.md templates
5. **Contribute back** to the main repository if useful for others

## AI Integration

### **Q: Which AI tools work best with IndieDevHQ?**

**A:** Recommended AI stack:
- **Strategic AI**: Claude (Anthropic) or ChatGPT (OpenAI) for architecture and planning
- **Code AI**: Cursor, GitHub Copilot, or VS Code extensions for implementation
- **Local AI**: LM Studio for privacy-sensitive tasks
- **Specialized AI**: GitHub Copilot Chat, Tabnine, or CodeWhisperer for specific domains

### **Q: How do I get started with AI-augmented development?**

**A:** Start with these steps:
1. **Set up CLAUDE.md** in your projects for AI context
2. **Use system prompts** from `01_Core_Workflow/prompts/` (Jenny, Jeff)
3. **Follow AI workflow guide** in `01_Core_Workflow/ai_workflow_integration_guide.md`
4. **Practice structured prompting** with project-specific context
5. **Document AI decisions** in commit messages and project documentation

### **Q: What if I don't want to use AI tools?**

**A:** IndieDevHQ works great without AI! You can:
- Use all automation scripts without AI integration
- Follow documentation-first development practices
- Apply quality assurance and project management workflows
- Benefit from templates and standardized project structure
- Skip AI-specific files like CLAUDE.md or use them for human documentation

## Automation and Scripts

### **Q: What do the main IndieDevHQ scripts do?**

**A:** Key scripts and their functions:

- **`init-project.sh`**: Creates new projects with complete IndieDevHQ structure
- **`check-conformity.sh`**: Validates projects against IndieDevHQ standards
- **`generate-docs.py`**: Automatically generates and updates project documentation
- **`sync-stories-to-issues.sh`**: Converts markdown tasks to GitHub issues
- **`gh-automation.sh`**: Sets up complete GitHub repository with workflows and templates
- **`dev-metrics.py`**: Analyzes project metrics and generates insights dashboard

### **Q: Can I customize the automation scripts?**

**A:** Yes! Scripts are designed to be modified:
- **Configuration**: Edit variables at the top of scripts
- **Templates**: Modify files in `templates/` directory  
- **Project types**: Add new types by extending case statements
- **Quality checks**: Customize conformity rules in `check-conformity.sh`
- **Metrics**: Add new metrics or visualizations in `dev-metrics.py`

### **Q: Why do some scripts fail with permission errors?**

**A:** Common causes and solutions:
- **Script permissions**: Run `chmod +x ~/Projects/indie-dev-methodologies/scripts/*`
- **GitHub authentication**: Run `gh auth login` to set up GitHub CLI
- **File system permissions**: Ensure you have write access to project directories
- **Path issues**: Use absolute paths or run scripts from correct directory

## Project Management and Workflows

### **Q: How does IndieDevHQ handle project management?**

**A:** IndieDevHQ uses a lightweight, AI-compatible approach:
- **User Stories as Prompts**: Write requirements that can be fed directly to AI
- **GitHub Integration**: Automatically sync tasks to GitHub Issues
- **Standard Labels**: Consistent labeling system across all projects
- **Metrics Tracking**: Automated analysis of development progress and quality
- **Documentation-Driven**: Plans and decisions captured in markdown files

### **Q: Can IndieDevHQ work with team collaboration?**

**A:** IndieDevHQ adapts well to small teams (2-5 people):
- **Standardized workflows** ensure consistency across team members
- **Shared AI practices** through system prompts and documentation standards
- **GitHub integration** provides transparency and project tracking
- **Quality automation** ensures consistent code standards
- **Documentation focus** helps with knowledge sharing and onboarding

For larger teams, consider adapting IndieDevHQ principles rather than using directly.

### **Q: How do I track project progress and quality over time?**

**A:** Use IndieDevHQ's built-in analytics:
1. **Regular metrics**: Run `./scripts/dev-metrics.py .` weekly or monthly
2. **Conformity checks**: Use `./scripts/check-conformity.sh .` before releases
3. **GitHub insights**: Leverage standard GitHub metrics and project boards
4. **Documentation updates**: Track `./scripts/generate-docs.py .` output over time
5. **AI decision tracking**: Document architectural choices in CLAUDE.md

## Quality Assurance and Security

### **Q: How does IndieDevHQ ensure code quality?**

**A:** Multi-layered quality approach:
- **Automated conformity checking** validates project structure
- **Standard templates** ensure consistent project setup
- **GitHub workflows** automate testing and quality checks
- **Documentation requirements** enforce clear communication
- **Metrics tracking** identifies quality trends over time
- **AI-assisted reviews** leverage AI for code analysis and suggestions

### **Q: Are there security considerations with AI integration?**

**A:** IndieDevHQ addresses security through:
- **Local AI options** (LM Studio) for sensitive code
- **Context management** - avoid including secrets in AI prompts
- **Standard .gitignore** patterns prevent accidental commits
- **Security-focused templates** include security best practices
- **Documentation requirements** encourage security considerations

**Best practices**: Never include API keys, passwords, or sensitive data in CLAUDE.md or AI prompts.

### **Q: How do I maintain quality standards across multiple projects?**

**A:** Consistency strategies:
1. **Standardized scripts** - same quality checks across all projects
2. **Template system** - consistent starting points for new projects  
3. **Automated workflows** - GitHub Actions enforce standards
4. **Regular audits** - use metrics dashboard to identify issues
5. **Documentation standards** - maintain quality of project documentation

## Troubleshooting and Support

### **Q: What should I do if a script isn't working?**

**A:** Troubleshooting steps:
1. **Check the troubleshooting guide** at `Guides/troubleshooting_guide.md`
2. **Verify permissions**: `ls -la ~/Projects/indie-dev-methodologies/scripts/`
3. **Run system check**: Create and run the system validation script from the troubleshooting guide
4. **Check dependencies**: Ensure Git, GitHub CLI, Python are installed
5. **Try manual execution**: Break down the failing script into individual commands
6. **Enable debug mode**: Run with `bash -x scriptname.sh` for detailed output

### **Q: How do I get help with IndieDevHQ?**

**A:** Support resources:
- **FAQ**: This document covers common questions
- **Troubleshooting Guide**: `Guides/troubleshooting_guide.md` for technical issues
- **Implementation Examples**: `Guides/practical_implementation_examples.md` for usage patterns
- **Cross-References**: `CROSS_REFERENCES.md` for understanding component relationships
- **GitHub Issues**: Report bugs or request features in the main repository

### **Q: Can I contribute to IndieDevHQ?**

**A:** Contributions are welcome! Ways to contribute:
- **Bug reports**: Detailed issue reports help improve the system
- **Feature requests**: Suggest new automation scripts or project types
- **Template improvements**: Better templates for different project types
- **Documentation**: Improvements to guides, examples, or troubleshooting
- **Code contributions**: New scripts, enhanced existing functionality
- **Usage examples**: Share how you've adapted IndieDevHQ for your needs

## Advanced Usage

### **Q: How do I create custom project templates?**

**A:** Template creation process:
1. **Create template directory**: `mkdir templates/my-custom-template/`
2. **Add template files**: Include all standard files for your project type
3. **Update init script**: Modify `scripts/init-project.sh` to handle your template
4. **Test thoroughly**: Ensure template works with all IndieDevHQ scripts
5. **Document usage**: Update relevant guides and documentation

### **Q: Can I use IndieDevHQ for commercial projects?**

**A:** Yes! IndieDevHQ is designed for building real products:
- **No licensing restrictions** on your projects
- **Commercial-friendly workflows** for deployment and maintenance
- **Quality standards** suitable for production applications
- **Security practices** appropriate for commercial software
- **Scalable architecture** that can grow with your business

### **Q: How do I migrate from other development methodologies?**

**A:** Migration strategies:
1. **Gradual adoption**: Start with individual scripts and templates
2. **Parallel workflow**: Run IndieDevHQ alongside existing processes initially
3. **Documentation migration**: Convert existing docs to IndieDevHQ format
4. **Tool integration**: Adapt existing tools to work with IndieDevHQ workflows
5. **Team training**: Educate team members on IndieDevHQ practices and AI integration

### **Q: What's the roadmap for IndieDevHQ development?**

**A:** Future development focus:
- **Enhanced AI integration**: Better AI-powered project insights and automation
- **More project types**: Flutter, Go, Python, and other popular technologies
- **Advanced metrics**: Predictive analytics and development insights
- **Team collaboration**: Better support for larger development teams
- **IDE integration**: Deeper integration with VS Code, Cursor, and other editors
- **Deployment automation**: Enhanced CI/CD and deployment workflows

---

*This FAQ is maintained based on common user questions and feedback. If you have a question not covered here, please check the troubleshooting guide or create an issue in the repository.*