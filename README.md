# Dotfiles Repository

## Phase 1.5: Josean's Terminal Environment Setup

This is a complete rebuild using Josean's production-ready terminal configuration, replacing our basic Phase 1 setup with a sophisticated modern terminal environment.

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

### Josean's Configuration Features

#### WezTerm - Coolnight Theme
- **Font**: MesloLGS Nerd Font Mono, size 19
- **Color Theme**: Custom "coolnight" - deep blue background (#011423) with cyan/accents
- **Window**: Minimal decorations (RESIZE only), tab bar disabled for clean look
- **Colors**: Vibrant ANSI colors with green cursor (#47FF9C) and cyan foreground
- **Source**: Based on Josean's production configuration

#### Tmux - Advanced Setup with TPM
- **Prefix**: `Ctrl+A` (maintained)
- **Keybindings**: 
  - `|` for horizontal split, `-` for vertical split
  - `h/j/k/l` for vim-style pane resizing
  - `Ctrl+A + r` to reload config
- **Plugins via TPM**:
  - `vim-tmux-navigator`: Seamless vim/tmux navigation
  - `tmux-tokyo-night`: Complementary theme
  - `tmux-resurrect`: Session persistence
  - `tmux-continuum`: Auto-save every 15 minutes
- **Features**: Vi copy mode, mouse support, proper color rendering

#### Zsh - Modern Shell Environment
- **Theme**: Powerlevel10k with instant prompt
- **Enhanced History**: 1000 lines, sharing, duplicate removal
- **Smart Completion**: Arrow key history search
- **Modern CLI Tools**:
  - `zsh-autosuggestions`: Real-time command suggestions
  - `zsh-syntax-highlighting`: Command validation
  - `fzf`: Fuzzy finder with coolnight theme colors
  - `eza`: Modern ls replacement with icons
  - `zoxide`: Smart cd replacement (alias `cd=z`)
  - `bat`: Syntax-highlighted cat (tokyonight theme)
  - `yazi`: TUI file manager integration
- **Shell Aliases**: `edit-zsh`, `reload-zsh`, enhanced `ls`

### Installation Requirements

Install required packages via homebrew:

```bash
# Core terminal setup
brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting

# Modern CLI tools  
brew install fzf eza zoxide bat fd ripgrep

# Terminal emulator and tools
brew install wezterm tmux yazi

# Font for terminal
brew install font-meslo-lg-nerd-font
```

### TMX Plugin Manager Setup

After deploying configurations, install tmux plugins:

```bash
# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install plugins (in tmux session)
# Press: Ctrl+A, then Shift+I
```

### Initial Setup Steps

1. **Deploy configurations**:
   ```bash
   cd ~/dotfiles
   stow -t ~ wezterm tmux zshrc
   ```

2. **Configure Powerlevel10k**:
   ```bash
   p10k configure
   ```
   Choose "lean" or "rainbow" style for best color compatibility

3. **Optional: Fix rainbow directory background** (if using rainbow style):
   ```bash
   # Edit ~/.p10k.zsh
   # Change: POWERLEVEL9K_DIR_BACKGROUND=4
   # To:     POWERLEVEL9K_DIR_BACKGROUND=0
   ```

### Color Theme: Coolnight

Josean's custom theme provides consistency across tools:
- **Base**: Deep blue-black (#011423) background
- **Text**: Light cyan-white (#CBE0F0) foreground  
- **Cursor**: Bright green (#47FF9C) for visibility
- **Highlights**: Purple (#B388FF), blue (#06BCE4), cyan (#2CF9ED)
- **Applied to**: WezTerm, fzf, shell prompt, tmux theme

### Deployment

Deploy all configurations:
```bash
cd ~/dotfiles
stow -t ~ wezterm tmux zshrc
```

### Status

- ✅ WezTerm: Josean's coolnight theme
- ✅ Tmux: Advanced setup with TPM plugins
- ✅ Zsh: Modern shell with powerlevel10k and CLI tools
- ✅ Stow symlinks correctly configured

### Next Phase (Phase 2)

- Custom keybindings (Shift+Enter, etc.)
- Theme cycling and transparency
- AI tool integrations
- Advanced modular configurations
- Our original custom features

### Credits

Configuration based on [Josean's terminal setup](https://www.josean.com/posts/how-to-setup-wezterm-terminal) and [dev-environment-files](https://github.com/josean-dev/dev-environment-files).

### Backup Information

Original dotfiles backed up to: `dotfiles_backup_20251103_XXXXX`
