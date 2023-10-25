# Basics
## environment
export LANG="en_US.UTF-8"
export WORDCHARS="*?"
export DOTFILES_PATH=$HOME/.dotfiles
export EDITOR=nvim

## init zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

## zinit annexes
zi light-mode depth"1" for \
    zdharma-continuum/zinit-annex-binary-symlink \
    zdharma-continuum/zinit-annex-bin-gem-node

## oh-my-zsh components
### libraries
zi for \
   OMZL::correction.zsh \
   OMZL::history.zsh \
   OMZL::git.zsh \
   OMZL::key-bindings.zsh \
   OMZL::theme-and-appearance.zsh

### plugins
zi for \
   OMZP::common-aliases \
   OMZP::git

zi wait'0a' lucid for \
   OMZP::colored-man-pages \
   OMZP::extract \
   OMZP::fancy-ctrl-z \
   OMZP::sudo \
   OMZP::z

## theme
ZSH_THEME="robbyrussell"
zi cdclear -q
setopt promptsubst
zi snippet OMZT::robbyrussell

## completion enhancements
zi light-mode wait lucid depth"1" for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    blockf \
    zdharma-continuum/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-history-substring-search

### git extras
zi lucid wait'0a' for \
    as"null" src"etc/git-extras-completion.zsh" lbin="!bin/git-*" tj/git-extras

### Homebrew completion
if command -v brew >/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

## CLI tools
### https://github.com/ibraheemdev/modern-unix
zi light-mode wait lucid as"null" from"gh-r" for \
    atload"alias lg=lazygit" lbin"!**/lazygit" jesseduffield/lazygit \
    atload"alias ls=exa --color=auto --group-directories-first" mv"**/exa.1 -> $ZPFX/man/man1" cp"**/exa.zsh -> $ZINIT[COMPLETIONS_DIR]/_exa" completions lbin"!**/exa" ogham/exa \
    atload"alias cat='bat -p --wrap character'" mv"**/bat.1 -> $ZPFX/man/man1" cp"**/autocomplete/bat.zsh -> $ZINIT[COMPLETIONS_DIR]/_bat" completions lbin"!**/bat" @sharkdp/bat \
    mv"**/fd.1 -> $ZPFX/man/man1" cp"**/autocomplete/_fd -> $ZINIT[COMPLETIONS_DIR]" completions lbin"!**/fd" @sharkdp/fd \
    atload"alias dlt=delta" lbin"!**/delta" dandavison/delta \
    atload"alias du=dust" mv"**/dust.1 -> $ZPFX/man/man1" cp"**/completions/_dust -> $ZINIT[COMPLETIONS_DIR]" completions lbin"!**/dust" bootandy/dust \
    atload"alias df=\\duf" mv"**/duf.1 -> $ZPFX/man/man1" lbin"!**/duf" muesli/duf \
    atload"alias top=btm" cp"**/completion/_btm -> $ZINIT[COMPLETIONS_DIR]" lbin"!**/btm" ClementTsang/bottom \
    atload"alias hf=hyperfine" lbin"!**/hyperfine" @sharkdp/hyperfine \
    atload"alias ping=gping" lbin"!**/gping" orf/gping \
    atload"alias prc=procs" lbin"!**/procs" dalance/procs

# Customs
## utils
### thefuck
command -v thefuck > /dev/null && eval $(thefuck --alias)

### preset `ls`
if (( $+commands[gls] )); then
    alias ls='gls -hF --color=tty --group-directories-first'
else
    alias ls='ls -hF --color=tty --group-directories-first'
fi

### prepend to PATH
function prepend_path() {
    export PATH=$1:$PATH
}

## paths
prepend_path $HOME/bin
prepend_path $HOME/.bin
prepend_path $HOME/.local/bin
prepend_path $DOTFILES_PATH/bin
prepend_path $DOTFILES_PATH/cms-git-tools

## command-like functions
function mcd() {
    mkdir -p "$@" && cd "$_";
}

### TODO: maybe not work
function nh() {
    nohup $* > /dev/null &
}

function tn() {
  if [ "$#" -eq 0 ]; then
    tmux new
  else
    tmux new -s $*
  fi
}

function ta() {
  if [ "$#" -eq 0 ]; then
    tmux a
  else
    tmux a -t $*
  fi
}

function rr() {
    cd $(randfile)
}

function f() {
    find . -iname "*$1*" ${@:2}
}

function r() {
    grep "$1" ${@:2} -R .
}

## aliases
alias q=$EDITOR

### git
alias gdh="git diff HEAD"
alias gdh1="git diff HEAD~1"

### tmux
alias tls="tmux ls"

alias ll="ls -l"
alias la="ls -la"
alias l="ls -ltr"

alias tm=trash

