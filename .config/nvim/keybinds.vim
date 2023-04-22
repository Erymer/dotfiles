"==============================================================================
"KEYBINDINGS
"==============================================================================
let mapleader=" "
nnoremap <leader>fs :w<CR>| "Save file
nnoremap X <c-v>
nnoremap <leader>fS :w !sudo tee %<CR>| "Save file
nnoremap <leader>fr :History<CR>| "Open recent file
imap cg <Esc>| "Escape character
imap <c>j <c>h| "Escape character
vmap cg <Esc>| "Escape character
vnoremap <leader>p "_dP| "Delete line and paste implicit register
nnoremap <leader>p V"_dP| "Delete line and paste implicit register
nnoremap y- "zyg_| "Yank from cursor position until last character
nnoremap Y "zyg_| "Yank from cursor position until last character
nnoremap y_ ^"zyg_| "Yank from first to last character
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

" Git
nnoremap <leader>gs :Git status<CR>| "Git status
nnoremap <leader>ga :Git add .<CR>| "Git add files

"Buffer Commands
nnoremap <leader><tab> :b!#<CR>| "Go to last edited buffer
nnoremap <leader>bl :ls<CR>| "List buffers
nnoremap <leader>bo :Buffer<CR>| "Open buffer
nnoremap <leader>bd :bd<CR>| "Delete current buffer
nnoremap <leader>bc :Bdelete hidden<CR>| "Delete all buffers except hidden

"Run Scripts
" nnoremap <leader>rt :rightbelow split term:// %<CR>| "Run in terminal
" nnoremap <leader>rt :rightbelow new<CR>:resize 10<CR>:terminal<CR>:startinsert<CR>| "New terminal window
" nnoremap <leader>rt :rightbelow new term:// %<CR>:resize 10<CR>:startinsert<CR>| "New terminal window
nnoremap <leader>ra :w<CR>:!%<CR>| "Run all
nnoremap <leader>rl :SnipRun<CR>| "Run Line
autocmd FileType sh map <leader>rt :! shellcheck %<CR>

"Copy Paste to/from clipboard
"https://vi.stackexchange.com/questions/84/how-can-i-copy-text-to-the-system-clipboard-from-vim https://www.youtube.com/watch?v=E_rbfQqrm7g
vnoremap <C-c> "*y :let @+=@*<CR>| "Copy text to Primary and clipboard
nnoremap <C-V> "*p| "Paste text from primary register witch is accesed with middle mouse botton

"Nerdtree Keybindings and file opening shortcuts
"let g:NERDTreeMapActivateNode="l"
map <leader>ft :NERDTreeToggle<CR>
" map <leader>Ff :NERDTreeFocus<CR>
" map <leader>ff :NERDTreeFind<CR>
" map <leader>ff :Files<CR>
" map <leader>fo :Files ~/<CR>
" map <leader>ff :lua require("telescope.builtin").find_files({hidden=true, layout_config={prompt_position="bottom"}}) <CR>
map <leader>ff :Telescope find_files
map <leader>fcv :e ~/.config/nvim/init.vim<CR>

"Terminal Keybindings
tnoremap cg <C-\><C-n>
nnoremap <leader>tp :wincmd j<CR>p :startinsert<CR>| "Paste line in teminal

" Autocompletion
inoremap <C-Space> <C-x><C-p>
" inoremap <C-@> <C-Space>

"EasyMotion
map gk <Plug>(easymotion-sol-k)| "Go to line upward"
map gj <Plug>(easymotion-sol-j)| "Go to line downard"
map - <Plug>(easymotion-fl)| "Find character to the right
map _ <Plug>(easymotion-Fl)| "Find character to the left
map <leader>w <Plug>(easymotion-iskeyword-w)| "Begining of word forward
map <leader>W <Plug>(easymotion-iskeyword-b)| "Begining of word backward

" Help
nnoremap <leader>h K| "Search word in the documetation
    
" GOYO
map <leader>G :Goyo<CR>
" map <leader>GN :Goyo<CR>:set relativenumber<CR>

" LIMELIGHT
map <leader>L :Limelight!!0.8<CR>

" Arduino
autocmd FileType arduino map <leader>u :!arduino --upload %<CR>
autocmd FileType arduino map <leader>v :!arduino --verify %<CR>

" Markdown
autocmd FileType markdown map <leader>B  S*gvS*
autocmd FileType markdown map <leader>I  S*
autocmd FileType markdown map <leader>u  <esc>b~gi

" Vim-Zettekasten
autocmd FileType markdown map <leader>Zo :ZettelOpen<CR>
autocmd FileType markdown nnoremap <leader>l <Insert>[]()<Esc>h"*p :s/https:\/\///g<CR> :s/http:\/\///g<CR>


" Undotree
nnoremap <F5> :UndotreeToggle<cr>

"Temporal Keybindings
" map ,r :w<CR>:wincmd j<CR>:startinsert<CR><C-l>zsh<CR><C-\><C-n><CR>:wincmd k<CR>
" nnoremap <leader>wt :rightbelow new<CR>:resize 10<CR>:terminal<CR>:startinsert<CR>| "New terminal window
" nnoremap ,r :w<CR>:!xmonad --recompile<CR>| "Run all
" map ,s :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
" map <leader>Ga :Goyo 120<CR>| "width
" map <leader>Go :Goyo x30<CR>| "height
" map <leader>Ge :Goyo 120x30<CR>| "both
" map <leader>Gu :Goyo 70%<CR>| "In percentage
" map <leader>Gi :Goyo 50%+25%x50%-25%<CR>| "With offsets
map ,a :% ArrangeColumn<CR>
map ,u :% UnArrangeColumn<CR>

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
nnoremap n nzz

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
" nmap ,rn <Plug>(coc-rename)
nmap ,rn <Plug>(coc-rename)

" Formatting selected code
xmap ,f  <Plug>(coc-format-selected)
nmap ,f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `,aap` for current paragraph
xmap ,a  <Plug>(coc-codeaction-selected)
nmap ,a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap ,ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap ,as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap ,qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> ,re <Plug>(coc-codeaction-refactor)
xmap <silent> ,r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> ,r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap ,cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
