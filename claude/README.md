# Claude Code Configuration

This directory contains Claude Code configuration that gets symlinked to `~/.claude/` via GNU Stow.

## Philosophy

Claude Code plugins are like `node_modules/` - they're installed via a package manager and shouldn't be version controlled. Only your personal settings and documentation should be in dotfiles.

## Structure

```
claude/
├── .claude/
│   └── settings.local.json    # Personal preferences and permissions
└── README.md                   # This file (setup documentation)
```

**What's NOT tracked**: Plugins, commands, skills, MCP server data (managed by Claude Code's plugin system)

## Current Setup

### Installed Plugin Marketplaces

#### wshobson/agents
Specialized agents for technical domains:
- **data-engineering** - Data pipeline and architecture specialists
- **machine-learning-ops** - ML/MLOps workflow agents (data-scientist, ml-engineer, mlops-engineer)
- **python-development** - Python ecosystem experts (python-pro, fastapi-pro, django-pro)
- **shell-scripting** - Bash and POSIX shell specialists (bash-pro, posix-shell-pro)

#### obra/superpowers-marketplace
Core development workflows and proven practices:
- **superpowers** - TDD, debugging, systematic planning, collaboration patterns
  - 20+ battle-tested skills for common engineering tasks
  - Slash commands: `/superpowers:brainstorm`, `/superpowers:write-plan`, `/superpowers:execute-plan`
  - Auto-activating skills (e.g., TDD skill activates when implementing features)
  - Philosophy: test-driven, systematic over ad-hoc, complexity reduction

### MCP Servers

#### Exa (via Smithery)
AI-powered web and code search:
- **URL**: `https://server.smithery.ai/exa/mcp`
- **Transport**: HTTP
- **Authentication**: OAuth via Smithery

**Available Tools**:
- `web_search_exa` - Real-time web searches
- `get_code_context_exa` - Search code across GitHub repositories
- `deep_researcher_start/check` - AI-powered deep research
- `company_research` - Business intelligence gathering
- `crawling` - Extract content from URLs
- `linkedin_search` - LinkedIn profile/company searches

## Fresh Machine Setup

### Prerequisites

```bash
# Ensure Node.js is installed
node --version  # v16+

# Install Claude Code globally
npm install -g @anthropic-ai/claude-code
```

### Installation Steps

```bash
# 1. Clone and stow dotfiles
cd ~/dotfiles
stow claude
# This creates: ~/.claude/settings.local.json → dotfiles/claude/.claude/settings.local.json

# 2. Add plugin marketplaces
/plugin marketplace add wshobson/agents
/plugin marketplace add obra/superpowers-marketplace

# 3. Install wshobson/agents plugins
/plugin install data-engineering@wshobson-agents
/plugin install machine-learning-ops@wshobson-agents
/plugin install python-development@wshobson-agents
/plugin install shell-scripting@wshobson-agents

# 4. Install obra/superpowers
/plugin install superpowers@superpowers-marketplace

# 5. Add MCP servers
claude mcp add --transport http exa "https://server.smithery.ai/exa/mcp"

# 6. Restart Claude Code
# After restart, run /mcp and follow OAuth flow to authenticate Exa
```

## Verification

```bash
# Check installed plugins
/plugin

# Check available agents (python-pro, data-engineer, ml-engineer, etc.)
# They appear in the Task tool's subagent_type parameter

# Check MCP servers
claude mcp list
/mcp

# Test Exa search
# Ask Claude: "Use Exa to search for FastAPI best practices"
```

## Settings

### `settings.local.json`

Pre-approved permissions (avoids constant prompts):

```json
{
  "permissions": {
    "allow": [
      "WebSearch",
      "WebFetch(domain:zellij.dev)",
      "WebFetch(domain:github.com)",
      "WebFetch(domain:haseebmajid.dev)"
    ],
    "deny": [],
    "ask": []
  }
}
```

## Plugin Architecture

### Where Plugins Live

**Installed plugins**: `~/.claude/plugins/` (NOT in dotfiles)
- Downloaded from marketplaces
- Managed by Claude Code's plugin system
- Like `node_modules/` - regenerated via install commands

**Why not in dotfiles?**
- Large external code from marketplaces (13,000+ lines in the old setup)
- Updated via `/plugin update`
- Machine-specific runtime state
- Clutters git history with external code

