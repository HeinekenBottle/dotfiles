# Zsh Environment Configuration
# Phase 1: Basic environment variables

# PATH should be set here for all programs
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Basic environment variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Machine-specific environment goes here
# This file should not contain commands that output anything
. "$HOME/.cargo/env"
