" Core options and global key defaults (shared Vim/Neovim)

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

syntax on

" Colors: keep a stable dark palette across terminal/Vim variants.
if has('termguicolors')
  set termguicolors
endif
set background=dark
silent! colorscheme habamax
if !exists('g:colors_name') || g:colors_name !=# 'habamax'
  silent! colorscheme desert
endif

" Keep transparent background while preserving habamax foreground colors.
function! s:ApplyTransparentBackground() abort
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight FoldColumn guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight CursorLineNr guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE

  " Airline: keep same palette family but transparent background.
  highlight airline_a guibg=NONE ctermbg=NONE
  highlight airline_b guibg=NONE ctermbg=NONE
  highlight airline_c guibg=NONE ctermbg=NONE
  highlight airline_x guibg=NONE ctermbg=NONE
  highlight airline_y guibg=NONE ctermbg=NONE
  highlight airline_z guibg=NONE ctermbg=NONE
  highlight airline_a_inactive guibg=NONE ctermbg=NONE
  highlight airline_b_inactive guibg=NONE ctermbg=NONE
  highlight airline_c_inactive guibg=NONE ctermbg=NONE
endfunction

augroup dotfiles_transparent_theme
  autocmd!
  autocmd ColorScheme * call <SID>ApplyTransparentBackground()
  autocmd VimEnter * call <SID>ApplyTransparentBackground()
augroup END

" Encoding
set encoding=utf-8
set fileencodings=utf-8,gb18030

set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu
set title
set scrolloff=5
set foldmethod=indent
set foldlevel=99

set autochdir
set laststatus=2

" Powerful backspace?
set backspace=indent,eol,start

" Last open position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" (t)oggle showing (i)nvisible characters
set nolist
set listchars=extends:#,precedes:#,tab:▸\ ,trail:▫,eol:¬
nnoremap <leader>ti :set list!<CR>

" Disable bell
set visualbell
set noerrorbells
set t_vb=

" Fix mouse scrolling
" ref: https://www.reddit.com/r/vim/comments/c7a39a/can_anyone_tell_me_what_this_is/
let &t_ut=''

" w!! saves the file with sudo (command-line mode)
cmap w!! w !sudo tee % >/dev/null

" ------- Motions -------
set mouse=a
noremap H ^
noremap L $

" Use different cursor shape in different mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" ---- Editor ----
noremap s <nop>
" Use meta-backspace to delete a word in terminal
inoremap <Esc><BS> <C-W>

