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

" Match airline palette with habamax-style UI.
let g:airline_theme = 'habamax'

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

function! s:BLinesWithPreview() abort
  if !s:FzfReady()
    echohl WarningMsg
    echom "fzf not ready: install submodule junegunn/fzf and run its install script."
    echohl None
    return
  endif
  call fzf#vim#buffer_lines('', fzf#vim#with_preview({'placeholder': '{2..}'}), 0)
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

function! s:CtagsBin() abort
  if executable('uctags')
    return 'uctags'
  endif
  if executable('ctags')
    return 'ctags'
  endif
  return ''
endfunction

function! s:CtagsReady() abort
  return !empty(s:CtagsBin())
endfunction

function! s:CtagsWarnMissing() abort
  echohl WarningMsg
  echom "ctags not found: install Universal Ctags (uctags/ctags) to enable :Tags and jump-to-definition."
  echohl None
endfunction

function! s:CtagsProjectRoot() abort
  if executable('git')
    let l:root = systemlist('git rev-parse --show-toplevel 2>/dev/null')
    if v:shell_error == 0 && !empty(l:root)
      return fnamemodify(l:root[0], ':p')
    endif
  endif
  return getcwd() . '/'
endfunction

let s:ctags_excludes = [
      \ '.git',
      \ '.hg',
      \ '.svn',
      \ 'node_modules',
      \ 'dist',
      \ 'build',
      \ 'target',
      \ '.next',
      \ '.cache',
      \ '__pycache__',
      \ '.venv',
      \ 'vendor',
      \ ]

function! s:CtagsBuildCommand() abort
  let l:parts = [s:CtagsBin(), '-R', '--tag-relative=yes']
  for l:item in s:ctags_excludes
    call add(l:parts, '--exclude=' . shellescape(l:item))
  endfor
  return join(l:parts, ' ')
endfunction

let g:fzf_vim = get(g:, 'fzf_vim', {})
let g:fzf_vim.tags_command = s:CtagsBuildCommand()

if s:CtagsReady()
  set tags=./tags;,tags;
endif

function! s:RebuildTags() abort
  if !s:CtagsReady()
    call s:CtagsWarnMissing()
    return
  endif

  let l:root = s:CtagsProjectRoot()
  let l:cmd = 'cd ' . shellescape(l:root) . ' && ' . s:CtagsBuildCommand()
  call system(l:cmd)
  if v:shell_error != 0
    echohl WarningMsg
    echom "ctags rebuild failed."
    echohl None
    return
  endif
  echom "ctags rebuilt in " . fnamemodify(l:root, ':~')
endfunction

function! s:TagsOrWarn() abort
  if !s:CtagsReady()
    call s:CtagsWarnMissing()
    return
  endif
  call s:FzfOrWarn('Tags')
endfunction

function! s:SmartTagJump() abort
  let l:sym = expand('<cword>')
  if empty(l:sym)
    return
  endif

  let l:pat = '^' . escape(l:sym, '\.^$~[]*') . '$'
  let l:matches = taglist(l:pat)
  if empty(l:matches)
    echohl WarningMsg
    echom 'no tag found for: ' . l:sym
    echohl None
    return
  endif

  if len(l:matches) == 1
    execute 'tag ' . l:sym
    return
  endif

  if !s:FzfReady()
    execute 'tselect ' . l:sym
    return
  endif

  call fzf#vim#tags(l:sym, fzf#vim#with_preview({ "placeholder": "--tag {2}:{-1}:{3..}" }), 0)
endfunction

let g:ctags_auto_update = get(g:, 'ctags_auto_update', 0)
let s:ctags_last_update_at = reltime()
let s:ctags_min_interval_sec = 5

function! s:CtagsMaybeAutoUpdate() abort
  if !get(g:, 'ctags_auto_update', 0)
    return
  endif
  if !s:CtagsReady()
    return
  endif

  let l:elapsed = reltimefloat(reltime(s:ctags_last_update_at))
  if l:elapsed < s:ctags_min_interval_sec
    return
  endif

  let s:ctags_last_update_at = reltime()
  call s:RebuildTags()
endfunction

function! s:CtagsAutoToggle() abort
  let g:ctags_auto_update = !get(g:, 'ctags_auto_update', 0)
  echom 'ctags auto update: ' . (g:ctags_auto_update ? 'ON' : 'OFF')
endfunction

command! CtagsUpdate call <SID>RebuildTags()
command! CtagsAutoToggle call <SID>CtagsAutoToggle()

augroup dotfiles_ctags
  autocmd!
  autocmd BufWritePost * call <SID>CtagsMaybeAutoUpdate()
  autocmd VimEnter * call <SID>CtagsMaybeAutoUpdate()
augroup END

" Plugin shortcuts (safe if plugin isn't loaded)
nnoremap <silent> <leader>fe :silent! NERDTreeToggle<CR>
nnoremap <silent> <leader><space> :call <SID>FzfOrWarn('Files')<CR>
nnoremap <silent> <leader>, :call <SID>FzfOrWarn('Buffers')<CR>
nnoremap <silent> <leader>sg :call <SID>GitTrackedSearch()<CR>
nnoremap <silent> <leader>/ :call <SID>BLinesWithPreview()<CR>
nnoremap <silent> <leader>sG :call <SID>FzfOrWarn('Rg')<CR>
nnoremap <silent> <leader>st :call <SID>TagsOrWarn()<CR>
nnoremap <silent> <leader>ct :call <SID>RebuildTags()<CR>
nnoremap <silent> <leader>cT :call <SID>CtagsAutoToggle()<CR>
nnoremap <silent> <C-]> :call <SID>SmartTagJump()<CR>

