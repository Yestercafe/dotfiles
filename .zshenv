export LANG="en_US.UTF-8"
export DEFAULT_USER=$USER
export EDITOR=nvim

# HTTP proxy
## Windows v2rayN
export socks_hostport=10808
export http_hostport=10809
export hostip="127.0.0.1"
## WSL 2
if [ ! -z "$WSL_DISTRO_NAME" ]; then
    export hostip=$(ip route | grep default | awk '{print $3}')
fi
## macOS v2rayU
if [ ! -z "$(command -v sw_vers)" ]; then
    export socks_hostport=1080
    export http_hostport=1087
fi

export https_proxy=http://$hostip:$http_hostport http_proxy=http://$hostip:$http_hostport all_proxy=socks5://$hostip:$socks_hostport no_proxy='localhost,127.0.0.1,::1'

[ -f $HOME/.zshenv.local ] && source $HOME/.zshenv.local

