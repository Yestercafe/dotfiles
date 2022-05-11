DOTFILES=$HOME/.dotfiles
export LANG="en_US.UTF-8"
export TERM=xterm-256color
export DEFAULT_USER=$USER
export EDITOR=vim
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

# user scripts
export PATH=$HOME/.local/bin:$DOTFILES/bin:/usr/local/bin:/usr/local/sbin:$PATH

# nano
export PATH=/usr/local/Cellar/nano/6.3/bin:$PATH

# RVM
export PATH="$PATH:$HOME/.rvm/bin"

# cargo
export PATH="$HOME/.cargo/bin:$PATH"

# MySQL
export PATH=/usr/local/mysql/bin:$PATH

# Python binary files
export PATH=/Users/ivan/Library/Python/3.9/bin:$PATH

# LLVM
export PATH=/usr/local/opt/llvm/bin:$PATH

# GCC/Clang/Makefile/CMake
export PATH=/usr/local/opt/riscv-gnu-toolchain/bin:$PATH
export PATH=/usr/local/Cellar/i386-jos-elf-gcc/4.6.1/bin:/usr/local/Cellar/i386-jos-elf-binutils/2.21.1/bin:/usr/local/Cellar/i386-jos-elf-gdb/7.3.1/bin:$PATH
export LDFLAGS="-L/usr/local/lib"
export CPPFLAGS="-I/usr/local/include"

# JDK
export PATH=$HOME/opt/jdk-16.0.2.jdk/Contents/Home/bin:$PATH

# Doom Emacs
export PATH=$HOME/.emacs.d/bin:$PATH
