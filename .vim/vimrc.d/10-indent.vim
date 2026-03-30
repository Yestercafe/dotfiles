" Indentation + tab width toggles (matches your ~/.vimrc habits)

function! SetTab2()
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  echo "Tab width set to 2"
endfunction

function! SetTab4()
  set tabstop=4
  set shiftwidth=4
  set softtabstop=4
  echo "Tab width set to 4"
endfunction

function! ToggleTabWidth()
  if &tabstop == 2
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    echo "Tab width set to 4"
  else
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    echo "Tab width set to 2"
  endif
endfunction

" (t)oggle (t)ab
nnoremap <leader>tt :call ToggleTabWidth()<CR>
map <leader>tT2 :call SetTab2()<CR>
map <leader>tT4 :call SetTab4()<CR>

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

