#!/usr/bin/env python3
"""
Development Metrics Dashboard for IndieDevHQ
Analyzes project metrics and provides development insights
"""

import os
import sys
import json
import subprocess
import datetime
from pathlib import Path
from collections import defaultdict, Counter

def run_command(command, cwd=None, capture_output=True):
    """Run a shell command and return output"""
    try:
        result = subprocess.run(
            command, shell=True, capture_output=capture_output, text=True, cwd=cwd
        )
        if capture_output:
            return result.stdout.strip(), result.stderr.strip(), result.returncode
        return "", "", result.returncode
    except Exception as e:
        print(f"Error running command '{command}': {e}")
        return "", f"Error: {e}", 1

def detect_project_type(project_path):
    """Detect the type of project"""
    if (project_path / "src-tauri" / "Cargo.toml").exists():
        return "tauri"
    elif (project_path / "Package.swift").exists():
        return "swift"
    elif (project_path / "package.json").exists():
        package_json = json.loads((project_path / "package.json").read_text())
        if "electron" in str(package_json.get("dependencies", {})) or "electron" in str(package_json.get("devDependencies", {})):
            return "electron"
        return "web"
    return "unknown"

def get_git_metrics(project_path):
    """Analyze git repository metrics"""
    metrics = {}
    
    # Basic git info
    stdout, stderr, returncode = run_command("git log --oneline | wc -l", cwd=project_path)
    metrics['total_commits'] = int(stdout) if stdout.isdigit() else 0
    
    # Recent activity (last 30 days)
    stdout, stderr, returncode = run_command(
        "git log --since='30 days ago' --oneline | wc -l", cwd=project_path
    )
    metrics['commits_last_30_days'] = int(stdout) if stdout.isdigit() else 0
    
    # Contributors
    stdout, stderr, returncode = run_command(
        "git shortlog -sn | wc -l", cwd=project_path
    )
    metrics['contributors'] = int(stdout) if stdout.isdigit() else 0
    
    # Most active days (last 30 days)
    stdout, stderr, returncode = run_command(
        "git log --since='30 days ago' --format='%ad' --date=short | sort | uniq -c | sort -rn | head -5",
        cwd=project_path
    )
    if returncode == 0 and stdout:
        active_days = []
        for line in stdout.split('\n'):
            if line.strip():
                parts = line.strip().split()
                if len(parts) >= 2:
                    active_days.append({'date': parts[1], 'commits': int(parts[0])})
        metrics['most_active_days'] = active_days
    else:
        metrics['most_active_days'] = []
    
    # File change patterns
    stdout, stderr, returncode = run_command(
        "git log --name-only --pretty=format: --since='30 days ago' | sort | uniq -c | sort -rn | head -10",
        cwd=project_path
    )
    if returncode == 0 and stdout:
        changed_files = []
        for line in stdout.split('\n'):
            if line.strip():
                parts = line.strip().split(None, 1)
                if len(parts) == 2 and parts[1]:
                    changed_files.append({'file': parts[1], 'changes': int(parts[0])})
        metrics['most_changed_files'] = changed_files
    else:
        metrics['most_changed_files'] = []
    
    return metrics

