" Window manage + buffers + tabs (matches your ~/.vimrc habits)

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

" Basic shortcuts
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
" (deprecated optional schema)
map <leader><f4> :source $MYVIMRC<CR>

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

