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

" fzf.vim depends on junegunn/fzf (fzf#run).
function! s:FzfReady() abort
  return exists('*fzf#run')
endfunction

function! s:FzfOrWarn(cmd) abort
  if s:FzfReady()
    execute a:cmd
  else
    echohl WarningMsg
    echom "fzf not ready: install submodule junegunn/fzf and run its install script."
    echohl None
  endif
endfunction

function! s:GitTrackedSearch() abort
  if !s:FzfReady()
    echohl WarningMsg
    echom "fzf not ready: install submodule junegunn/fzf and run its install script."
    echohl None
    return
  endif

  call fzf#vim#grep(
        \ 'git grep --line-number -- ""',
        \ 1,
        \ fzf#vim#with_preview(),
        \ 0
        \ )
endfunction

" Plugin shortcuts (safe if plugin isn't loaded)
nnoremap <silent> <leader>fe :silent! NERDTreeToggle<CR>
nnoremap <silent> <leader><space> :call <SID>FzfOrWarn('Files')<CR>
nnoremap <silent> <leader>, :call <SID>FzfOrWarn('Buffers')<CR>
nnoremap <silent> <leader>sg :call <SID>GitTrackedSearch()<CR>
nnoremap <silent> <leader>/ :call <SID>FzfOrWarn('BLines')<CR>
nnoremap <silent> <leader>sG :call <SID>FzfOrWarn('Rg')<CR>

