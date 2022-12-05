syntax on

set tabstop=2 softtabstop=2
set shiftwidth=2
set relativenumber
set expandtab
set smartindent
set autoindent
set nu
" set wrap
set nowrap
" set linebreak
set breakindent
set ignorecase
set mouse=nv
" set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set conceallevel=0
set autochdir
" set foldmethod=indent
" set foldlevel=99
" set clipboard+=unnamedplus "Always yank to Primary register
autocmd FileType markdown setlocal textwidth=80

" This is to avoid pairing square brakets when adding links using vim-zettel shorcut
autocmd FileType vimwiki let b:AutoPairs = {"(": ")", "'": "'", "`": "`", '"': '"', "```": "```"}

" Abolish only works if abolish.vim is sourced after all plugins are loaded
" Since I only use this abbreviations in markdown this works fine
" An alternative to this is to put abolish.vim file in 
" ~/.config/nvim/after/plugin/abolish.vim
" This would allow to use Abolish in all filetypes
autocmd FileType markdown source ~/.config/abbreviations/abolish.vim

autocmd FileType arduino setlocal commentstring=//%s

autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4

set guifont=Fira\ Mono:h10.5:n "PC
" set guifont=Fira\ Mono:h7:n "Laptop
source ~/.config/nvim/keybinds.vim

"==============================================================================
" THEMES CONFIGURATION
"==============================================================================
"Gruvbox
let g:gruvbox_contrast_dark = 'hard' "Possible values: soft, medium, hard
let g:gruvbox_contrast_light = 'soft' "Possible values: soft, medium, hard

"Sonokai
if has('termguicolors')
  set termguicolors
endif
let g:sonokai_style = 'shusia' "Possible values: default, atlantis, andromeda, shusia, maia
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background = 0
let g:sonokai_sign_column_background = 'none'

" Material
let g:material_theme_style = 'darker'
" Options
" default, palenight, ocean, lighter, darker, default-community, palenight-community, ocean-community, lighter-community, darker-community

" Solarized
let g:solarized_termcolors=256

" Molokai
let g:molokai_original = 0

" 256_noir
" Change highlighting of cursor line when entering/leaving Insert Mode
" set cursorline
" highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212
" autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=234 guifg=NONE guibg=#1c1c1c
" autocmd InsertLeave * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212

"==============================================================================
"PLUGINS
"==============================================================================
call plug#begin('~/.vim/plugged')

" COLOR THEMES
" Plug 'morhetz/gruvbox' "Gruvbox Color Theme
" Plug 'sainnhe/sonokai' "Sonokai Color Theme
" Plug 'junegunn/seoul256.vim' "Seoul256 Color Theme
" Plug 'arcticicestudio/nord-vim' "Nord Color Theme https://www.nordtheme.com/docs/ports/vim/installation 
" Plug 'altercation/vim-colors-solarized'
" Plug 'kaicataldo/material.vim'
" Plug 'sjl/badwolf'
" Plug 'NLKNguyen/papercolor-theme' "PaperColor
" Plug 'tomasr/molokai'
Plug 'sickill/vim-monokai'
" Plug 'twerth/ir_black'
" Plug 'andreasvc/vim-256noir' "256_noir
" Plug 'logico/typewriter-vim' "typewriter or typewriter-night
Plug 'jaredgorski/fogbell.vim' 


Plug 'vim-airline/vim-airline'
Plug 'glepnir/dashboard-nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jremmen/vim-ripgrep'
" Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'

" Image Preview
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

" Plug 'mbbill/undotree'
Plug 'jiangmiao/auto-pairs' "quote and bracket completion
Plug 'tpope/vim-commentary' "More simple comment command
Plug 'tmhedberg/SimpylFold' "Code folding
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
" Plug 'sheerun/vim-polyglot' "Language packs. Recomended by Sonokai Color Theme
Plug 'easymotion/vim-easymotion' "Jump to specific location
Plug 'junegunn/goyo.vim' "Minimalistic writting
Plug 'junegunn/limelight.vim' "Adds trasparency to pharagraphs that are not being used
Plug 'mboughaba/i3config.vim' "i3 config file sintax highlight
" Plug 'ledger/vim-ledger'

Plug 'godlygeek/tabular' "vim-markdown dependency
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } "Used to previe Markdown files
Plug 'lervag/vimtex' "LaTex
Plug 'chrisbra/csv.vim'
Plug 'ap/vim-css-color' "Highlight hex color codes their respective color
Plug 'machakann/vim-highlightedyank'
Plug 'SirVer/ultisnips' "Code snippets
" Plug 'nvim-treesitter/nvim-treesitter' "Better Sintax Highlighting. Recomended by Sonokai Color Theme
Plug 'preservim/vim-markdown'
" Plug 'vim-scripts/AutoComplPop'
" Plug 'vim-syntastic/syntastic'
" Plug 'nvie/vim-flake8' 
" Plug 'python-mode/python-mode' 
" Plug 'sudar/vim-arduino-syntax'
" Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'

