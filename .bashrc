## If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=10000

shopt -s histappend
shopt -s globstar
shopt -s checkwinsize
shopt -s autocd  
shopt -s expand_aliases

# share history with multiple bash
PROMPT_COMMAND='history -a; history -n'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias reload="source $HOME/.bashrc"
alias .r=reload

# common components
[ -f $HOME/.config/shell/function.sh ] && source $HOME/.config/shell/function.sh
[ -f $HOME/.config/shell/alias.sh ] && source $HOME/.config/shell/alias.sh

export PATH=$HOME/.local/bin:$PATH

