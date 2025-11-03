# Zsh Profile Configuration
# Phase 1: Basic settings executed at login

# Set basic environment
export EDITOR=vim
export VISUAL=vim

# Basic PATH additions - will be expanded in phase 2
if [ -d "/usr/local/bin" ]; then
  PATH="/usr/local/bin:$PATH"
fi

# Login-specific settings
if [ -n "$BASH_VERSION" ]; then
  # For bash compatibility if needed
  :
fi
