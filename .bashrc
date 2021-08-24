#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.ssh/agent.env ] ; then
    . ~/.ssh/agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        # echo "Stale agent file found. Spawning a new agent. "
        eval `ssh-agent | tee ~/.ssh/agent.env`
        # ssh-add
    fi
else
    # echo "Starting ssh-agent"
    eval `ssh-agent | tee ~/.ssh/agent.env`
    # ssh-add
fi

HISTSIZE=5000
HISTFILESIZE=10000

if [[ $TERM = "xterm-kitty" ]]; then
    alias ssh="kitty +kitten ssh"
fi

alias ls='ls --color=auto'
alias ll='ls -la'
alias gl='git pull'
alias gp='git push'
alias httpws='http --verify=no --timeout 600 '
alias ssha='ssh-add ~/.ssh/id_rsa'
alias env_upgrade='pip install --upgrade  pip black -r requirements/main.txt -r requirements/tests.txt -r requirements/doc.txt'
alias pip_upgrade='pip install --use-feature=2020-resolver --upgrade `pip list --outdated --format=freeze | cut -d = -f1 | awk '"'"'{printf "%s ", $1}'"'"'`'
alias system-virt-viewer='virt-viewer -c qemu:///system --hotkeys=toggle-fullscreen=ctrl+alt+F,release-cursor=shift+f12'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../..'
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

#alias zlist='zfs list | grep -v "/docker/"'
zlist ()
{
    zfs list $@ | grep -v "/docker/"
}

if [ -f $HOME/.local/share/aliases.sh ]; then
    source $HOME/.local/share/aliases.sh
fi
# PS1='[\u@\h \W]\$ '

source ~/.config/bashrc/git-prompt.sh
parse_git_branch() {
         git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
     }
export PS1='\[\033[1;31m\][localhost] \[\033[1;32m\]\u\[\033[1;32m\]\[\033[01;34m\] \w\[\033[0;33m\]$(__git_ps1 "(%s)") \[\033[01;34m\]$\[\033[00m\] '
