# Zsh Base Configuration
# Phase 1: Basic functional setup

# Basic prompt
PROMPT='%F{green}%n%f@%F{blue}%m%f:%F{yellow}%~%f$ '

# Basic history settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt append_history
setopt inc_append_history
setopt share_history

# Basic completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# Basic directory navigation
setopt autocd
setopt pushd_ignore_dups

# PATH management - basic structure
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Basic aliases - phase 2 expanded
alias ls='ls -G'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
