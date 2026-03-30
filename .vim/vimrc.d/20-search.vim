" Search & highlight (matches your ~/.vimrc habits)

set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

noremap n nzz
noremap N Nzz

" (s)earch lighting (c)lear
noremap <LEADER>sc :nohlsearch<CR>

" (t)oggle highlight co(l)umn81
let &colorcolumn=0
nnoremap <leader>tl :call ColorColumnToggle()<CR>

function! ColorColumnToggle()
  if &colorcolumn
    set colorcolumn=0
  else
    set colorcolumn=81,121
  endif
endfunction

