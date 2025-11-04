# Zellij Configuration

Minimal Zellij setup matching WezTerm coolnight theme.

## Setup

```bash
# Stow the configuration
cd ~/dotfiles
stow zellij

# Or manually symlink
ln -s ~/dotfiles/zellij/.config/zellij ~/.config/zellij
```

## Key Features

- **Theme**: Matches WezTerm coolnight color scheme
- **Minimal UI**: Thin status bar, no clutter
- **Tmux-like keybindings**: `Ctrl+A` prefix
- **Floating panes**: 50% default size
- **Auto-reload**: Changes apply automatically

## Quick Reference

### Basic Usage
- Launch: `zellij`
- Quit: `Ctrl+Q`
- Prefix: `Ctrl+A` (enters locked/prefix mode)

### After Prefix (Ctrl+A)
- `n` - New pane
- `d` - Split down
- `r` - Split right
- `x` - Close pane
- `w` - Toggle floating panes
- `f` - Fullscreen current pane
- `c` - New tab
- `1-9` - Go to tab 1-9
- `?` - Mode selector/help

### Navigation (after Ctrl+A)
- Arrow keys or `h/j/k/l` - Move focus between panes
- `Esc` - Exit prefix mode

### Modes (after Ctrl+A)
- `p` - Pane mode (resize)
- `t` - Tab mode
- `s` - Scroll mode
- `o` - Session mode

## Sessions

```bash
# Attach to session
zellij attach <name>

# Kill session
zellij kill-session <name>

# List sessions
zellij list-sessions
```

## Reload Config

From within Zellij:
```bash
zellij action reload-config
```

## Colors

All colors match WezTerm coolnight theme:
- Background: #011423
- Foreground: #CBE0F0
- Accent colors from WezTerm's ANSI palette
