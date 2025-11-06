# Shell Configuration & PATH Reference Guide

**Purpose:** This document explains how Unix shell configuration works, where tools should be installed, and why PATH ordering matters. Reference this when an AI suggests removing or moving tools around - it will help you evaluate if that advice is correct.

**Status:** Based on real debugging session (November 6, 2025) - proven to work across Intel and Apple Silicon Macs.

---

## Table of Contents

1. [PATH Fundamentals](#path-fundamentals)
2. [The Four Tool Categories](#the-four-tool-categories)
3. [Where Things Actually Go](#where-things-actually-go)
4. [Shell Initialization Order](#shell-initialization-order)
5. [Common Misconceptions & Myths](#common-misconceptions--myths)
6. [Real-World Examples](#real-world-examples)
7. [Troubleshooting "Command Not Found"](#troubleshooting-command-not-found)
8. [Decision Tree: Where Should This Go?](#decision-tree-where-should-this-go)

---

## PATH Fundamentals

### What is PATH?

PATH is an **ordered list of directories** where the shell looks for commands.

```bash
$ echo $PATH
/Users/jack/.nvm/versions/node/v22.19.0/bin:/Users/jack/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

### How PATH Works (Left to Right)

When you type a command, the shell:

```
You type: $ grep
         ↓
1. Look in: ~/.nvm/versions/node/v22.19.0/bin/
   Found? No, move on
         ↓
2. Look in: ~/.local/bin/
   Found? No, move on
         ↓
3. Look in: /opt/homebrew/bin/
   Found? No, move on
         ↓
4. Look in: /usr/local/bin/
   Found? No, move on
         ↓
5. Look in: /usr/bin/
   Found? YES! → Execute /usr/bin/grep
```

**The FIRST matching command wins.** This is critical for understanding everything below.

---

## The Four Tool Categories

There are four distinct categories of tools on your system:

### Category 1: System Tools (Baked Into macOS)

**What they are:**
- Tools that come WITH the operating system
- Essential for system functioning
- You don't install them

**Examples:**
- `grep`, `sed`, `awk`, `cat`, `ls`, `find`, `chmod`, `chown`
- `sh`, `bash`, `zsh` (shells themselves)
- `git` (sometimes pre-installed)

**Where they live:**
```bash
/bin/
├── cat, ls, pwd, sh, zsh, etc.

/usr/bin/
├── grep, sed, awk, find, perl, python, etc.

/usr/sbin/
├── (admin-only tools)
```

**How you use them:**
- They're already in PATH
- Just type the command: `grep "pattern" file.txt`
- **You never install these**

**What NOT to do:**
- ❌ Don't try to "organize" them elsewhere
- ❌ Don't put newer versions in `~/.local/bin` without good reason
- ❌ Don't remove them from PATH to "clean it up"

---

### Category 2: Package Manager Tools (Homebrew)

**What they are:**
- Installed via Homebrew (`brew install xyz`)
- Managed by Homebrew's package system
- Designed to be system-wide tools

**Examples:**
```bash
brew install git        → /opt/homebrew/bin/git
brew install nvim       → /opt/homebrew/bin/nvim
brew install ripgrep    → /opt/homebrew/bin/rg
brew install fd         → /opt/homebrew/bin/fd
brew install bat        → /opt/homebrew/bin/bat
brew install eza        → /opt/homebrew/bin/eza
brew install fzf        → /opt/homebrew/bin/fzf
brew install node       → /opt/homebrew/bin/node (DON'T DO THIS - use NVM instead)
```

**Where they live:**
```bash
/opt/homebrew/bin/          ← Apple Silicon Macs
/usr/local/bin/             ← Intel Macs (legacy)
```

**How you use them:**
- Install: `brew install xyz`
- Update: `brew upgrade xyz`
- Remove: `brew uninstall xyz`
- They're automatically in PATH

**What NOT to do:**
- ❌ Don't move Homebrew packages to `~/.local/bin`
- ❌ Don't try to "organize" them elsewhere
- ❌ Don't manually edit files in `/opt/homebrew/bin/` (Homebrew manages these)

---

### Category 3: Node.js Development Tools (NVM)

**What they are:**
- JavaScript/Node.js tools installed via npm
- Version-specific (each Node version has its own set)
- Installed with: `npm install -g package-name`

**Examples:**
```bash
npm install -g @anthropic-ai/claude-cli
npm install -g goose-cli
npm install -g @abacus-ai/cli
npm install -g typescript
npm install -g prettier
npm install -g eslint
```

**Where they live:**
```bash
~/.nvm/versions/node/v22.19.0/lib/node_modules/
~/.nvm/versions/node/v22.19.0/bin/
```

**How you use them:**
- Install: `npm install -g xyz`
- Update: `npm install -g xyz@latest`
- Remove: `npm uninstall -g xyz`
- List all: `npm list -g --depth=0`

**Critical Detail: Per-Version Globals**
```bash
# If you have Node 22 and Node 20 installed:
nvm use 22
npm install -g typescript  # Goes to v22.19.0/lib/node_modules/

nvm use 20
npm install -g typescript  # Goes to v20.x.x/lib/node_modules/
# They're SEPARATE installations!

# Switch versions:
nvm use 22
typescript --version       # Uses the 22 version
```

**What NOT to do:**
- ❌ Don't use: `sudo npm install -g xyz` (defeats purpose of NVM)
- ❌ Don't install Node with Homebrew (`brew install node`) - conflicts with NVM
- ❌ Don't move npm packages to `~/.local/bin`
- ❌ Don't install global packages to system npm

---

### Category 4: Personal/Custom Tools (User Bin)

**What they are:**
- Scripts you wrote
- Custom utilities for your workflow
- One-off fixes or workarounds
- Tools specific to your needs

**Examples:**
```bash
~/.local/bin/
├── my-backup-script           ← Script you wrote
├── my-deploy-to-server        ← Custom deployment tool
├── abacusai                    ← Wrapper script we created to fix broken app
├── my-git-helper              ← Custom git utility
└── cleanup-old-files           ← Automation script you wrote
```

**Where they live:**
```bash
~/.local/bin/
```

**How you use them:**
- Create: Write script, `chmod +x`, put in `~/.local/bin/`
- Update: Edit the script directly
- Remove: `rm ~/.local/bin/script-name`

**What this is FOR:**
- ✅ Custom scripts
- ✅ Local utilities
- ✅ Wrapper scripts (like our abacusai fix)
- ✅ Temporary workarounds

**What this is NOT for:**
- ❌ Standard Unix tools (they're in `/bin` or `/usr/bin`)
- ❌ Homebrew packages (they're in `/opt/homebrew/bin`)
- ❌ npm packages (they're in `~/.nvm/.../bin`)

---

## Where Things Actually Go

### The Complete Map

```
PRIORITY          LOCATION                        MANAGED BY          CONTAINS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1 (Highest)       ~/.nvm/versions/node/v22/bin/  You (via npm)        npm packages
2                 ~/.local/bin/                   You (manually)       Custom scripts
3                 /opt/homebrew/bin/              Homebrew             Brew packages
4                 /usr/local/bin/                 Legacy/Manual        Legacy installs
5                 /usr/bin/                       macOS                 System tools
6                 /bin/                           macOS                 Core system
7                 /usr/sbin/                      macOS                 Admin tools
8 (Lowest)        /sbin/                          macOS                 Core admin
```

### Real Example: Where is `grep`?

```bash
$ which grep
/usr/bin/grep

$ echo $PATH
~/.nvm/versions/node/v22.19.0/bin:~/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:...

# Search order:
1. ~/.nvm/...          → NOT FOUND
2. ~/.local/bin/       → NOT FOUND
3. /opt/homebrew/bin/  → NOT FOUND
4. /usr/local/bin/     → NOT FOUND
5. /usr/bin/           → FOUND! (/usr/bin/grep)
```

### Real Example: Where is `nvim`?

```bash
$ which nvim
/opt/homebrew/bin/nvim

$ echo $PATH
~/.nvm/versions/node/v22.19.0/bin:~/.local/bin:/opt/homebrew/bin:...

# Search order:
1. ~/.nvm/...          → NOT FOUND
2. ~/.local/bin/       → NOT FOUND
3. /opt/homebrew/bin/  → FOUND! (/opt/homebrew/bin/nvim)
```

### Real Example: Where is `goose`?

```bash
$ which goose
/Users/jack/.nvm/versions/node/v22.19.0/bin/goose

$ echo $PATH
~/.nvm/versions/node/v22.19.0/bin:~/.local/bin:/opt/homebrew/bin:...

# Search order:
1. ~/.nvm/.../bin/     → FOUND! (goose)
```

---

## Shell Initialization Order

### The Sequence (Left to Right)

When you open a terminal, zsh executes in this order:

```
1. /etc/zshenv                          (System-wide environment)
2. ~/.zshenv                            (Your environment variables)
3. /etc/zprofile                        (System-wide login setup)
4. ~/.zprofile                          (Your login setup)
5. /etc/zshrc                           (System-wide interactive setup)
6. ~/.zshrc                             (Your interactive setup)
7. /etc/zlogin                          (System-wide login final)
8. ~/.zlogin                            (Your login final)
```

### Critical: `.zshenv` Runs FIRST

**`.zshenv` runs on EVERY shell invocation:**
```bash
# Both interactive and non-interactive shells load .zshenv
```

**This is where you set PATH!**

```bash
# In ~/.zshenv:
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
```

**Why this matters:**
- If PATH is broken in `.zshenv`, EVERYTHING is broken
- Scripts and cron jobs that don't load `.zshrc` still use `.zshenv`
- This is why your system was broken yesterday!

### What Goes Where

**In `.zshenv` (runs first, always):**
```bash
# Environment variables
export PATH="..."
export LANG="en_US.UTF-8"
export EDITOR="nvim"

# Source cargo env (needed before anything else)
source "$HOME/.cargo/env"
```

**In `.zshrc` (runs second, interactive shells only):**
```bash
# Plugins and interactive shell setup
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Initialize NVM (modifies PATH again)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Aliases and functions
alias ls="eza --icons=always"
```

### Why Your Config Got Corrupted

**Your `.zshenv` was missing `/opt/homebrew/bin`:**
```bash
# BROKEN (what you had):
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# Missing: /opt/homebrew/bin

# CORRECT (what it should be):
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# Includes: /opt/homebrew/bin
```

**Result:**
```
Homebrew tools not in PATH
  ↓
NVM not in PATH
  ↓
System node used instead of NVM node
  ↓
Claude Code picks wrong node
  ↓
Configs get corrupted
  ↓
WezTerm breaks
```

---

## Common Misconceptions & Myths

### Myth 1: "I should put everything in `~/.local/bin` to organize my system"

**FALSE.** Different tools belong in different places for good reasons:
- System tools → `/bin`, `/usr/bin` (don't move them)
- Homebrew packages → `/opt/homebrew/bin` (Homebrew manages them)
- npm packages → `~/.nvm/.../bin` (npm manages them)
- Custom scripts → `~/.local/bin` (you manage them)

**Moving things breaks their management systems.**

---

### Myth 2: "If a PATH directory is empty, I should remove it"

**FALSE.** Just because `/opt/homebrew/bin/` is empty on your Intel Mac doesn't mean remove it:
- It prepares you for Apple Silicon (which uses it)
- It's not hurting anything
- It's future-proof
- Removing it breaks portable dotfiles

**Keep it. It's harmless.**

---

### Myth 3: "npm global installs need sudo"

**FALSE.** With NVM, they never need sudo:
```bash
npm install -g goose-cli     # ✓ Works, no sudo needed

sudo npm install -g goose-cli # ✗ Wrong! Installs to wrong place
```

**The whole point of NVM is avoiding sudo.**

---

### Myth 4: "I should install Node with Homebrew"

**FALSE.** Don't do this:
```bash
brew install node              # ✗ Creates conflicts with NVM

npm install -g goose-cli       # Goes to /opt/homebrew/lib/node_modules
                               # Different from NVM packages
```

**Use NVM only. It's designed for this.**

---

### Myth 5: "I can move a Homebrew package to `~/.local/bin`"

**FALSE.** Don't try:
```bash
# Don't do this:
cp /opt/homebrew/bin/ripgrep ~/.local/bin/rg

# Homebrew won't know about it
# Updates won't work
# Dependencies might break
```

**Let Homebrew manage Homebrew packages.**

---

### Myth 6: "An AI telling me to remove something from PATH must be right"

**FALSE - Use this document as evidence:**

An AI might say:
> "You have `/opt/homebrew/bin` in your PATH but nothing is currently installed there. Remove it to clean up."

**Actually:**
- It's correct to include `/opt/homebrew/bin` for future compatibility
- It doesn't hurt being there
- It breaks portable dotfiles if you remove it
- On Apple Silicon it's REQUIRED

**Don't blindly follow advice to "clean up" PATH.**

---

## Real-World Examples

### Example 1: Installing ripgrep

**What you do:**
```bash
brew install ripgrep
```

**What happens:**
```
1. Homebrew downloads ripgrep
2. Compiles it for your system
3. Installs to: /opt/homebrew/bin/rg
4. Registers in Homebrew's database
5. You can run: rg "pattern" file.txt
```

**What NOT to do:**
```bash
# Wrong: Don't try to move it
cp /opt/homebrew/bin/rg ~/.local/bin/rg

# Wrong: Don't reinstall it to a different location
npm install -g ripgrep  (this isn't even an npm package)
```

**Answer to "But it's not in `~/.local/bin`?":**
- ✓ Correct! It shouldn't be. Let Homebrew manage it.

---

### Example 2: Installing Goose CLI

**Yesterday's problem:**
```bash
npm install -g goose-cli

# With broken PATH, this failed
# As a workaround, someone put goose in ~/.local/bin

# Result: Wrong location, version conflicts possible
```

**Today's solution:**
```bash
# Fixed PATH (in .zshenv)
export PATH="$HOME/.local/bin:/opt/homebrew/bin:..."

# Now NVM initializes properly
npm install -g goose-cli

# Goes to correct location:
~/.nvm/versions/node/v22.19.0/bin/goose
```

**Why this matters:**
- If you switch Node versions, goose switches too
- Updates work correctly via npm
- No manual management needed

---

### Example 3: The abacusai Wrapper

**The problem:**
```
/Applications/AbacusAI.app/
├── Contents/Resources/app/
│   └── node              ← Bundled Node (broken, crashes with V8 error)
```

**The solution:**
```bash
# Can't be installed via npm (it's a desktop app)
# Can't use bundled Node (it crashes)
# Create a custom wrapper:

~/.local/bin/abacusai
├── #!/usr/bin/env bash
├── node /Applications/AbacusAI.app/.../cli.js agent "$@"
```

**This is CORRECT use of `~/.local/bin`:**
- ✓ It's a custom wrapper
- ✓ It's a workaround for a specific problem
- ✓ It manages a tool that can't be package-managed
- ✓ It's the only place this belongs

**NEVER put actual npm packages in `~/.local/bin`** - that's what happened with goose, and it was wrong.

---

### Example 4: The PATH That Works Everywhere

Your current PATH:
```bash
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
```

**Why this works on Intel Macs:**
```
1. ~/.local/bin/           → Your custom tools
2. /opt/homebrew/bin/      → Empty (Apple Silicon location), but harmless
3. /usr/local/bin/         → Where Intel Homebrew actually installs
4. /usr/bin/               → System tools (grep, sed, etc.)
```

**Why this works on Apple Silicon Macs:**
```
1. ~/.local/bin/           → Your custom tools
2. /opt/homebrew/bin/      → WHERE Homebrew actually installs
3. /usr/local/bin/         → Empty (Intel location), but harmless
4. /usr/bin/               → System tools
```

**Same PATH, both architectures, everything works!**

---

## Troubleshooting "Command Not Found"

When you get "command not found", systematically check:

### Step 1: Verify command exists
```bash
which goose
# If nothing prints, it's not in PATH or doesn't exist
```

### Step 2: Check if it's supposed to exist
```bash
npm list -g --depth=0 | grep goose
# If not listed, reinstall it
```

### Step 3: Check your current PATH
```bash
echo $PATH
# Does it include where the command should be?
```

### Step 4: Check if NVM initialized
```bash
echo $NVM_DIR
# Should print: /Users/jack/.nvm

nvm current
# Should print: v22.19.0 (or your version)
```

### Step 5: Manually initialize and test
```bash
source ~/.nvm/nvm.sh

goose --version
# If this works, your .zshrc isn't loading properly
```

### Step 6: Check which version you're using
```bash
nvm current
# npm packages are version-specific
# Make sure you're in the right version
```

---

## Decision Tree: Where Should This Go?

**Use this flowchart when deciding where to install something:**

```
START
  ↓
"Is this a built-in Unix tool?"
├─ YES → /bin or /usr/bin (already there, don't move)
└─ NO → Next question

"Did I install it with: brew install xyz?"
├─ YES → /opt/homebrew/bin (Homebrew manages it)
└─ NO → Next question

"Did I install it with: npm install -g xyz?"
├─ YES → ~/.nvm/versions/node/vXX/bin (npm manages it)
└─ NO → Next question

"Did I write this script myself or create a custom wrapper?"
├─ YES → ~/.local/bin (you manage it)
└─ NO → STOP - Unclear where this belongs

"Can this be installed with apt, brew, npm, or another package manager?"
├─ YES → Use that package manager (don't put in ~/.local/bin)
└─ NO → ~/.local/bin (it's a custom tool)

DONE
```

---

## Summary Table

| Tool Type | Install Method | Where It Goes | Who Manages It | Update Method |
|-----------|----------------|---------------|----------------|---------------|
| System Tool | Comes with macOS | `/bin` or `/usr/bin` | macOS | macOS updates |
| Homebrew | `brew install xyz` | `/opt/homebrew/bin` | Homebrew | `brew upgrade` |
| npm Package | `npm install -g xyz` | `~/.nvm/.../bin` | npm | `npm upgrade -g` |
| Custom Script | You write it | `~/.local/bin` | You | Edit manually |

---

## Key Takeaways

1. **PATH order matters** - First match wins, so order is critical
2. **Don't move tools** - Let their package managers manage them
3. **`.zshenv` is critical** - It loads first and must be correct
4. **NVM is best for Node** - Never use `brew install node`
5. **`~/.local/bin` is for personal tools** - Not for package-managed software
6. **Ask before deleting** - "Cleaning up" PATH can break things

---

## References

- **Date Created:** November 6, 2025
- **Created From:** Real debugging session fixing shell configuration issues
- **Hardware Tested:** Intel Mac (with Apple Silicon compatibility)
- **Shells:** zsh (with NVM, Homebrew, and npm)
- **Proven To:** Resolve "command not found", path conflicts, and configuration corruption

---

**Version:** 1.0
**Last Updated:** 2025-11-06
**Status:** Verified working configuration
