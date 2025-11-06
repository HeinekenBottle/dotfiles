# Zsh Environment Configuration
# This file runs on EVERY shell invocation (interactive and non-interactive)
# Only put things here that are needed by scripts, cron jobs, and interactive shells

# PATH should be set here for all programs
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Basic environment variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Editor (needed by scripts)
export EDITOR="nvim"

# NVM configuration (initialized in .zshrc, but variable set here)
export NVM_DIR="$HOME/.nvm"

# Tool configuration variables (needed globally)
export BAT_THEME=tokyonight_night
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# FZF theme colors (needed by interactive shells)
export FZF_DEFAULT_OPTS="--color=fg:#CBE0F0,bg:#011628,hl:#B388FF,fg+:#CBE0F0,bg+:#143652,hl+:#B388FF,info:#06BCE4,prompt:#2CF9ED,pointer:#2CF9ED,marker:#2CF9ED,spinner:#2CF9ED,header:#2CF9ED"

# Source Rust/Cargo environment (needed before anything else)
. "$HOME/.cargo/env"
