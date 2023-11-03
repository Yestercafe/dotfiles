export LANG="en_US.UTF-8"
export DEFAULT_USER=$USER
export EDITOR=nvim

# HTTP proxy
export socks_hostport=10808
export http_hostport=10809
if [ -z "$WSL_DISTRO_NAME" ]; then
    export hostip="127.0.0.1"
else
    export hostip=$(ip route | grep default | awk '{print $3}')
fi

export https_proxy=http://$hostip:$http_hostport http_proxy=http://$hostip:$http_hostport all_proxy=socks5://$hostip:$socks_hostport

[ -f $HOME/.zshenv.local ] && source $HOME/.zshenv.local

