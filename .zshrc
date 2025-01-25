# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' frequency 30

plugins=(git z colored-man-pages sudo fancy-ctrl-z zsh-syntax-highlighting zsh-autosuggestions fzf)

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim

# proxies
export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897

# Node.js
export PATH=/Users/ivan/opt/node-v20.18.0-darwin-arm64/bin:$PATH

# Rust
. "$HOME/.cargo/env"

# Golang
export PATH=/Users/ivan/opt/go1.23.2/bin:$PATH

# Miniconda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ivan/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ivan/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ivan/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ivan/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# RVM
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Jetbrains toolbox
export PATH="/Users/ivan/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"

# gcc
export LDFLAGS="-L/usr/local/lib"
export CPPFLAGS="-I/usr/local/include"

# GNU find
export PATH=$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH

# ctags
export PATH=/opt/homebrew/Cellar/ctags/5.8_2/bin/:$PATH

# local bin
export PATH=$HOME/.local/bin:$PATH

# aliases
alias reload="source $HOME/.zshrc"
alias zed="open -a /Applications/Zed.app"
alias gcc=gcc-14
alias g++=g++-14

alias rr=rustrover
alias cl=clion
alias nv=neovide
alias q=nv
alias lg=lazygit

# functions
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }
function mkcd() { mkdir -p "$@" && cd "$_" }

# doom emacs
export PATH=$HOME/.config/emacs/bin:$PATH

# lean 4
source $HOME/.elan/env

# moonbit
export PATH="$HOME/.moon/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


[ -f "/Users/ivan/.ghcup/env" ] && . "/Users/ivan/.ghcup/env" # ghcup-env


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.
