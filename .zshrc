# Basics
## environment
export WORDCHARS="*?"
export DOTFILES_PATH=$HOME/.dotfiles
export EDITOR=nvim

## PATH
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
    zdharma-continuum/zinit-annex-patch-dl

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
   OMZP::git

zi wait'0a' lucid for \
   OMZP::colored-man-pages \
   OMZP::extract \
   OMZP::fancy-ctrl-z \
   OMZP::sudo \
   OMZP::z

## theme
ZSH_THEME="starship"
zi cdclear -q
setopt promptsubst
# zi snippet OMZT::robbyrussell
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

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
zi lucid wait'0a' depth"1" for \
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
    atload"alias ls='exa --color=auto --group-directories-first';alias l='exa -lt modified'" mv"**/exa.1 -> $ZPFX/man/man1" cp"**/exa.zsh -> $ZINIT[COMPLETIONS_DIR]/_exa" completions lbin"!**/exa" ogham/exa \
    atload"alias cat='bat -p --wrap character'" mv"**/bat.1 -> $ZPFX/man/man1" cp"**/autocomplete/bat.zsh -> $ZINIT[COMPLETIONS_DIR]/_bat" completions lbin"!**/bat" @sharkdp/bat \
    mv"**/fd.1 -> $ZPFX/man/man1" cp"**/autocomplete/_fd -> $ZINIT[COMPLETIONS_DIR]" completions lbin"!**/fd" @sharkdp/fd \
    atload"alias dlt=delta" lbin"!**/delta" dandavison/delta \
    atload"alias du=dust" dl'https://raw.githubusercontent.com/bootandy/dust/master/man-page/dust.1 -> $ZPFX/man/man1/dust.1;https://raw.githubusercontent.com/bootandy/dust/master/completions/_dust -> $ZINIT[COMPLETIONS_DIR]/_dust' completions lbin"!**/dust" bootandy/dust \
    atload"alias df=\\duf" dl'https://raw.githubusercontent.com/muesli/duf/master/duf.1 -> $ZPFX/man/man1/duf.1' lbin"!**/duf" muesli/duf \
    atload"alias top=btm" cp"**/completion/_btm -> $ZINIT[COMPLETIONS_DIR]" lbin"!**/btm" ClementTsang/bottom \
    atload"alias hf=hyperfine" lbin"!**/hyperfine" @sharkdp/hyperfine \
    atload"alias ping=gping" lbin"!**/gping" orf/gping \
    atload"alias prc=procs" lbin"!**/procs" dalance/procs \
    mv"**/rg.1 -> $ZPFX/man/man1" cp"**/complete/_rg -> $ZINIT[COMPLETIONS_DIR]" BurntSushi/ripgrep

#### NOTE: DO NOT use lbin or wait lucid
zi ice as"program" from"gh-r"
zi light microsoft/ripgrep-prebuilt

### fzf
zi ice wait lucid from"gh-r" nocompile src'key-bindings.zsh' lbin"!fzf" \
    dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> $ZINIT[COMPLETIONS_DIR]/_fzf_completion;
       https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh;
       https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1 -> $ZPFX/man/man1/fzf-tmux.1;
       https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> $ZPFX/man/man1/fzf.1'
zi light junegunn/fzf

zi ice wait lucid depth"1" atload"zicompinit; zicdreplay" blockf
zi light Aloxaf/fzf-tab

# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' switch-group '[' ']'
zstyle ':fzf-tab:*' fzf-pad 4
zstyle ':fzf-tab:*' fzf-min-height 8
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:*' fzf-preview 'file-content ${(Q)realpath}'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	   fzf-preview

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD || rg --files --hidden --follow --glob '!.git' || find ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--border'

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

alias proxy='
    export http_proxy="http://${hostip}:${http_hostport}"
    export https_proxy="http://${hostip}:${http_hostport}"
    export all_proxy="socks5://${hostip}:${socks_hostport}"
'
alias unproxy='
    unset http_proxy
    unset https_proxy
    unset all_proxy
'
alias echoproxy='
    echo "http_proxy  = $http_proxy"
    echo "https_proxy = $https_proxy"
    echo "all_proxy   = $all_proxy"
'

### some from omz common-aliases
alias grep='grep --color'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

