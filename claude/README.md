# Claude Code Configuration

Stowed Claude Code configuration managed through dotfiles.

## Structure

```
claude/.claude/
├── commands/         # Custom slash commands (installed by plugins)
├── plugins/          # Plugin configurations and cached skills
├── settings.local.json  # Local permissions and overrides
└── README.md         # This file
```

## What Gets Stowed

- `commands/` - Custom slash commands from plugins
- `plugins/` - Plugin configurations, marketplaces, cached skills
- `settings.local.json` - Machine-specific settings (permissions, etc.)

## What Stays Local (NOT stowed)

These directories remain in `~/.claude/` as runtime data:

- `agents/` - Agent session data (runtime state)
- `backups/` - Auto-generated settings backups
- `debug/` - Debug logs
- `file-history/` - File edit history for undo/redo
- `history.jsonl` - Conversation history
- `projects/` - Project metadata
- `session-env/` - Environment snapshots
- `shell-snapshots/` - Shell state backups
- `statsig/` - Analytics/telemetry
- `todos/` - Todo list state
- `settings.json` - Main settings (managed by Claude Code)

## Installation

From the dotfiles directory:

```bash
stow claude
```

This creates symlinks:
- `~/.claude/commands -> ~/dotfiles/claude/.claude/commands`
- `~/.claude/plugins -> ~/dotfiles/claude/.claude/plugins`
- `~/.claude/settings.local.json -> ~/dotfiles/claude/.claude/settings.local.json`

## Plugin Installation

After stowing, install plugins/hooks/agents as needed. They will automatically populate the stowed directories.

Example workflow:
1. `stow claude` (creates symlink structure)
2. Install superpowers plugin (populates `commands/` and `plugins/`)
3. Configure hooks in Claude Code
4. Install custom agents

All plugin-installed content will be tracked in dotfiles automatically.
