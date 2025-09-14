## If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Switch to control logging (set to 1 to enable, 0 to disable)
LOG_ENABLED=1

# Log file location
LOG_FILE="/tmp/bashrc.log"

# Function to log messages with a timestamp
log_message() {
    if [ $LOG_ENABLED -eq 1 ]; then
        local MESSAGE=$1
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] $MESSAGE" >> $LOG_FILE
    fi
}

# List of preferred editors in order
editors=(nvim vim nano)

# Attempt to set the editor based on availability
for editor in "${editors[@]}"; do
    if command -v "$editor" &> /dev/null; then
        export EDITOR="$editor"
        log_message "Using $editor as the default editor."
        break  # Exit the loop once a suitable editor is found
    else
        echo "$editor not found."
    fi
done

# Fallback message if no editor is found
if [[ -z "$EDITOR" ]]; then
    echo "No suitable editor found, please install one of the following editors:"
    for editor in "${editors[@]}"; do
        echo "- $editor"
    done
    # Set the first editor in the list as the fallback editor
    export EDITOR="${editors[0]}"  # Set the first editor (from the list) as the default
    echo "Setting ${editors[0]} as the default editor."
fi

[[ -f $HOME/.config/shell/pre-env.sh ]] && source $HOME/.config/shell/pre-env.sh

[[ -f /usr/share/blesh/ble.sh ]] && source /usr/share/blesh/ble.sh

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=10000

shopt -s histappend
shopt -s globstar
shopt -s checkwinsize
shopt -s autocd  
shopt -s expand_aliases

# Share history with multiple bash
PROMPT_COMMAND='history -a; history -n'

# Make less more friendly for non-text input files, see lesspipe(1)
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

# Common components
[ -f $HOME/.config/shell/function.sh ] && source $HOME/.config/shell/function.sh
[ -f $HOME/.config/shell/alias.sh ] && source $HOME/.config/shell/alias.sh

export PATH=$HOME/.local/bin:$PATH

# Attach ble.sh
[[ ${BLE_VERSION-} ]] && ble-attach

# archlinux: https://wiki.archlinux.org/title/Bash#Command_not_found
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && source /usr/share/doc/pkgfile/command-not-found.bash

