" Esta configuración es para usarla sin plugins.
" Es para usarla en computadoras que no tienen nada instalado. 
" Solo vim vanilla
syntax on

set tabstop=4 softtabstop=4
set shiftwidth=4
set relativenumber
set expandtab
set smartindent
set nu
set wrap
set linebreak
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set nocompatible "Recomended config for vim-polyglot
set conceallevel=2
set textwidth=80
" set foldmethod=indent
"set clipboard+=unnamedplus "Always yank to Primary register
"set scrolloff=3 " Keep lines below and above the cursor

"==============================================================================
"KEYBINDINGS
"==============================================================================
let mapleader=" "
nnoremap <leader>fs :w<CR>| "Save file
nnoremap <leader>fS :w !sudo tee %<CR>| "Save file as sudo
imap cg <Esc>| "Escape character
imap <c>j <c>h| "Escape character
vmap cg <Esc>| "Escape character
nnoremap y- yg_| "Yank from cursor position until last character
nnoremap y_ ^yg_| "Yank from first to last character
" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
" nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
" nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
imap <C-BS> <C-w>
nnoremap <leader>n :noh<CR>

"Window Commands
nnoremap <leader>Wv :rightbelow vnew<CR>| "New vertical window
nnoremap <leader>Wh :rightbelow new<CR>| "New horizontal window
nnoremap <leader>Wt :rightbelow new<CR>:resize 10<CR>:terminal<CR>:startinsert<CR>| "New terminal window
nnoremap <leader>WT :rightbelow vnew<CR>:terminal<CR>:startinsert<CR>| "New terminal window
nnoremap <leader>Wn :enew<CR>| "New window
nnoremap <leader>Wd :hide<CR>| "Delete Window
nnoremap <leader>wl :wincmd l<CR>| "Move cursor to right window
nnoremap <leader>wh :wincmd h<CR>| "Move cursor to left window
nnoremap <leader>wk :wincmd k<CR>| "Move cursor to above window
nnoremap <leader>wj :wincmd j<CR>| "Move cursor to below window
" nnoremap <leader>ww :wincmd p<CR>| "Move cursor to previous window
nnoremap <C-Space> :wincmd p<CR>| "Move cursor to previous window
nnoremap <leader>qq :confirm qall<CR>| "Close Vim

"Buffer Commands
nnoremap <leader><tab> :b!#<CR>| "Go to last edited buffer
nnoremap <leader>bl :ls<CR>| "List buffers
nnoremap <leader>bo :Buffer<CR>| "Open buffer
nnoremap <leader>bd :bd<CR>| "Delete current buffer

"Run Scripts
" nnoremap <leader>rt :rightbelow split term:// %<CR>| "Run in terminal
" nnoremap <leader>rt :rightbelow new<CR>:resize 10<CR>:terminal<CR>:startinsert<CR>| "New terminal window
" nnoremap <leader>rt :rightbelow new term:// %<CR>:resize 10<CR>:startinsert<CR>| "New terminal window
nnoremap <leader>ra :w<CR>:!%<CR>| "Run all

"Copy Paste to/from clipboard
"https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim https://www.youtube.com/watch?v=E_rbfQqrm7g
" vnoremap <C-c> "*y :let @+=@*<CR>| "Copy text to Primary and clipboard
" nnoremap <C-V> "*p| "Paste text from primary register witch is accesed with middle mouse botton

"File Explorer
map <leader>F :Vexplore<CR>:vertical resize 40<CR>

"Terminal Keybindings
tnoremap cg <C-\><C-n>
nnoremap <leader>tp :wincmd j<CR>p :startinsert<CR>| "Paste line in teminal

" Help
nnoremap <leader>h K| "Search word in the documetation
    
"Stay cursor allways in the middle
nnoremap k kzz
nnoremap j jzz
nnoremap p pzz
nnoremap P Pzz
nnoremap G Gzz
nnoremap x xzz
nnoremap <ENTER> <ENTER>zz
inoremap <ENTER> <ENTER><ESC>zzi
" this ones disables autoindent
" nnoremap o o<ESC>zza
" nnoremap O O<ESC>zza
" nnoremap a a<ESC>zza
nnoremap H Hzz
nnoremap M Mzz
nnoremap L Lzz
nnoremap { {zz
nnoremap } }zz