def get_code_metrics(project_path, project_type):
    """Analyze code-related metrics"""
    metrics = {}
    
    # File counts by type
    file_patterns = {
        'swift': ['*.swift'],
        'tauri': ['*.rs', '*.js', '*.ts', '*.tsx', '*.jsx'],
        'web': ['*.js', '*.ts', '*.tsx', '*.jsx', '*.vue', '*.svelte'],
        'electron': ['*.js', '*.ts', '*.tsx', '*.jsx'],
        'unknown': ['*.js', '*.ts', '*.py', '*.rs', '*.swift', '*.go', '*.java']
    }
    
    patterns = file_patterns.get(project_type, file_patterns['unknown'])
    
    total_files = 0
    total_lines = 0
    
    for pattern in patterns:
        stdout, stderr, returncode = run_command(
            f"find . -name '{pattern}' -not -path './.git/*' -not -path './node_modules/*' -not -path './.build/*' | wc -l",
            cwd=project_path
        )
        if returncode == 0 and stdout.isdigit():
            total_files += int(stdout)
        
        # Count lines of code
        stdout, stderr, returncode = run_command(
            f"find . -name '{pattern}' -not -path './.git/*' -not -path './node_modules/*' -not -path './.build/*' -exec wc -l {{}} + | tail -1",
            cwd=project_path
        )
        if returncode == 0 and stdout:
            try:
                lines = int(stdout.split()[0])
                total_lines += lines
            except (ValueError, IndexError):
                pass
    
    metrics['source_files'] = total_files
    metrics['lines_of_code'] = total_lines
    
    # Configuration files
    config_files = [
        'package.json', 'Cargo.toml', 'Package.swift', '.gitignore', 
        'README.md', 'CLAUDE.md', 'tsconfig.json', 'webpack.config.js'
    ]
    
    existing_configs = []
    for config in config_files:
        if (project_path / config).exists():
            existing_configs.append(config)
    
    metrics['config_files'] = existing_configs
    metrics['config_count'] = len(existing_configs)
    
    return metrics

def get_quality_metrics(project_path, project_type):
    """Analyze code quality metrics"""
    metrics = {}
    
    # Check for IndieDevHQ conformity
    conformity_script = project_path.parent / "indie-dev-methodologies" / "scripts" / "check-conformity.sh"
    if conformity_script.exists():
        stdout, stderr, returncode = run_command(
            f"{conformity_script} {project_path}", cwd=project_path.parent
        )
        metrics['indiedevhq_conformity'] = returncode == 0
        metrics['conformity_output'] = stdout if stdout else stderr
    else:
        metrics['indiedevhq_conformity'] = None
        metrics['conformity_output'] = "Conformity checker not found"
    
    # Test coverage (project-type specific)
    test_indicators = {
        'swift': ['Tests/', '*.test.swift'],
        'tauri': ['tests/', '*.test.js', '*.test.ts', '*.spec.js', '*.spec.ts'],
        'web': ['test/', 'tests/', '__tests__/', '*.test.js', '*.spec.js'],
        'electron': ['test/', 'tests/', '*.test.js', '*.spec.js']
    }
    
    indicators = test_indicators.get(project_type, ['test/', 'tests/', '*.test.*'])
    has_tests = False
    test_files = 0
    
    for indicator in indicators:
        if '/' in indicator:
            # Directory check
            if (project_path / indicator).exists():
                has_tests = True
        else:
            # File pattern check
            stdout, stderr, returncode = run_command(
                f"find . -name '{indicator}' -not -path './.git/*' -not -path './node_modules/*' | wc -l",
                cwd=project_path
            )
            if returncode == 0 and stdout.isdigit():
                count = int(stdout)
                test_files += count
                if count > 0:
                    has_tests = True
    
    metrics['has_tests'] = has_tests
    metrics['test_files'] = test_files
    
    # Documentation score
    doc_files = ['README.md', 'CLAUDE.md', 'docs/', 'CHANGELOG.md']
    doc_score = 0
    for doc in doc_files:
        if (project_path / doc).exists():
            doc_score += 1
    
    metrics['documentation_score'] = doc_score
    metrics['documentation_max'] = len(doc_files)
    
    return metrics

