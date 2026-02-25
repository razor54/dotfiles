# --- Cache brew prefix (avoid repeated subshell calls) ---
BREW_PREFIX="/opt/homebrew"

# --- PATH and MANPATH: GNU Utilities First ---
export PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$BREW_PREFIX/opt/grep/libexec/gnubin:$PATH"
export MANPATH="$BREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"

# --- Language & Editor ---
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="$EDITOR"

# --- Zsh Completion System (early, so SDKMAN/plugins skip their own compinit) ---
autoload -Uz compinit
# Always use cached dump (-C skips security check, -u allows insecure dirs)
compinit -C -u

# vim mode
source "$BREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

# --- History Options ---
setopt SHARE_HISTORY        # share history between all sessions
setopt HIST_IGNORE_SPACE    # don't record commands that start with a space
setopt INC_APPEND_HISTORY   # write to $HISTFILE immediately, not just when exiting the shell
setopt HIST_IGNORE_ALL_DUPS # remove old duplicates from history
setopt HIST_VERIFY          # don't execute immediately when picking from history
setopt APPEND_HISTORY       # append new history entries to the history file
setopt HIST_IGNORE_DUPS     # ignore recording duplicate consecutive commands
setopt INTERACTIVE_COMMENTS # enable comments "#" expressions in the prompt shell
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

# --- Lazy-load SDKMAN ---
export SDKMAN_DIR="$HOME/.sdkman"
export PATH="$SDKMAN_DIR/candidates/java/current/bin:$SDKMAN_DIR/candidates/gradle/current/bin:$SDKMAN_DIR/candidates/maven/current/bin:$PATH"
sdk() {
  unset -f sdk
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}

# --- fzf Integration ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || true

# --- Go Environment ---
export GOPATH="$HOME/go"
export GOROOT="$BREW_PREFIX/opt/go/libexec"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

# --- DotNet Environment ---
if command -v dotnet >/dev/null 2>&1; then
  export DOTNET_ROOT="/usr/local/share/dotnet"

  # Cache dotnet version to avoid slow $(dotnet --version)
  DOTNET_VER_CACHE="$HOME/.cache/dotnet_version"
  if [[ ! -f "$DOTNET_VER_CACHE" ]]; then
    mkdir -p "$(dirname "$DOTNET_VER_CACHE")"
    dotnet --version >"$DOTNET_VER_CACHE" 2>/dev/null
  fi

  if [[ -f "$DOTNET_VER_CACHE" ]]; then
    read -r DOTNET_VER <"$DOTNET_VER_CACHE"
    export MSBuildSDKsPath="$DOTNET_ROOT/sdk/$DOTNET_VER/Sdks"
  fi
  export PATH="$DOTNET_ROOT:$PATH"
fi

# --- Additional PATH additions ---
export PATH="$HOME/.local/bin:/usr/local/sbin:/usr/local/opt/python/libexec/bin:$PATH"

# --- Homebrew Cask Options ---
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# --- Source Personal Aliases and Functions ---
for file in ~/.{aliases,functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Enhanced completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}↓ %d%f'
zstyle ':completion:*' complete-options true

# --- Zsh plugins (from Homebrew) ---
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# --- Oh My Posh prompt ---
eval "$(oh-my-posh init zsh --config "$HOME/.config/oh-my-posh/theme.omp.json")"

# --- FZF configuration ---
export FZF_DEFAULT_OPTS="--height 100% --layout reverse --preview-window=wrap"
export FZF_CTRL_R_OPTS="--preview 'echo {}'"
export FZF_CTRL_T_COMMAND="fd --exclude .git --ignore-file $HOME/.my-custom-zsh/.fd-fzf-ignore"
export FZF_CTRL_T_OPTS="--preview '[ -d {} ] && tree -C {} || bat --color=always --style=numbers {}'"

# disable CTRL + S and CTRL + Q
stty -ixon

# >>> bindkey tip: to discovery the code of your keys, execute "$ cat -v" and press the key, the code will be printed in your shell.

# use the ZLE (zsh line editor) in emacs mode. Useful to move the cursor in large commands
bindkey -v

# navigate words using Ctrl + arrow keys
# >>> CRTL + right arrow | CRTL + left arrow
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# macosx override
if [[ "$OSTYPE" == "darwin"* ]]; then
  # >>> OPT + right arrow | OPT + left arrow
  bindkey "^[^[[C" forward-word
  bindkey "^[^[[D" backward-word
fi

# search history using Up and Down keys
# >>> up arrow | down arrow
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# jump to the start and end of the command line
# >>> CTRL + A | CTRL + E
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
# >>> Home | End
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# navigate menu for command output
zstyle ':completion:*:*:*:*:*' menu select
bindkey '^[[Z' reverse-menu-complete

# delete characters using the "delete" key
bindkey "^[[3~" delete-char

# fzf alias: CTRL + SPACE (gadget parameters configured in the FZF_CTRL_T_COMMAND environment variable)
bindkey "^@" fzf-file-widget

# --- JBang ---
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

alias claude-mem='bun "/Users/andregaudencio/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

# only for when we have 2 instances of claude, to avoid conflicts with the config dir
alias claude-2="CLAUDE_CONFIG_DIR=~/.claude-2 command claude"

# Source private secrets (gitignored)
[ -f ~/.secrets ] && source ~/.secrets || true

# OpenClaw Completion (cached for performance)
if command -v openclaw &>/dev/null; then
  OPENCLAW_COMP_CACHE="$HOME/.cache/openclaw_completion"
  # Regenerate if cache doesn't exist or is older than 30 days
  if [[ ! -f "$OPENCLAW_COMP_CACHE" ]] ||
    [[ -n "$(find "$OPENCLAW_COMP_CACHE" -mtime +30 2>/dev/null)" ]]; then
    mkdir -p "$(dirname "$OPENCLAW_COMP_CACHE")"
    openclaw completion --shell zsh >"$OPENCLAW_COMP_CACHE" 2>/dev/null
  fi
  [[ -f "$OPENCLAW_COMP_CACHE" ]] && source "$OPENCLAW_COMP_CACHE"
fi

# --- NVM (lazy-loaded for fast shell startup) ---
export NVM_DIR="$HOME/.nvm"

# Make node/npm/npx available immediately by adding default version to PATH
# Resolves the latest installed version (handles alias "node" = latest)
NVM_DEFAULT_PATH="$(ls -d "$NVM_DIR/versions/node/"v* 2>/dev/null | sort -V | tail -1)/bin"
[ -d "$NVM_DEFAULT_PATH" ] && export PATH="$NVM_DEFAULT_PATH:$PATH"

# Only source nvm.sh when `nvm` command is actually called
_lazy_load_nvm() {
  unset -f nvm
  [ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && . "$BREW_PREFIX/opt/nvm/nvm.sh"
  [ -s "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
}
nvm() { _lazy_load_nvm && nvm "$@"; }

# Auto-switch node version on directory change (loads nvm on first trigger)
autoload -U add-zsh-hook
_lazy_load_nvmrc() {
  if [ -f ".nvmrc" ] || [ -f ".node-version" ]; then
    _lazy_load_nvm  # ensure nvm is loaded
    nvm use --silent 2>/dev/null
  fi
}
add-zsh-hook chpwd _lazy_load_nvmrc
