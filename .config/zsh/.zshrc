# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.local/share/oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Disable all magic functions like https://github.com/zsh-users/zsh/blob/master/Functions/Zle/url-quote-magic
# or https://github.com/zsh-users/zsh/blob/master/Functions/Zle/bracketed-paste-magic
# The idea of magic in shell does not sound right ಠ_ಠ ¯\_(ツ)_/¯ 
DISABLE_MAGIC_FUNCTIONS=true

# Disable just slow paste
# zstyle ':bracketed-paste-magic' active-widgets '.self-*'.

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    zsh-completions
    zsh-autosuggestions
    command-not-found
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Kitty completion
source <(kitty + complete setup zsh)

HISTFILE=~/.config/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt autocd extendedglob nomatch
unsetopt beep notify
bindkey -v
zstyle :compinstall filename '~/.config/zsh/.zshrc'

autoload -Uz compinit
compinit -D
autoload -Uz +X bashcompinit
bashcompinit -D

# Show hidden files
_comp_options+=(globdots)
setopt   COMPLETE_IN_WORD  # Complete from both ends of a word
setopt   ALWAYS_TO_END     # Move cursor to the end of a completed word
setopt   PATH_DIRS         # Perform path search even on command names with slashes
setopt   AUTO_MENU         # Show completion menu on a succesive tab press
setopt   AUTO_LIST         # Automatically list choices on ambiguous completion
setopt   AUTO_REMOVE_SLASH # Remove trailing slashes
setopt   AUTO_PARAM_SLASH  # If completed parameter is a directory, add a trailing slash
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry
setopt   GLOB_COMPLETE     # Show completions for glob instead of expanding
# zstyle ':completion::complete:*' gain-privileges 1
#

# History search
bindkey "^R" history-incremental-pattern-search-backward
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# SSH Agent
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.ssh/agent.env ] ; then
    . ~/.ssh/agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        eval `ssh-agent | tee ~/.ssh/agent.env`
    fi
else
    eval `ssh-agent | tee ~/.ssh/agent.env`
fi

# SSH in Kitty
if [[ $TERM = "xterm-kitty" ]]; then
    alias ssh="kitty +kitten ssh"
fi

# Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias httpws='http --verify=no --timeout 600 '
alias ssha='ssh-add ~/.ssh/id_rsa'
alias env_upgrade='pip install --upgrade  pip black -r requirements/main.txt -r requirements/tests.txt -r requirements/doc.txt'
alias pip_upgrade='pip install --use-feature=2020-resolver --upgrade `pip list --outdated --format=freeze | cut -d = -f1 | awk '"'"'{printf "%s ", $1}'"'"'`'
alias system-virt-viewer='virt-viewer -c qemu:///system --hotkeys=toggle-fullscreen=ctrl+alt+F,release-cursor=shift+f12'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../..'
alias xc='xclip -in -selection clipboard'
alias xcp='xclip -out -selection clipboard'
alias vim='nvim'
pvim ()
{
    env_path="env/bin/activate"
    if [[ ! -z "$1" && -d "$1" && -d "$1/bin" && -f "$1/bin/activate" ]]; then
        env_path="$1/bin/activate"
        shift
    fi
    source $env_path
    nvim $@
    deactivate
}

zlist ()
{
    zfs list $@ | grep -v "/docker/"
}

if [ -f $HOME/.local/share/aliases.sh ]; then
    source $HOME/.local/share/aliases.sh
fi

# editor

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export VISUAL='nvim'
    export EDITOR='nvim'
fi