def generate_insights(metrics, project_type):
    """Generate development insights based on metrics"""
    insights = []
    
    # Activity insights
    if metrics['git']['commits_last_30_days'] == 0:
        insights.append({
            'type': 'warning',
            'category': 'Activity',
            'message': 'No commits in the last 30 days - project may be stale'
        })
    elif metrics['git']['commits_last_30_days'] > 50:
        insights.append({
            'type': 'positive',
            'category': 'Activity', 
            'message': f"High activity with {metrics['git']['commits_last_30_days']} commits in 30 days"
        })
    
    # Code quality insights
    if not metrics['quality']['has_tests']:
        insights.append({
            'type': 'warning',
            'category': 'Quality',
            'message': 'No tests detected - consider adding test coverage'
        })
    
    if metrics['quality']['documentation_score'] < 2:
        insights.append({
            'type': 'warning',
            'category': 'Documentation',
            'message': 'Limited documentation - consider adding README.md or docs/'
        })
    
    # Project structure insights
    if metrics['quality']['indiedevhq_conformity'] is False:
        insights.append({
            'type': 'warning',
            'category': 'Structure',
            'message': 'Project does not conform to IndieDevHQ standards'
        })
    
    # Lines of code insights
    loc = metrics['code']['lines_of_code']
    if loc < 100:
        insights.append({
            'type': 'info',
            'category': 'Scale',
            'message': 'Small project - good for prototyping and experimentation'
        })
    elif loc > 10000:
        insights.append({
            'type': 'info',
            'category': 'Scale', 
            'message': 'Large codebase - consider modularization strategies'
        })
    
    # Project-specific insights
    if project_type == 'swift' and 'Package.swift' not in metrics['code']['config_files']:
        insights.append({
            'type': 'warning',
            'category': 'Configuration',
            'message': 'Swift project missing Package.swift - may not be a proper Swift package'
        })
    
    if project_type in ['web', 'electron'] and 'package.json' not in metrics['code']['config_files']:
        insights.append({
            'type': 'warning',
            'category': 'Configuration',
            'message': 'JavaScript project missing package.json'
        })
    
    return insights

def format_dashboard(metrics, insights, project_name, project_type):
    """Format the metrics dashboard output"""
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    output = f"""
# 📊 Development Metrics Dashboard - {project_name}

**Generated**: {timestamp}  
**Project Type**: {project_type.title()}  
**Framework**: IndieDevHQ Methodology

## 📈 Activity Metrics

### Git Repository
- **Total Commits**: {metrics['git']['total_commits']}
- **Recent Activity**: {metrics['git']['commits_last_30_days']} commits (last 30 days)
- **Contributors**: {metrics['git']['contributors']}

### Most Active Days (Last 30 days)
"""
    
    if metrics['git']['most_active_days']:
        for day in metrics['git']['most_active_days'][:5]:
            output += f"- **{day['date']}**: {day['commits']} commits\n"
    else:
        output += "- No activity in the last 30 days\n"
    
    output += f"""
### Most Changed Files (Last 30 days)
"""
    
    if metrics['git']['most_changed_files']:
        for file_info in metrics['git']['most_changed_files'][:5]:
            output += f"- **{file_info['file']}**: {file_info['changes']} changes\n"
    else:
        output += "- No file changes in the last 30 days\n"
    
    output += f"""
## 💻 Code Metrics

### Source Code
- **Source Files**: {metrics['code']['source_files']}
- **Lines of Code**: {metrics['code']['lines_of_code']:,}
- **Configuration Files**: {metrics['code']['config_count']}

### Project Configuration
"""
    
    for config in metrics['code']['config_files']:
        output += f"- ✅ {config}\n"
    
    output += f"""
## 🎯 Quality Metrics

### Testing
- **Has Tests**: {'✅ Yes' if metrics['quality']['has_tests'] else '❌ No'}
- **Test Files**: {metrics['quality']['test_files']}

### Documentation
- **Documentation Score**: {metrics['quality']['documentation_score']}/{metrics['quality']['documentation_max']}
- **IndieDevHQ Conformity**: {'✅ Compliant' if metrics['quality']['indiedevhq_conformity'] is True else '❌ Non-compliant' if metrics['quality']['indiedevhq_conformity'] is False else '⚠️ Unknown'}

## 💡 Development Insights

"""
    
    if insights:
        # Group insights by category
        insight_groups = defaultdict(list)
        for insight in insights:
            insight_groups[insight['category']].append(insight)
        
        for category, category_insights in insight_groups.items():
            output += f"### {category}\n"
            for insight in category_insights:
                icon = {'positive': '🎉', 'warning': '⚠️', 'info': 'ℹ️'}.get(insight['type'], '•')
                output += f"{icon} {insight['message']}\n"
            output += "\n"
    else:
        output += "No specific insights available for this project.\n"
    
    output += f"""
## 🚀 Recommendations

### Development Workflow
"""
    
    # Generate recommendations based on project state
    recommendations = []
    
    if metrics['git']['commits_last_30_days'] == 0:
        recommendations.append("Consider resuming active development or archiving if project is complete")
    
    if not metrics['quality']['has_tests']:
        recommendations.append(f"Add test coverage for {project_type} project using appropriate testing framework")
    
    if metrics['quality']['documentation_score'] < 2:
        recommendations.append("Improve documentation with detailed README.md and project guides")
    
    if metrics['quality']['indiedevhq_conformity'] is False:
        recommendations.append("Run `./scripts/check-conformity.sh .` to identify and fix structural issues")
    
    if metrics['code']['lines_of_code'] > 5000 and not metrics['quality']['has_tests']:
        recommendations.append("Large codebase without tests - prioritize test coverage for stability")
    
    if project_type == 'unknown':
        recommendations.append("Clarify project type and structure for better IndieDevHQ integration")
    
    if not recommendations:
        recommendations.append("Project appears well-structured - continue with current development practices")
    
    for i, rec in enumerate(recommendations, 1):
        output += f"{i}. {rec}\n"
    
    output += f"""
### IndieDevHQ Integration
1. Use `./scripts/generate-docs.py .` to maintain up-to-date documentation
2. Run `./scripts/sync-stories-to-issues.sh . false` to manage GitHub issues
3. Apply `./scripts/gh-automation.sh . {project_name} public` for GitHub integration

## 📊 Metrics History

*Note: This is a point-in-time snapshot. Run this script regularly to track trends over time.*

---

*Generated by IndieDevHQ Development Metrics Dashboard*  
*For more insights, run: `./scripts/dev-metrics.py . --detailed`*
"""
    
    return output

