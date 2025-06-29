rr() {
    urandom_str=$(head -c 4 /dev/urandom | xxd -p | tr -d '\n')
    if [[ "$#" == "0" ]]; then
        mkdir -p "$urandom_str"
        echo "Create a dir named \`$urandom_str\`"
    else
        pattern=$1
        file_name="${pattern/\{\}/$urandom_str}"
        touch "$file_name"
        echo "Touch a file named \`$file_name\`"
    fi
}

