# --- Startup Profiling (optional, remove after tuning) ---
# zmodload zsh/zprof

# --- PATH and MANPATH: GNU Utilities First ---
export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# --- Language & Editor ---
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="$EDITOR"

# --- History Options ---
setopt SHARE_HISTORY        # share history between all sessions
setopt HIST_IGNORE_SPACE    # don't record commands that start with a space
setopt INC_APPEND_HISTORY   # write to $HISTFILE immediately, not just when exiting the shell
setopt HIST_IGNORE_ALL_DUPS # remove old duplicates from history
setopt HIST_VERIFY          # don't execute immediately when picking from history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# --- SDKMAN (must be at the end for SDKMAN to work) ---
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# --- Lazy-load NVM ---
nvm() {
  unset -f nvm node npm npx
  export NVM_DIR="$HOME/.nvm"
  [ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
  [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
  nvm "$@"
}
node() { nvm "$@"; }
npm() { nvm "$@"; }
npx() { nvm "$@"; }

# --- fzf Integration ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Go Environment ---
export GOPATH="$HOME/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

# --- Additional PATH additions ---
export PATH="$HOME/.local/bin:/usr/local/sbin:/usr/local/opt/python/libexec/bin:$PATH"

# --- Homebrew Cask Options ---
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# --- Source Personal Aliases and Functions ---
for file in ~/.{aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# --- Zsh Completion System ---
autoload -Uz compinit
compinit

# Optional: Enhanced completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}↓ %d%f'
zstyle ':completion:*' complete-options true

# Homebrew plugin locations
#
# --- Autosuggestions (ghost text) ---
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# --- Syntax Highlighting ---
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# --- History Substring Search ---
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# --- Starship Prompt ---
eval "$(starship init zsh)"

# --- Completion System ---
autoload -Uz compinit
compinit

# --- zsh-autosuggestions and zsh-syntax-highlighting (if installed) ---
# Make sure you have these plugins installed somewhere (e.g., ~/.zsh_plugins/)
# and update the paths below as needed.
if [ -f "${HOME}/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "${HOME}/.zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [ -f "${HOME}/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "${HOME}/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# --- Optional: FZF key bindings/config (if you want) ---
# FZF_CONFIG=~/.fzf.sh
# [ -x "$(command -v fzf)" ] && [ -f "$FZF_CONFIG" ] && source "$FZF_CONFIG"

# --- Final Profiling Output (optional) ---
# zprof
# --- End of .zshrc ---

