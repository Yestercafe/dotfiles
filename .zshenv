export LANG="en_US.UTF-8"
export DEFAULT_USER=$USER
export EDITOR=nvim

# HTTP proxy
## Windows v2rayN
export socks_hostport=7890
export http_hostport=7890
export hostip="127.0.0.1"

export https_proxy=http://$hostip:$http_hostport http_proxy=http://$hostip:$http_hostport all_proxy=socks5://$hostip:$socks_hostport no_proxy='localhost,127.0.0.1,::1'

[ -f $HOME/.zshenv.local ] && source $HOME/.zshenv.local

# Hacks for Neovide wsl
export COLUMNS=80
export LINES=30