" Flutter
Plug 'dart-lang/dart-vim-plugin'
" Plug 'thosakwe/vim-flutter'
" Plug 'natebosch/vim-lsc'
" Plug 'natebosch/vim-lsc-dart'


Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plug 'ervandew/supertab'
" Plug 'stevearc/vim-arduino'
Plug 'tpope/vim-abolish' "Autocorrector
" Plug 'kien/rainbow_parentheses.vim' 
" Plug 'michaelb/sniprun', { 'do': 'bash install.sh' }
" if has('nvim')
"     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "Autocompletion for various languages
" else
"     Plug 'Shougo/deoplete.nvim'
"     Plug 'roxma/nvim-yarp'
"     Plug 'roxma/vim-hug-neovim-rpc'
" endif
" Plug 'zchee/deoplete-jedi' "Autocompletion for python
"Plug 'preservim/nerdcommenter' "comment character
"Plug 'Konfekt/FastFold' "Faster folding. Recomended by SimpylFold
Plug 'tpope/vim-fugitive'

Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'

call plug#end()

"==============================================================================
"COLOR CONFIGURATION
"==============================================================================
colorscheme monokai
"Change to fogbell when writting text, Monokai for code
" autocmd BufEnter * colorscheme monokai
" autocmd BufEnter *.md colorscheme fogbell

set background=dark
" highlight ColorColumn ctermbg=0 guibg=grey
highlight ColorColumn ctermbg=0 guibg=Gray
autocmd FileType sh call matchadd('ColorColumn', '\%81v', 100) "Only shows colorcolumn when line overextende
autocmd FileType markdown call matchadd('ColorColumn', '\%81v', 100) "Only shows colorcolumn when line overextende
autocmd FileType python call matchadd('ColorColumn', '\%81v', 100) "Only shows colorcolumn when line overextende
" set colorcolumn=88

"==============================================================================
"PLUGINS DEPENDENCIES
"==============================================================================
" NERDCommenter
filetype plugin on "nerdcommenter requires this line to work properly

"==============================================================================
"PLUGIN CONFIGURATION
"==============================================================================
"Goyo
let g:goyo_width = 90

"Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdm'


" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0"

" SimpylFold
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_docstring_preview = 1

" Pymode
let g:pymode_doc_bind = 'K'
let g:pymode_doc = 0
let g:pymode_lint_ignore = ["W0401"]

" vim-arduino
let g:arduino_cmd='/usr/bin/arduino'
let g:arduino_dir='/usr/share/arduino/'
let g:arduino_home_dir='/home/mag/Arduino/'

" UltiSnips
" let g:UltiSnipsJumpForwardTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Markdown preview
" let g:mkdp_browser = 'Brave'

" dart-vim-plugin
let g:dart_style_guide = 2
let g:dart_format_on_save = 1


" Vim-Zettel & Vimwiki
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_conceallevel = 0
let g:zettel_format = "%y%m%d-%title"
let g:zettel_link_format = "[%title](%link.md)"
let g:vimwiki_key_mappings = { 'all_maps': 0, }
let g:vimwiki_hl_headers = 1
let g:vimwiki_folding = 'expr'

function! s:insert_id()
  if exists("g:zettel_current_id")
    return g:zettel_current_id
  else
    return "unnamed"
  endif
endfunction

" Defining wikis
" Foo
let foo = {}
let foo.path = '~/tests/vim-foo/'
let foo.ext = '.md'
let foo.syntax = 'markdown'
let foo.links_space_char = '_'
let foo_options = {}
let foo_options.front_matter = [["id", function("s:insert_id")], ["tags", ""], ["category", ""]]

" Onyon Chronicles
let onyon = {}
let onyon.path = '~/Documents/DnD/stars-without-numbers/Wiki/'
let onyon.ext = '.md'
let onyon.syntax = 'markdown'
let onyon.links_space_char = '_'

" Zettelcasten
let zettel = {}
let zettel.path = '~/Documents/Zettel/'
let zettel.ext = '.md'
let zettel.syntax = 'markdown'
let zettel.links_space_char = '_'
let zettel_options = {}
let zettel_options.front_matter = [[":*****:"], ["id", function("s:insert_id")], ["tags", ""], ["category", "Nota"]]

let g:vimwiki_list = [foo, onyon, zettel]
let g:zettel_options = [foo_options, {}, zettel_options]


" " Abolish
let g:abolish_save_file='/home/mag/.config/abbreviations/abolish.vim'

