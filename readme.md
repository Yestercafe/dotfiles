# Yestercafe's Dotfiles & UNIX Setups Manuals

- [Yestercafe's Dotfiles \& UNIX Setups Manuals](#yestercafes-dotfiles--unix-setups-manuals)
  - [Clone This Repo Manually](#clone-this-repo-manually)
  - [Install Some Parts Manually](#install-some-parts-manually)
    - [Shells](#shells)
      - [Bash](#bash)
      - [Zsh](#zsh)
    - [TUI Tools](#tui-tools)
      - [Homebrew, macOS](#homebrew-macos)
      - [tmux](#tmux)
      - [joshuto](#joshuto)
    - [Editors](#editors)
      - [Emacs](#emacs)
      - [NeoVim](#neovim)
      - [Vim, Deprecated](#vim-deprecated)
      - [IdeaVim](#ideavim)
    - [Terminal Emulators](#terminal-emulators)
      - [Alacritty](#alacritty)
      - [Kitty](#kitty)
      - [WezTerm](#wezterm)
      - [iTerm 2 \& iTerm 2 Integrations, macOS](#iterm-2--iterm-2-integrations-macos)
    - [Programming Languages](#programming-languages)
      - [Rust](#rust)
      - [Go](#go)
      - [Haskell (GHCup)](#haskell-ghcup)
      - [Anaconda and Python](#anaconda-and-python)
      - [Ruby](#ruby)

## Clone This Repo Manually

All instructions depend on git, you should install it before git cloneing:

```bash
## Fedora
sudo dnf install git
## Ubuntu
sudo apt install git
## macOS
xcode-select --install
### Optionally, you can install the latest git using Homebrew
#brew install git
```

```bash
## HTTPS protocol
git clone --depth 1 --recursive https:://github.com/Yestercafe/.dotfiles.git $HOME/.dotfiles
## SSH protocol
git clone --depth 1 --recursive git@github.com:Yestercafe/.dotfiles.git $HOME/.dotfiles
```


## Install Some Parts Manually

Firstly, define path `DOTFILES`:

```bash
DOTFILES=$HOME/.dotfiles
```

### Shells

#### Bash

```bash
mv $HOME/.bashrc $HOME/.bashrc.bak
ln -sf $DOTFILES/.bashrc $HOME/.bashrc
```

#### Zsh

Depend on `zinit` and `thefuck`, install them firstly.

```bash
## zinit
if ! command -v zinit > /dev/null 2>&1; then
    sh -c "$(curl -fsSL https://git.io/zinit-install)"
fi

## install thefuck, depend on Python3 and pip
python3 -m pip install thefuck   # need `sudo` possibly , or use
#python3 -m pip install thefuck --user   # directly
```

Then link zsh configs:

```bash
mv $HOME/.zshenv $HOME/.zshenv.bak
mv $HOME/.zshrc $HOME/.zshrc.bak
ln -sf $DOTFILES/.zshrc $HOME/.zshrc
ln -sf $DOTFILES/.zshenv $HOME/.zshenv
```

If this is a macOS machine, you can use this additional config for macOS optionally:

```bash
mv $HOME/.zshrc.local $HOME/.zshrc.local.bak
ln -sf $DOTFILES/.zshrc.macos.local $HOME/.zshrc.local
```


### TUI Tools

#### Homebrew, macOS

```bash
\bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/Homebrew/install@HEAD/install.sh)"
```

#### tmux

Depend on TPM:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then:

```bash
ln -sf $DOTFILES/.tmux.conf $HOME/.tmux.conf
```

#### joshuto

<https://github.com/kamiyaa/joshuto>


### Editors

#### Emacs

My Emacs config is called zero.emacs:

```bash
mv $HOME/.emacs $HOME/.emacs.bak
mv $HOME/.emacs.d $HOME/.emacs.d.bak
## HTTPS protocol
git clone https://github.com/Yestercafe/zero.emacs.git $HOME/.emacs.d
## SSH protocol
git clone git://github.com:Yestercafe/zero.emacs.git $HOME/.emacs.d
```

#### NeoVim

```bash
mv $HOME/.config/nvim $HOME/.config/nvim.bak
mkdir -p $HOME/.config
## HTTPS protocol
git clone https://github.com/Yestercafe/nvim.git $HOME/.config/nvim
## SSH protocol
git clone git://github.com:Yestercafe/nvim.git $HOME/.config/nvim
```

#### Vim, Deprecated

*This Vim config is deprecated, should use NeoVim config instead.*

```bash
mv $HOME/.vim $HOME/.vim.bak
mv $HOME/.vimrc $HOME/.vimrc.bak
## HTTPS protocol
git clone --depth 1 --recursive https://github.com/Yestercafe/vim.git $HOME/.vim
## SSH protocol
git clone --depth 1 --recursive git@github.com/Yestercafe/vim.git $HOME/.vim
```

#### IdeaVim

If you wanna use IdeaVim config, you should clone the deprecated Vim config firstly. And then:

```bash
mv $HOME/.ideavimrc $HOME/.ideavimrc.bak
ln -sf $DOTFILES/.ideavimrc $HOME/.ideavimrc
```


### Terminal Emulators

<https://github.com/alacritty/alacritty>

#### Alacritty

```bash
mkdir -p $HOME/.config/alacritty
mv $HOME/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml.bak
ln -sf $DOTFILES/alacritty.yml $HOME/.config/alacritty/alacritty.yml
```

#### Kitty

<https://sw.kovidgoyal.net/kitty/>

```bash
mkdir -p $HOME/.config/kitty
mv $HOME/.config/kitty/kitty.conf $HOME/.config/kitty/kitty.conf.bak
ln -sf $DOTFILES/kitty.conf $HOME/.config/kitty/kitty.conf
```

#### WezTerm

<https://wezfurlong.org/wezterm/>

```bashk
mkdir -p $HOME/.config/wezterm
mv $HOME/.config/wezterm/wezterm.lua $HOME/.config/wezterm/wezterm.lua.bak
ln -sf $DOTFILES/wezterm.lua $HOME/.config/wezterm/wezterm.lua
```

#### iTerm 2 & iTerm 2 Integrations, macOS

```bash
ITERM_UTILITIES=(imgcat imgls it2api it2attention it2check it2copy it2dl it2getvar it2git it2setcolor it2setkeylabel it2tip it2ul it2universion it2profile)
for U in "${ITERM_UTILITIES[@]}"; do
    echo "Downloading $U..."
    curl -SsL "https://iterm2.com/utilities/$U" > "$DOTDIR/.iterm2/$U" && chmod +x "$DOTDIR/.iterm2/$U"
done
```


### Programming Languages

#### Rust

<https://www.rust-lang.org/learn/get-started>

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

#### Go

<https://go.dev/dl/>

#### Haskell (GHCup)

<https://www.haskell.org/ghcup/>

```bash
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

#### Anaconda and Python

```bash
mv $HOME/.condarc $HOME/.condarc.bak
ln -sf $DOTFILES/.condarc $HOME/.condarc
```

#### Ruby

```bash
mv $HOME/.irbrc $HOME/.irbrc.bak
ln -sf $DOTFILES/.irbrc $HOME/.irbrc
```

