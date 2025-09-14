#!/bin/bash

VERSION="v0.1.0"
PROMPT_COLOR_RED="\033[31m"
PROMPT_COLOR_GREEN="\033[32m"
PROMPT_COLOR_UNSET="\033[0m"

log_success() {
    echo -en "${PROMPT_COLOR_GREEN}"
    echo -en $@
    echo -en "${PROMPT_COLOR_UNSET}"
    echo
}

log_failure() {
    echo -en "${PROMPT_COLOR_RED}"
    echo -en $@
    echo -en "${PROMPT_COLOR_UNSET}"
    echo
}

stow_deploy() {
    stow -v $@ .
    [[ "$?" != "0" ]] && log_failure "failed to execute stow, may be not installed, try \`./stow.sh install\`" || true
}

stow_remove() {
    stow -vD .
    [[ "$?" != "0" ]] && log_failure "failed to execute stow, may be not installed, try \`./stow.sh install\`" || true
}

stow_install() {
    if type stow >/dev/null 2>&1; then
        log_success "stow is already installed"
        return 0
    fi

    # for Debian/Ubuntu
    if type apt >/dev/null 2>&1; then
        log_success "apt exists, try to install stow"
        set -x
        sudo apt install stow
        set +x
    else
        log_failure "apt not exists, not Debian/Ubuntu"
    fi

    # for macOS
    if type brew >/dev/null 2>&1; then
        log_success "brew exists, try to install stow"
        set -x
        brew install stow
        set +x
    else
        log_failure "brew not exists, not macOS"
    fi

    # for archlinux
    if type pacman >/dev/null 2>&1; then
        log_success "pacman exists, try to install stow"
        set -x
        sudo pacman -S stow
        set +x
    else
        log_failure "pacman not exists, not archlinux"
    fi

    # for RHEL/Fedora
    if type yum >/dev/null 2>&1; then
        log_success "yum exists, try to install stow"
        set -x
        sudo yum install stow
        set +x
    else
        log_failure "yum not exists, not RHEL/Fedora"
    fi

    if ! type stow >/dev/null 2>&1; then
        log_failure "failed to install stow"
        return -1
    fi

    return 0
}

stow_backup_exists() {
    local cfe
    cfe=$(stow -vn . 2>&1 | grep target | sed -n 's/.*target \([^ ]*\).*/\1/p')
    for cf in $cfe; do
        mv -v $HOME/$cf $HOME/$cf~
    done
}

print_help() {
    echo -e "## VERSION"
    echo -e "* $0: $VERSION"
    if ! type stow >/dev/null 2>&1; then
        echo "* stow: not installed"
    else
        echo "* stow: $(stow --version)"
    fi
    echo

    echo -e "## HELP"
    echo -e "* install - Install stow"
    echo -e "* deploy - Deploy dotfiles with stow"
    echo -e "* simulate - Simulate to deploy dotfiles with stow"
    echo -e "* backup - Backup config files exists"
    echo -e "* remove - Remove all dotfiles from user directory with stow"
    echo -e "* version - Show script version"
    echo -e "* help - Show help"
}

main() {
    if [[ "$#" == "0" ]]; then
        print_help
    else
        if [[ "$1" == "install" ]]; then
            stow_install
        elif [[ "$1" == "deploy" ]]; then
            stow_deploy
        elif [[ "$1" == "simulate" ]]; then
            stow_deploy -n
        elif [[ "$1" == "backup" ]]; then
            stow_backup_exists
        elif [[ "$1" == "remove" ]]; then
            stow_remove
        elif [[ "$1" == "version" ]]; then
            echo $VERSION
        elif [[ "$1" == "help" ]]; then
            print_help
            return 0
        else
            log_failure "arg 1 \`$1\` is invalid"
            print_help
        fi
    fi

    return $?
}

main "$@"