" dashboard-nvimo
" let g:dashboard_default_executive ='fzf'
" let g:dashboard_custom_header = [
"       \' *:::::::::::::::::::::::::::::::::::::::::::::::*::::::::::::::::::::::::::::::::::::::::::::::::::: ',
"       \' :................................................................................................... ',
"       \' :................................................................................................... ',
"       \' :...................................:**IFV$MMMMMNNMMMM$$VI**:....................................... ',
"       \' :..............................:*I$MNNNNNNNNNNNNNNNNNNNNNNNNNN$VI*:................................. ',
"       \' :...........................:I$MNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNMV*:.............................. ',
"       \' :........................*FMNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$I:........................... ',
"       \' :.....................:*$NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNMV*......................... ',
"       \' :...................:IMNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$*....................... ',
"       \' :..................IMNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$:..................... ',
"       \' :................*$NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNMI:................... ',
"       \' :...............IMNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$:.................. ',
"       \' :.............:VNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNM*................. ',
"       \' :............:VNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNMI................ ',
"       \' :...........:$NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$VNNNNNNNNNNNNNNNNNNNNNNNN*............... ',
"       \' :...........FNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNFV$$NNN$..INNNNNNNNNNNNNNNNNNNNNNNM:.............. ',
"       \' :..........*MNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNM:.IM$M$:...$MNNNNNNNNNNM$MNNNNNNNNN$.............. ',
"       \' :.........:$NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNM*..$NV:....::::*IF$MN$*:.VMNNNNNNNNM*............. ',
"       \' :.........*MNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$:.*$*.........*NMVI*....$NNNNNNNNNN$............. ',
"       \' :.........VNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN$:.............INNNNNV*.:$F****VNNNNM*............ ',
"       \' :.........MNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNV:..............:$NNNNNN$:.....:$NNNNMI............ ',
"       \' :........:MNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNI.................:$NNNNNN$....*$NNNNNMF............ ',
"       \' :........:MNNNNNNNNNNNNN$I*$NNNNNNNNNNNNNNNNNNNV....................*VMNNNNI.I$NNNNNNNMF............ ',
"       \' :.........MNNNNNNNNNNNNV..:MNNNNNNNNNNNNNNNMM$$:.......................:****.MNNNNNNNNMI............ ',
"       \' :.........$NNNNNNNNNNNNF..:MNNNNNNNNNM$F**::.................................MNNNNNNNNM*............ ',
"       \' :.........IMNNNNNNNNNNN$.:$NNNNNNMV*:........................................MNNNNNNNN$:............ ',
"       \' :.........:$NNNNNNNNNNN$.*MNNNN$I:............::............................*MNNNNNNNN*............. ',
"       \' :..........*MNNNNNNNNNNM*.IMN$*:*:...:::......I:............................VNNNNNNNN$.............. ',
"       \' :...........$NNNNNNNNNNNMI:*I:IMV...FMNN$:...:$F...........................*MNNNNNNNM*.............. ',
"       \' :...........:MNNNNNNNNNNNNM**MNN*..*NNNNNM$V$MNN$*..........................VNNNNNNNI............... ',
"       \' :............*$NNNNNNNNNNNV*NNNN$:.:$MNNNNNNNNNNNN$*:.......................FNNNNNMV................ ',
"       \' :.............:$NNNNNNNNNM:V$IF$NMVI***::::*I$NNNNNNN$I*:..................*MNNNNMI................. ',
"       \' :..............:VNNNNNNNNM......VNNNNNNMF.....*MNNNN$IIV$VI*:.............*MNNNNM*.................. ',
"       \' :................IMNNNNNNM.....:MNNNNNNNM......INNV:...:::**F$$$FII***IF$MNNNNNV:................... ',
"       \' :.................:VNNNNNM:....:VNNNNNN$:......VNF...*$MN$:...I$********MNNNNM*..................... ',
"       \' :...................*VMNNNF......:*II*:.......*NV...:NNNNN$***MNM:......*MN$I:...................... ',
"       \' :.....................*VMNM:...................*:...FNNNNNNNNNNNNI......F$I:........................ ',
"       \' :.......................:*$$:.......................INNNNMI**VNNN*......:........................... ',
"       \' :..........................::........................I$$V:...*NMI................................... ',
"       \' :............................................................**:.................................... ',
"       \' :................................................................................................... ',
"       \' :................................................................................................... ',
"      \ ]

lua << EOF
  local home = os.getenv('HOME')
  local db = require('dashboard')
  -- db.preview_command = 'cat | lolcat -F 0.3'
  db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
  db.preview_file_height = 12
  db.preview_file_width = 80
  db.custom_center = {
      {icon = '  ',
      desc = 'Recently opened files                   ',
      shortcut = 'SPC f r'},
      {icon = '  ',
      desc = 'Find  File                              ',
      shortcut = 'SPC f o'},
    }
EOF


lua << EOF
require('telescope').load_extension('media_files')
require'telescope'.setup {
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    }
  },
}
EOF
