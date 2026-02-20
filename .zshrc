# --- Cache brew prefix (avoid repeated subshell calls) ---
BREW_PREFIX="/opt/homebrew"

# --- PATH and MANPATH: GNU Utilities First ---
export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# --- Language & Editor ---
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="$EDITOR"

# --- Zsh Completion System (early, so SDKMAN/plugins skip their own compinit) ---
autoload -Uz compinit
# Only do full compinit once a day; otherwise use cached dump
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -u
else
  compinit -C -u
fi

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

# --- Lazy-load NVM ---
nvm() {
  unset -f nvm node npm npx
  export NVM_DIR="$HOME/.nvm"
  [ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && . "$BREW_PREFIX/opt/nvm/nvm.sh"
  [ -s "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
  nvm "$@"
}
node() { nvm "$@"; }
npm() { nvm "$@"; }
npx() { nvm "$@"; }

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
    dotnet --version > "$DOTNET_VER_CACHE" 2>/dev/null
  fi
  
  if [[ -f "$DOTNET_VER_CACHE" ]]; then
    read -r DOTNET_VER < "$DOTNET_VER_CACHE"
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

# OpenClaw Completion
# source "/Users/andregaudencio/.openclaw/completions/openclaw.zsh"
#
# OpenClaw Completion (only if installed)
command -v openclaw &>/dev/null && source <(openclaw completion --shell zsh)

