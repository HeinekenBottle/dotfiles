# Dotfiles Repository

## Phase 1: Basic Terminal Environment Setup

This is a complete ground-up rebuild of my dotfiles configuration, focusing on establishing a functional terminal environment first.

### Structure

```
dotfiles/
├── wezterm/
│   └── .config/wezterm/
│       ├── wezterm.lua
│       └── modules/
├── tmux/
│   └── .tmux.conf
├── zshrc/
│   ├── .zshrc
│   ├── .zprofile
│   └── .zshenv
└── README.md
```

### Phase 1 Configuration

#### WezTerm
- Basic Lua configuration structure
- JetBrains Mono Nerd Font, size 12
- Tomorrow Night color scheme
- Basic window padding and opacity
- No custom modules or themes (deferred to Phase 2)

#### Tmux
- Prefix: `Ctrl+A`
- Basic status bar
- Mouse support enabled
- 256-color terminal support
- No custom keybindings (deferred to Phase 2)

#### Zsh
- Basic prompt with user@host:directory format
- History management with 1000 line limit
- Basic completion enabled
- Simple aliases for ls commands
- No custom functions (deferred to Phase 2)

### Deployment

Deploy all configurations:
```bash
cd ~/dotfiles
stow -t ~ wezterm tmux zshrc
```

### Status

- ✅ WezTerm: Basic configuration
- ✅ Tmux: Basic configuration
- ✅ Zsh: Basic configuration
- ✅ Stow symlinks created correctly

### Next Phase (Phase 2)

- Custom keybindings and themes
- Advanced tmux hooks
- AI tool integrations
- Enhanced shell functions
- Theme cycling capabilities

### Backup Information

Original dotfiles backed up to: `dotfiles_backup_20251103_XXXXX`
