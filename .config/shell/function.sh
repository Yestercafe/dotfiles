ic_get_random_string() {
    if [[ "$#" == "0" ]]; then
        head -c 4 /dev/urandom | xxd -p | tr -d '\n'
    else
        head -c $1 /dev/urandom | xxd -p | tr -d '\n'
    fi
}

ic_mkdircd() {
    mkdir -p $1 && cd $1
}

ic_make_tmp_dir() {
    mkdir -vp /tmp/$(ic_get_random_string)
}

ic_make_tmp_file() {
    local extension="$1"
    local dst="$2"
    if [[ -z $extension ]]; then
        echo "Usage: $0 extension [dst]"
        return -1
    fi
    if [[ -z $dst ]]; then
        dst_file="/tmp/$(ic_get_random_string).${extension}"
    else
        dst_file="${dst}/$(ic_get_random_string).${extension}"
    fi
    touch "$dst_file"
    local ret=$?
    echo -n "$dst_file"
    return $ret
}

ic_make_tmp_dir_and_cd() {
    local tmp_dir=$(ic_make_tmp_dir)
    cd ${tmp_dir}
}

ic_persist_file_or_dir() {
    local dst="$HOME/.persistence"
    mkdir -p "${dst}"
    local this_dir="$PWD"
    pushd "${dst}"
    cp -rv "${this_dir}" "${dst}"
    popd
}

ic_backup_file_or_dir() {
    if [[ "$#" == 0 ]]; then
        echo "Usage: $0 [path]"
        return 0
    else
        if [[ -e "$1" ]]; then
            cp -rv "$1" "$1~"
        else
            echo "$1 not exists"
        fi
        return $?
    fi
}

ic_yank_to_clipboard() {
    local os="$(uname)"
    if [[ "$os" == "Darwin" ]]; then
        pbcopy
    fi
}

