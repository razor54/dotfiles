# Path to your oh-my-zsh installation.
export ZSH=/Users/andregaudencio/.oh-my-zsh


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# if you want to profile your zsh startup time
# uncomment the following line and run zprof as the first command in a new shell
zmodload zsh/zprof

#------------------------------------------------------
# Better History
#------------------------------------------------------
setopt SHARE_HISTORY        # share history between all sessions
setopt HIST_IGNORE_SPACE    # don't record commands that start with a space
setopt INC_APPEND_HISTORY   # write to $HISTFILE immediately, not just when exiting the shell
setopt HIST_IGNORE_ALL_DUPS # remove old duplicates from history
setopt HIST_VERIFY          # don't execute immediately when picking from history
HISTSIZE=50000              # store more than the default 10_000 entries
SAVEHIST=$HISTSIZE          # and also store all these entries in our $HISTFILE


#source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

#ZSH_THEME="powerlevel10k/powerlevel10k"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git 
    colorize
    brew 
    zsh-syntax-highlighting 
    docker
    docker-compose 
    kubectl 
    aws 
    zsh-autosuggestions 
    terraform 
    fzf
    macos
    colored-man-pages
    command-not-found
    #gnu-utils
)

#plugins=(git git-extras git-flow virtualenvwrapper pip python fabric django virtualenv)

# User configuration

#export PATH="/Users/demis.rizzotto/bin/Sencha/Cmd/5.0.3.324:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/MacGPG2/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
DEFAULT_USER=$(whoami)

# Default editor
export EDITOR=vi
export VISUAL="$EDITOR"

#------------------------------------------------------
# Aliases
#------------------------------------------------------


alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias vim='/usr/local/bin/vim'
alias one='/Users/andregaudencio/one'
export LC_ALL=en_US.UTF-8
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi



# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


##########################
### PERSO

# set where virutal environments will live 
export WORKON_HOME=$HOME/VirtualEnvPython 
# ensure all new environments are isolated from the site-packages directory 
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages' 
# use the same directory for virtualenvs as virtualenvwrapper 
export PIP_VIRTUALENV_BASE=$WORKON_HOME 
# makes pip detect an active virtualenv and install to it 
export PIP_RESPECT_VIRTUALENV=true 

###########################

export PATH="$HOME/.local/bin:$PATH"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export JAVA_HOME=`/usr/libexec/java_home`

for file in ~/.{aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/usr/local/sbin:$PATH"

# GO
export GOPATH="$HOME/go"
#export GOROOT=/usr/local/opt/go/libexec
# for homebrew
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
complete -o nospace -C /usr/local/bin/terraform terraform

#source /Users/USERNAME/.config/broot/launcher/bash/br

# nvm configs
export NVM_DIR="$HOME/.nvm"
#  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
source $(brew --prefix nvm)/nvm.sh
source $(brew --prefix nvm)/etc/bash_completion.d/nvm

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#source $ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Use gnu utils
#PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
#PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="$(brew --prefix)/opt/gnu-tar/libexec/gnubin:$PATH"
#PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
#MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
MANPATH="$(brew --prefix)/opt/coreutils/libexec/gnuman:$MANPATH"
PATH=$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH

# Open ID api key
#export OPENAI_API_KEY=$(cat ~/openapikey)

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# EKS autocomplete
fpath=($fpath ~/.zsh/completion)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# Load pyenv automatically by appending
# the following to
# ~/.zprofile (for login shells)
# and ~/.zshrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# Add JBang to environment
alias j!=jbang

eval "$(starship init zsh)"
#------------------------------------------------------
# Autocompletion
#------------------------------------------------------

zmodload zsh/complist
autoload -U compinit; compinit
_comp_options+=(globdots)   # include hidden files
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.


# Use select menu for completions
zstyle ':completion:*' menu select

# Autocomplete options when completing a '-'
zstyle ':completion:*' complete-options true

# Style group names a little nicer
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}↓ %d %f'

# Group completion results by type
zstyle ':completion:*' group-name ''

# Set up fzf for general auto-completion shenanigans, if it's installed
FZF_CONFIG=~/.fzf.sh
if [[ -x "$(command -v fzf)" ]] && [[ -f "$FZF_CONFIG" ]]; then
  source "$FZF_CONFIG"
fi
eval "$(mise activate)"