**What IS in dotfiles:**
- `settings.local.json` - Your personal preferences (213 bytes)
- This README - Installation documentation

### Analogy

| System | In Version Control | Not In Version Control |
|--------|-------------------|------------------------|
| Node.js | `package.json` | `node_modules/` |
| Python | `requirements.txt` | `venv/`, `__pycache__/` |
| **Claude Code** | `settings.local.json`, README | `plugins/`, `commands/`, `skills/` |

## Usage Examples

### Specialized Agents (via Task tool)

Agents are invoked via the Task tool with `subagent_type` parameter:

```python
# Example agent invocations:
subagent_type="python-pro"           # Python optimization expert
subagent_type="data-engineer"        # Data pipeline architect
subagent_type="ml-engineer"          # ML model training specialist
subagent_type="bash-pro"             # Defensive bash scripting expert
```

In conversation:
```
"Use the python-pro agent to refactor this code"
"Have the data-engineer agent design this pipeline"
"Ask the ml-engineer agent to optimize training"
```

### Superpowers Workflows

```bash
/superpowers:brainstorm    # Socratic design refinement
/superpowers:write-plan    # Create detailed implementation plan
/superpowers:execute-plan  # Execute with TDD (RED-GREEN-REFACTOR)
```

Skills auto-activate when relevant:
- `test-driven-development` - Activates when implementing features
- `systematic-debugging` - Activates when debugging
- `verification-before-completion` - Activates before claiming work is done

### Exa Search (via MCP)

```
"Use Exa to search for React Server Components best practices"
"Search GitHub for FastAPI authentication examples with Exa"
"Use Exa's deep research to analyze Vue vs React for this project"
```

## MCP (Model Context Protocol)

### Configuration

MCP servers are configured in `~/.claude.json` (NOT in dotfiles, contains credentials):

```json
{
  "projects": {
    "/Users/jack/dotfiles": {
      "mcpServers": {
        "exa": {
          "type": "http",
          "url": "https://server.smithery.ai/exa/mcp"
        }
      }
    }
  }
}
```

### MCP vs Plugins

- **MCP servers**: External tools/APIs (web search, databases, APIs)
- **Plugins**: Bundle Claude Code functionality (agents, skills, commands, hooks, MCP servers)
- Plugins can include MCP servers in their configuration

## Troubleshooting

### Plugins not loading

```bash
# Check installation
/plugin

# Reinstall if needed
/plugin install superpowers@superpowers-marketplace

# Update all plugins
/plugin update
```

### MCP authentication required

```bash
# Check status
claude mcp list

# Authenticate
/mcp
# Follow OAuth flow in browser
```

### Permission prompts

Add to `~/.claude/settings.local.json`:
```json
{
  "permissions": {
    "allow": ["ToolName", "ToolName(pattern:*)"]
  }
}
```

## Plugin Management

```bash
# List installed plugins
/plugin

# List marketplaces
/plugin marketplace

# Search for plugins
/plugin search <keyword>

# Update plugins
/plugin update <name>
/plugin update  # all plugins

# Uninstall
/plugin uninstall <name>
```

## Migration Notes

**Previous approach (deprecated)**: Tracked plugins, commands, and skills in dotfiles
**Current approach**: Only track `settings.local.json` and documentation

**Migration completed**: Commit `54042fb` removed 13,861 lines of plugin code from version control

## Resources

- [Claude Code Docs](https://docs.claude.com/en/docs/claude-code)
- [Plugin System](https://docs.claude.com/en/docs/claude-code/plugins)
- [MCP Documentation](https://docs.claude.com/en/docs/claude-code/mcp)
- [obra/superpowers](https://github.com/obra/superpowers)
- [Superpowers Blog Post](https://blog.fsck.com/2025/10/09/superpowers/)

## Custom Content

If you create custom commands or agents, you CAN track them:

```
claude/
├── .claude/
│   ├── settings.local.json
│   ├── commands/           # Your custom slash commands (optional)
│   └── agents/             # Your custom subagents (optional)
└── README.md
```

These are your personal creations (not marketplace code), so tracking them makes sense.

## Philosophy Principles

This configuration embraces:

- **Specialized agents** for domain expertise
- **Proven workflows** via superpowers skills
- **External tools** via MCP for current information
- **Test-driven development** as default workflow
- **Systematic approaches** over ad-hoc solutions
- **Clean dotfiles** - configuration, not dependencies
