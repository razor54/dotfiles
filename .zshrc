# --- Startup Profiling (optional, remove after tuning) ---
# zmodload zsh/zprof

# --- PATH and MANPATH: GNU Utilities First ---
export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# --- Language & Editor ---
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="$EDITOR"

# vim mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# --- History Options ---
setopt SHARE_HISTORY        # share history between all sessions
setopt HIST_IGNORE_SPACE    # don't record commands that start with a space
setopt INC_APPEND_HISTORY   # write to $HISTFILE immediately, not just when exiting the shell
setopt HIST_IGNORE_ALL_DUPS # remove old duplicates from history
setopt HIST_VERIFY          # don't execute immediately when picking from history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

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

# fzf parameters used in all widgets - configure layout and wrapped the preview results (useful in large command rendering)
export FZF_DEFAULT_OPTS="--height 100% --layout reverse --preview-window=wrap"

# CTRL + R: put the selected history command in the preview window - "{}" will be replaced by item selected in fzf execution runtime
export FZF_CTRL_R_OPTS="--preview 'echo {}'"

# CTRL + T: set "fd-find" as search engine instead of "find" and exclude .git for the results
export FZF_CTRL_T_COMMAND="fd --exclude .git --ignore-file $HOME/.my-custom-zsh/.fd-fzf-ignore"

# CTRL + T: put the file content if item select is a file, or put tree command output if item selected is directory
export FZF_CTRL_T_OPTS="--preview '[ -d {} ] && tree -C {} || bat --color=always --style=numbers {}'"

# disable CTRL + S and CTRL + Q
stty -ixon

# enable comments "#" expressions in the prompt shell
setopt INTERACTIVE_COMMENTS

# append new history entries to the history file
setopt APPEND_HISTORY

# save each command to the history file as soon as it is executed
setopt INC_APPEND_HISTORY

# ignore recording duplicate consecutive commands in the history
setopt HIST_IGNORE_DUPS

# ignore commands that start with a space in the history
setopt HIST_IGNORE_SPACE

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

# >>> load ZSH plugin

# --- Final Profiling Output (optional) ---
# zprof
# --- End of .zshrc ---
