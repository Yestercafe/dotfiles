# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  #source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone --depth=1 https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
            print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode depth"1" for \
      zdharma-continuum/zinit-annex-as-monitor \
      zdharma-continuum/zinit-annex-bin-gem-node \
      zdharma-continuum/zinit-annex-patch-dl \
      zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Oh My Zsh
zinit for \
      OMZL::correction.zsh \
      OMZL::directories.zsh \
      OMZL::history.zsh \
      OMZL::key-bindings.zsh \
      OMZL::theme-and-appearance.zsh

zinit wait lucid for \
      OMZP::common-aliases \
      OMZP::colored-man-pages \
      OMZP::extract \
      OMZP::fancy-ctrl-z \
      OMZP::git \
      OMZP::sudo \
      OMZP::brew \
      OMZP::vscode \
      OMZP::iterm2 \
      OMZP::dash

# theme
zinit snippet OMZL::git.zsh
#source /Users/ivan/repos/based-on-default-zsh-theme/bod.zsh-theme
#zinit light Yescafe/based-on-default-zsh-theme
zinit snippet OMZT::lambda
#zinit light Moarram/headline
#zinit light joshjon/bliss-zsh
#zinit light denysdovhan/spaceship-zsh-theme
# powerlevel10k here:
#zinit ice depth=2; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# functions
mkcd() {
    mkdir -p "$@" && cd "$_";
}

nh () {
    nohup $* > /dev/null &
}

function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# thefuck
eval $(thefuck --alias)

# aliases
## basic
alias mcd=mkcd
alias q=$EDITOR
alias v=vim
alias n=nvim
alias e='nh emacs'
alias ec='nh emacsclient -a "" -c'
## zsh
alias zsh_config="q ~/.zshrc"
alias zsh_redeploy="source ~/.zshrc"
## git
alias gdh="git diff HEAD"
alias gdh1="git diff HEAD~1"
## gcc
alias gcc="gcc-13"
alias g++="g++-13"
alias gpp="g++"
alias gc9="gcc -std=c99"
alias gc1="gcc -std=c11"
alias gc7="gcc -std=c17"
alias gp3="g++ -std=c++03"
alias gp1="g++ -std=c++11"
alias gp4="g++ -std=c++14"
alias gp7="g++ -std=c++17"
alias gp20="g++ -std=c++20"
## clang
alias lcc="clang"
alias lpp="clang++"
alias lc9="clang -std=c99"
alias lc1="clang -std=c11"
alias lc7="clang -std=c17"
alias lp3="clang++ -std=c++03"
alias lp1="clang++ -std=c++11"
alias lp4="clang++ -std=c++14"
alias lp7="clang++ -std=c++17"
alias lp2a="clang++ -std=c++2a"
alias lp20="clang++ -std=c++20"   # LLVM12

alias rr='cd `randfile`'

tn () {
  if [ "$#" -eq 0 ]; then
    tmux new
  else
    tmux new -s $*
  fi
}

ta () {
  if [ "$#" -eq 0 ]; then
    tmux a
  else
    tmux a -t $*
  fi
}

# Prettify ls if there is gls
if (( $+commands[gls] )); then
    alias ls='gls --color=tty --group-directories-first'
else
    alias ls='ls --color=tty --group-directories-first'
fi
alias ll="ls -l"
alias la="ls -la"
alias tm=$HOME/.dotfiles/bin/trash

command -v btm >/dev/null 2>&1 && alias top=btm

## cms-git-tools
export PATH=/Users/ivan/.dotfiles/cms-git-tools:$PATH

# Completion enhancements
zinit wait lucid depth"1" for \
      atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
      blockf \
      zsh-users/zsh-completions \
      atload"!_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions

zinit wait lucid light-mode depth"1" for \
      zsh-users/zsh-history-substring-search \
      agkozak/zsh-z

# Git extras
zinit ice wait lucid as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX"
zinit light tj/git-extras

# Lazygit
zinit ice wait lucid as"program" from"gh-r" sbin atload"alias lg=lazygit"
zinit light jesseduffield/lazygit

# Homebrew completion
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# Modern Unix commands
# See https://github.com/ibraheemdev/modern-unix
zinit wait lucid as"null" from"gh-r" for \
      atload"alias ls='exa --color=auto --group-directories-first'; alias la='ls -laFh'; alias ll='ls -lFh'" cp"**/exa.1 -> $ZPFX/share/man/man1" mv"**/exa.zsh -> $ZINIT[COMPLETIONS_DIR]/_exa" sbin"**/exa" if'[[ $OSTYPE != linux* && $CPUTYPE != aarch* ]]' ogham/exa \
      atload"alias cat='bat -p --wrap character'" mv"**/bat.1 -> $ZPFX/share/man/man1" cp"**/autocomplete/bat.zsh -> $ZINIT[COMPLETIONS_DIR]/_bat" sbin"**/bat" @sharkdp/bat \
      mv"**/fd.1 -> $ZPFX/share/man/man1" cp"**/autocomplete/_fd -> $ZINIT[COMPLETIONS_DIR]" sbin"**/fd" @sharkdp/fd \
      mv"**/hyperfine.1 -> $ZPFX/share/man/man1" cp"**/autocomplete/_hyperfine -> $ZINIT[COMPLETIONS_DIR]" sbin"**/hyperfine" @sharkdp/hyperfine \
      cp"**/completion/_btm -> $ZINIT[COMPLETIONS_DIR]" atload"alias top=btm" sbin ClementTsang/bottom \
      atload"alias help=cheat" mv"cheat* -> cheat" sbin cheat/cheat \
      atload"alias diff=delta" sbin"**/delta" dandavison/delta \
      atload"unalias duf; alias df=duf" bpick"*(.zip|tar.gz)" sbin muesli/duf \
      atload"alias du=dust" sbin"**/dust" bootandy/dust \
      atload"alias ping=gping" sbin orf/gping \
      bpick"*.zip" sbin if'[[ $OSTYPE != linux* && $CPUTYPE != aarch* ]]' dalance/procs

