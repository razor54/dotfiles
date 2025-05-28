# --- Startup Profiling (optional, remove after tuning) ---
# zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH=/Users/andregaudencio/.oh-my-zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# --- GNU Utils: PATH and MANPATH ---
export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# --- Environment Variables ---
export LANG="en_US.UTF-8"
export EDITOR="nvim"
##------------------------------------------------------
## Better History
##------------------------------------------------------
setopt SHARE_HISTORY        # share history between all sessions
setopt HIST_IGNORE_SPACE    # don't record commands that start with a space
setopt INC_APPEND_HISTORY   # write to $HISTFILE immediately, not just when exiting the shell
setopt HIST_IGNORE_ALL_DUPS # remove old duplicates from history
setopt HIST_VERIFY          # don't execute immediately when picking from history
HISTSIZE=100000             # store more than the default 10_000 entries
SAVEHIST=$HISTSIZE          # and also store all these entries in our $HISTFILE


# --- Oh-My-Zsh Setup ---
export ZSH="$HOME/.oh-my-zsh"
export DISABLE_AUTO_UPDATE="true"
export DISABLE_MAGIC_FUNCTIONS="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"

# --- Plugins (including gnu-utils for OMZ) ---
plugins=(
  git
  fzf
  gnu-utils
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# --- Manual Plugin Loading (if needed) ---
# source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- Lazy-load NVM ---
nvm() {
  unset -f nvm node npm npx
  export NVM_DIR="$HOME/.nvm"
  [ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
  [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
  nvm "$@"
}
node() { nvm "$@"; }
npm() { nvm "$@"; }
npx() { nvm "$@"; }

# --- Optimized Completion ---
##autoload -Uz compinit
##if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
##  compinit
##else
##  compinit -C
##fi

# --- Powerlevel10k Theme ---
#[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- Aliases (keep in a separate file for clarity) ---
#[ -f ~/.aliases ] && source ~/.aliases

# Default editor
export EDITOR=vi
export VISUAL="$EDITOR"

## Use gnu utils
##PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
#PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
##PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
#PATH="$(brew --prefix)/opt/gnu-tar/libexec/gnubin:$PATH"
##PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
##MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
#MANPATH="$(brew --prefix)/opt/coreutils/libexec/gnuman:$MANPATH"
#PATH=$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH
#
#
#source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
#export PATH="/usr/local/opt/python/libexec/bin:$PATH"
#
#
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


#export PYENV_ROOT="$HOME/.pyenv"
#[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
#
#
## Add JBang to environment
#alias j!=jbang
#
eval "$(starship init zsh)"
##------------------------------------------------------
## Autocompletion
##------------------------------------------------------
#
#zmodload zsh/complist
#autoload -U compinit; compinit
#_comp_options+=(globdots)   # include hidden files
#setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
#setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
#
#
## Use select menu for completions
#zstyle ':completion:*' menu select
#
## Autocomplete options when completing a '-'
#zstyle ':completion:*' complete-options true
#
## Style group names a little nicer
#zstyle ':completion:*:*:*:*:descriptions' format '%F{green}↓ %d %f'
#
## Group completion results by type
#zstyle ':completion:*' group-name ''
#
## Set up fzf for general auto-completion shenanigans, if it's installed
#FZF_CONFIG=~/.fzf.sh
#if [[ -x "$(command -v fzf)" ]] && [[ -f "$FZF_CONFIG" ]]; then
#  source "$FZF_CONFIG"
#fi
#eval "$(mise activate)"


#source $ZSH/oh-my-zsh.sh
#
#export LC_ALL=en_US.UTF-8
#if command -v pyenv 1>/dev/null 2>&1; then
#  eval "$(pyenv init -)"
#fi

#
###########################
#### PERSO
#
## set where virutal environments will live 
#export WORKON_HOME=$HOME/VirtualEnvPython 
## ensure all new environments are isolated from the site-packages directory 
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages' 
## use the same directory for virtualenvs as virtualenvwrapper 
#export PIP_VIRTUALENV_BASE=$WORKON_HOME 
## makes pip detect an active virtualenv and install to it 
#export PIP_RESPECT_VIRTUALENV=true 
#
############################
#
export PATH="$HOME/.local/bin:$PATH"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
#export JAVA_HOME=`/usr/libexec/java_home`

for file in ~/.{aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/usr/local/sbin:$PATH"

# GO
export GOPATH="$HOME/go"
#export GOROOT=/usr/local/opt/go/libexec
# for homebrew
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
#
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#export PATH="$HOME/.jenv/bin:$PATH"
#eval "$(jenv init -)"
#
#autoload -U +X bashcompinit && bashcompinit
#complete -o nospace -C /usr/local/bin/vault vault
#complete -o nospace -C /usr/local/bin/terraform terraform
#
##source /Users/USERNAME/.config/broot/launcher/bash/br
#
## nvm configs
#export NVM_DIR="$HOME/.nvm"
##  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
##  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#source $(brew --prefix nvm)/nvm.sh
#source $(brew --prefix nvm)/etc/bash_completion.d/nvm
#
## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
##[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
##source $ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme
#
## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#
#
#source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
#export PATH="/usr/local/opt/python/libexec/bin:$PATH"
#


#
## --- Final Profiling Output (optional) ---
# zprof


