#!/bin/bash

VERSION="v0.1.0"

stow_deploy() {
    stow -v .
}

stow_remove() {
    stow -vD .
}

install_stow() {
    # for Debian/Ubuntu
    if type apt >/dev/null 2>&1; then
        sudo apt install stow
    fi

    # for macOS
    if type brew >/dev/null 2>&1; then
        brew install stow
    fi
}

check_deps() {
    if ! type stow >/dev/null 2>&1; then
        install_stow
    fi


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
    echo -e "* deploy - Deploy dotfiles with stow"
    echo -e "* remove - Remove all dotfiles from user directory with stow"
    echo -e "* version - Show script version"
    echo -e "* help - Show help"
}

main() {
    check_deps
    if [[ "$#" == "0" ]]; then
        stow_deploy
    else
        if [[ "$1" == "deploy" ]]; then
            stow_deploy
        elif [[ "$1" == "remove" ]]; then
            stow_remove
        elif [[ "$1" == "version" ]]; then
            echo $VERSION
        elif [[ "$1" == "help" ]]; then
            print_help
            return 0
        fi
    fi

    return $?
}

main "$@"

