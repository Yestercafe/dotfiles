" Plugin loader integration (submodule vendors) + cross-platform packpath

" packages/packpath: automatically load plugins from pack/*/start/
let s:packroot = expand('~/.vim/pack')
execute 'set packpath^=' . fnameescape(s:packroot)

" Cross-platform persistent undo (works even if we keep swap/backup disabled)
let s:vimhome = expand('~/.vim')
call mkdir(s:vimhome . '/undo', 'p')
set undofile
execute 'set undodir=' . fnameescape(s:vimhome . '/undo//')

" Keep the workspace minimal (matches your ~/.vimrc)
set nobackup
set noswapfile

" Keep gitgutter stable
set signcolumn=yes

" Plugin shortcuts (safe if plugin isn't loaded)
nnoremap <silent> <leader>n :silent! NERDTreeToggle<CR>
nnoremap <silent> <leader>F :silent! Files<CR>

