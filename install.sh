#!/bin/sh
DOTFILES=$HOME/.dotfiles
ZINIT_PATH=$HOME/.zinit
VIM_PATH=$HOME/.vim
PROXY_PORT=7890
ALACRITTY_PATH=$HOME/.config/alacritty
KITTY_PATH=$HOME/.config/kitty
WEZTERM_PATH=$HOME/.config/wezterm

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

is_fedora() {
    command -v dnf > /dev/null 2>&1
}

install_package() {
    if ! command -v ${1} > /dev/null 2>&1; then
        if is_mac; then
            brew install ${1}
        elif is_debian; then
            sudo apt install -y ${1}
        elif is_arch; then
            sudo pacman -S --noconfirm ${1}
        elif is_fedora; then
            sudo dnf install -y ${1}
        fi
    else
        if is_mac; then
            brew upgrade ${1}
        elif is_debian; then
            sudo apt upgrade -y ${1}
        elif is_arch; then
            sudo pacman -S --noconfirm ${1}
        elif is_fedora; then
            sudo dnf install -y ${1}
        fi
    fi
}

clean_dotfiles() {
    echo "- Clean files"
    files="
    .zinit
    .zshenv
    .zshrc
    .zshrc.local
    .gitconfig
    .vim
    .vimrc
    .gvimrc
    .ideavimrc
    .tmux
    .tmux.conf
    .tmux.conf.local
    .condarc
    .irbrc
    .bashrc
    "

    backup_path="bak-$(date +%s)"
    mkdir -p $DOTFILES/$backup_path
    for f in $files; do
        if [ -f $HOME/$f ] || [ -d $HOME/$f ] || [ -h $HOME/$f ]; then
            mv $HOME/$f $DOTFILES/$backup_path/$f
        fi
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
    echo "- Clone dotfiles repo"
    rm -rf $DOTFILES
    git clone --recursive https://github.com/Yescafe/dotfiles.git $DOTFILES
}

install_zinit() {
    echo "- Install zinit"
    if ! command -v zinit > /dev/null 2>&1; then
        sh -c "$(curl -fsSL https://git.io/zinit-install)"
    fi
}

iterm_support() {
    echo "- Install iTerm2 tools"
    UTILITIES=(imgcat imgls it2api it2attention it2check it2copy it2dl it2getvar it2git it2setcolor it2setkeylabel it2tip it2ul it2universion it2profile)
    for U in "${UTILITIES[@]}"
    do
        echo "Downloading $U..."
        curl -SsL "https://iterm2.com/utilities/$U" > "$DOTDIR/.iterm2/$U" && chmod +x "$DOTDIR/.iterm2/$U"
    done
}

done_dotfiles() {
    echo "- Link files"
    ln -sf $DOTFILES/.zshenv $HOME/.zshenv
    ln -sf $DOTFILES/.zshrc $HOME/.zshrc
    ln -sf $DOTFILES/.bashrc $HOME/.bashrc
    if is_mac; then
        ln -sf $DOTFILES/.zshrc.macos.local $HOME/.zshrc.local
    fi

    PATH=$DOTFILES/cms-git-tools:$PATH
    cp $DOTFILES/.gitconfig_macos $HOME/.gitconfig

    git clone --recursive https://github.com/Yescafe/vim.git $HOME/.vim
    ln -sf $DOTFILES/.gvimrc $HOME/.gvimrc
    cp $DOTFILES/.ideavimrc $HOME/.ideavimrc

    # install TPM
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ln -sf ./.tmux.conf $HOME/.tmux.conf

    ln -sf $DOTFILES/.condarc $HOME/.condarc
    ln -sf $DOTFILES/.irbrc $HOME/.irbrc

    mkdir -p $ALACRITTY_PATH
    ln -sf $DOTFILES/alacritty.yml $ALACRITTY_PATH/alacritty.yml
    mkdir -p $WEZTERM_PATH
    ln -sf $DOTFILES/wezterm.lua $WEZTERM_PATH/wezterm.lua
    mkdir -p $KITTY_PATH
    ln -sf $DOTFILES/kitty.conf $KITTY_PATH/kitty.conf

    echo "- Done!"
}

main() {
    sudo -v
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    set_proxy

    if [ -d $ZINIT_PATH ] || [ -d $TMUX_PATH ] || [ -d $VIM_PATH ]; then
        promote_yn "Do you want to reset all configurations and continue?" "choice"
        if [ $choice -eq $YES ]; then
            install_requirements
            install_dotfiles
            clean_dotfiles
            install_zinit
            done_dotfiles
        else
            exit
        fi
    else
        install_requirements
        install_dotfiles
        clean_dotfiles
        install_zinit
        if is_mac; then
            iterm_support
        fi
        done_dotfiles
    fi
}

main
