" Neovim entrypoint: source the shared Vim config beside this file.
let s:here = expand('<sfile>:p:h')
execute 'source ' . fnameescape(s:here . '/vimrc')

