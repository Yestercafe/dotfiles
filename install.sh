#!/bin/sh
DOTFILES=$HOME/.dotfiles
TMUX_PATH=$HOME/.tmux
ZINIT_PATH=$HOME/.zinit
VIM_PATH=$HOME/.vim
PROXY_PORT=7890

OS=$(uname -s)

if command -v tput > /dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

is_mac()
{
    [ "$OS" = "Darwin" ]
}

is_linux()
{
    [ "$OS" = "Linux" ]
}

is_debian() {
    command -v apt-get > /dev/null 2>&1
}

is_arch() {
    command -v yay > /dev/null 2>&1 || command -v pacman > /dev/null 2>&1
}

install_package() {
    if ! command -v ${1} > /dev/null 2>&1; then
        if is_mac; then
            brew install ${1}
        elif is_debian; then
            apt install -y ${1}
        elif is_arch; then
            pacman -S --noconfirm ${1}
        fi
    else
        if is_mac; then
            brew upgrade ${1}
        elif is_debian; then
            apt upgrade -y ${1}
        elif is_arch; then
            pacman -S --noconfirm ${1}
        fi
    fi
}

clean_dotfiles() {
    echo "- Clean files"
    files="
    .dotfiles
    .zinit
    .zshenv
    .zshrc
    .zshrc.local
    .gitconfig
    .vim
    .vimrc
    .tmux
    .tmux.conf
    .tmux.conf.local
    .condarc
    .irbrc
    .ideavimrc
    "

    backup_path="bak-$(date +%s)"
    for f in $files; do
        [ -f $HOME/$f ] && mv $HOME/$f $HOME/$backup_path/$f
    done
}

YES=1
NO=0
promote_yn() {
    eval ${2}=$NO
    read -p "$1 [y/N]: " yn
    case $yn in
        [Yy]* )    eval ${2}=$YES;;
        [Nn]*|'' ) eval ${2}=$NO;;
        *)         eval ${2}=$NO;;
    esac
}

set_proxy() {
    https_proxy=http://127.0.0.1:$PROXY_PORT
    http_proxy=http://127.0.0.1:$PROXY_PORT
    all_proxy=socks5://127.0.0.1:$PROXY_PORT
}

reset_confirm() {
    if [ -d $ZINIT_PATH ] || [ -d $TMUX_PATH ] || [ -d $VIM_PATH ]; then
        promote_yn "Do you want to reset all configurations and continue?" "choice"
        if [ $choice -eq $YES ]; then
            clean_dotfiles
        fi
    fi
}

install_requirements() {
    if is_mac && ! command -v brew > /dev/null 2>&1; then
        echo "- Install Homebrew"
        /bin/bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/Homebrew/install@HEAD/install.sh)"
    fi

    reqs="
    git
    curl
    wget
    zsh
    "
    for r in $reqs; do
        if ! command -v $r > /dev/null 2>&1; then
            echo "- Install $r"
            install_package $r
        fi
    done
}

install_dotfiles() {
    git clone --recursive https://github.com/Yescafe/dotfiles.git $DOTFILES
}

install_zinit() {
    echo "- Install zinit"
    if ! command -v zinit > /dev/null 2>&1; then
        sh -c "$(curl -fsSL https://git.io/zinit-install)"
    fi
}

done_dotfiles() {
    echo "- Link files"
    ln -sf $DOTFILES/.zshenv $HOME/.zshenv
    ln -sf $DOTFILES/.zshrc $HOME/.zshrc
    if is_mac; then
        ln -sf $DOTFILES/.zshrc.macos.local $HOME/.zshrc.local
    fi

    PATH=$DOTFILES/cms-git-tools:$PATH
    cp $DOTFILES/.gitconfig $HOME/.gitconfig

    git clone --recursive https://github.com/Yescafe/vim.git $HOME/.vim

    git clone https://github.com/gpakosz/.tmux.git $TMUX_PATH
    ln -sf $TMUX_PATH/.tmux.conf $HOME/.tmux.conf
    cp $DOTFILES/.tmux.conf.local $HOME/.tmux.conf.local

    ln -sf $DOTFILES/.condarc $HOME/.condarc
    ln -sf $DOTFILES/.irbrc $HOME/.irbrc

    cp $DOTFILES/.ideavimrc $HOME/.ideavimrc
    echo "- Done!"
}

main() {
    set_proxy
    reset_confirm
    install_requirements
    install_zinit
    done_dotfiles
}

main