# NOTE: DO NOT use sbin/fbin and lucid since it's incompatible with magit-todos
zinit ice as"program" from"gh-r"
zinit light microsoft/ripgrep-prebuilt

zinit ice wait lucid as"null" from"gh-r" cp"**/doc/rg.1 -> $ZPFX/share/man/man1" mv"**/complete/_rg -> $ZINIT[COMPLETIOS_DIR]"
zinit light BurntSushi/ripgrep

# FZF: fuzzy finder
zinit ice wait lucid from"gh-r" nocompile src'key-bindings.zsh' sbin \
      dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> _fzf_completion;
         https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh;
         https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1 -> $ZPFX/share/man/man1/fzf-tmux.1;
         https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> $ZPFX/share/man/man1/fzf.1'
zinit light junegunn/fzf

zinit ice wait lucid depth"1" atload"zicompinit; zicdreplay" blockf
zinit light Aloxaf/fzf-tab

zstyle ':fzf-tab:*' switch-group ',' '.'

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:complete:(cd|ls|exa|bat|cat|emacs|nano|vi|vim):*' fzf-preview 'exa -1 --color=always $realpath 2>/dev/null|| ls -1 --color=always $realpath'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	   fzf-preview 'echo ${(P)word}'

# Preivew `kill` and `ps` commands
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
       '[[ $group == "[process ID]" ]] &&
        if [[ $OSTYPE == darwin* ]]; then
           ps -p $word -o comm="" -w -w
        elif [[ $OSTYPE == linux* ]]; then
           ps --pid=$word -o cmd --no-headers -w -w
        fi'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Preivew `git` commands
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	   'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	   'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	   'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	   'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	   'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# Privew help
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD || rg --files --hidden --follow --glob '!.git' || find ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --border'
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} || cat {} || tree -NC {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --exact"
export FZF_ALT_C_OPTS="--preview 'tree -NC {} | head -200'"

# GIT heart FZF
# @see https://junegunn.kr/2016/07/fzf-git/
is_in_git_repo() {
    git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
    fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

_gf() {
    is_in_git_repo || return
    git -c color.status=always status --short |
        fzf-down -m --ansi --nth 2..,.. \
                 --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
        cut -c4- | sed 's/.* -> //'
}

_gb() {
    is_in_git_repo || return
    git branch -a --color=always | grep -v '/HEAD\s' | sort |
        fzf-down --ansi --multi --tac --preview-window right:70% \
                 --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
        sed 's/^..//' | cut -d' ' -f1 |
        sed 's#^remotes/##'
}

_gt() {
    is_in_git_repo || return
    git tag --sort -version:refname |
        fzf-down --multi --preview-window right:70% \
                 --preview 'git show --color=always {}'
}

_gh() {
    is_in_git_repo || return
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
        fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
                 --header 'Press CTRL-S to toggle sort' \
                 --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
        grep -o "[a-f0-9]\{7,\}"
}

_gr() {
    is_in_git_repo || return
    git remote -v | awk '{print $1 "\t" $2}' | uniq |
        fzf-down --tac \
                 --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
        cut -d$'\t' -f1
}

_gs() {
    is_in_git_repo || return
    git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
        cut -d: -f1
}

join-lines() {
    local item
    while read item; do
        echo -n "${(q)item} "
    done
}

() {
    local c
    for c in $@; do
        eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
        eval "zle -N fzf-g$c-widget"
        eval "bindkey '^g^$c' fzf-g$c-widget"
    done
} f b t r h s

# OS bundles
if [[ $OSTYPE == darwin* ]]; then
    zinit snippet PZTM::osx
    if (( $+commands[brew] )); then
        alias bu='brew update; brew upgrade'
        alias bcu='brew cu --all --yes --cleanup'
        alias bua='bu; bcu'
    fi
elif [[ $OSTYPE == linux* ]]; then
    if (( $+commands[apt-get] )); then
        zinit snippet OMZP::ubuntu
        alias agua='aguu -y && agar -y && aga -y'
        alias kclean+='sudo aptitude remove -P "?and(~i~nlinux-(ima|hea),\
                            ?not(?or(~n`uname -r | cut -d'\''-'\'' -f-2`,\
                            ~nlinux-generic,\
                            ~n(linux-(virtual|headers-virtual|headers-generic|image-virtual|image-generic|image-`dpkg --print-architecture`)))))"'
    elif (( $+commands[pacman] )); then
        zinit snippet OMZP::archlinux
    fi
fi

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