def main():
    project_path = Path(sys.argv[1]) if len(sys.argv) > 1 else Path.cwd()
    detailed = '--detailed' in sys.argv or '-d' in sys.argv
    
    if not project_path.exists():
        print(f"Error: Project path '{project_path}' does not exist")
        sys.exit(1)
    
    project_name = project_path.name
    project_type = detect_project_type(project_path)
    
    print(f"📊 Analyzing development metrics for: {project_name}")
    print(f"📍 Path: {project_path}")
    print(f"🔧 Project Type: {project_type}")
    print("")
    
    # Collect metrics
    print("Collecting git metrics...")
    git_metrics = get_git_metrics(project_path)
    
    print("Analyzing code metrics...")  
    code_metrics = get_code_metrics(project_path, project_type)
    
    print("Evaluating quality metrics...")
    quality_metrics = get_quality_metrics(project_path, project_type)
    
    # Combine metrics
    all_metrics = {
        'git': git_metrics,
        'code': code_metrics, 
        'quality': quality_metrics
    }
    
    # Generate insights
    print("Generating insights...")
    insights = generate_insights(all_metrics, project_type)
    
    # Create dashboard
    dashboard = format_dashboard(all_metrics, insights, project_name, project_type)
    
    # Output dashboard
    output_file = project_path / "METRICS_DASHBOARD.md"
    output_file.write_text(dashboard)
    
    print(f"✅ Metrics dashboard generated: {output_file}")
    print("")
    
    # Show summary
    print("📊 Quick Summary:")
    print(f"   📈 {git_metrics['commits_last_30_days']} commits (30 days)")
    print(f"   💻 {code_metrics['lines_of_code']:,} lines of code")
    print(f"   🧪 {'Tests: ✅' if quality_metrics['has_tests'] else 'Tests: ❌'}")
    print(f"   📚 Docs: {quality_metrics['documentation_score']}/{quality_metrics['documentation_max']}")
    print(f"   ✅ {'Conformity: ✅' if quality_metrics['indiedevhq_conformity'] is True else 'Conformity: ❌'}")
    
    if insights:
        print(f"   💡 {len(insights)} insights generated")
    
    print("")
    print(f"📖 View full dashboard: {output_file}")

if __name__ == "__main__":
    main()