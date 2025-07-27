"" -----
"" Basic
"" -----
set nocompatible
set nobackup
set noswapfile
let mapleader=" "

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

syntax on

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
set laststatus=2
set autochdir

" Powerful backspace?
set backspace=indent,eol,start

" Last open position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" (t)oggle showing (i)nvisible characters
set nolist
set listchars=extends:#,precedes:#,tab:▸\ ,trail:▫,eol:¬
nmap <leader>ti :set list!<CR>

" Disable bell
set visualbell
set noerrorbells
set t_vb=

" Fix mouse scrolling 
" ref: https://www.reddit.com/r/vim/comments/c7a39a/can_anyone_tell_me_what_this_is/
let &t_ut=''

" w!! saves the file with sudo
cmap w!! w !sudo tee % >/dev/null


"" ---
"" Indent
"" ---
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

"nnoremap < <<
"nnoremap > >>
vnoremap < <gv
vnoremap > >gv


"" -------
"" Motions
"" -------
set mouse=a

noremap H ^
noremap L $

" Use different cursor shape in different mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


"" ---------------
"" Basic shortcuts
"" ---------------
" %% expands into path to current file
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
" (f)ile (f)ile
map <leader>ff :e %%
" (f)ile (s)ave
map <leader>fs :w<CR>
" (q)uit (q)uit
map <leader>qq :qa<CR>
" (f)ile (S)ource vimrc
map <leader>fS :source $MYVIMRC<CR>
" (q)(w)
map <leader>qw :wq<CR>
" force quit
map <leader>q! :q!<CR>

" The optional schema (deprecated)
"map <leader>w :w<CR>
"map <leader>q :q<CR>
map <leader><f4> :source $MYVIMRC<CR>


"" ------
"" Editor
"" ------
noremap s <nop>
" Use meta-backspace to delete a word in terminal
inoremap <Esc><BS> <C-W>


"" ------------------
"" Search & highlight
"" ------------------
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
        set colorcolumn=81
    endif
endfunction


"" -------------
"" Window manage
"" -------------
" Window split: (v)ertical & (s)plit
map <leader>wv :set splitright<CR>:vsplit<CR>
map <leader>wV :set nosplitright<CR>:vsplit<CR>
map <leader>ws :set splitbelow<CR>:split<CR>
map <leader>wS :set nosplitbelow<CR>:split<CR>
map <leader>w2 :set splitright<CR>:vsplit<CR>
map <leader>w3 :set splitbelow<CR>:split<CR>

" Window focus
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <leader>wh <C-w>h
noremap <leader>wj <C-w>j
noremap <leader>wk <C-w>k
noremap <leader>wl <C-w>l

" Window size
noremap <leader>w+ :res +2<CR>
noremap <leader>w= :res +2<CR>
noremap <leader>w- :res -2<CR>
noremap <leader>w< :vertical resize-4<CR>
noremap <leader>w> :vertical resize+4<CR>

" Buffers
nmap <leader>bh :bp<CR>
nmap <leader>bl :bn<CR>
nmap <leader>bH :bf<CR>
nmap <leader>bL :bl<CR>
nmap <leader>bb :b 
nmap <leader>B :buffers<CR>
" (b)uffer (k)ill
nmap <leader>bk :bw
nmap <leader>wd :bw<CR>
" (b)uffer (r)ewind
nmap <leader>br :brewind<CR>

" Tabs(j)
" (j) (n)ew
map <leader>jn :tabe<CR>
" (j) (f)ile
map <leader>jf :tabe %%
map <leader>jl :+tabnext<CR>
map <leader>jh :-tabnext<CR>

