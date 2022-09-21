" https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/
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
set conceallevel=2
set foldmethod=indent
set foldlevel=99
" set clipboard+=unnamedplus "Always yank to Primary register
autocmd FileType markdown setlocal textwidth=80

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


set guifont=Fira\ Mono:h10.5:n
source ~/.config/nvim/keybinds.vim

"==============================================================================
" FONT CONFIGURATION
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

Plug 'vim-airline/vim-airline'
Plug 'glepnir/dashboard-nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jremmen/vim-ripgrep'
" Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'junegunn/fzf.vim'

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
" Plug 'preservim/nerdtree'
" Plug 'sheerun/vim-polyglot' "Language packs. Recomended by Sonokai Color Theme
Plug 'easymotion/vim-easymotion' "Jump to specific location
Plug 'junegunn/goyo.vim' "Minimalistic writting
Plug 'junegunn/limelight.vim' "Adds trasparency to pharagraphs that are not being used
Plug 'mboughaba/i3config.vim' "i3 config file sintax highlight
" Plug 'ledger/vim-ledger'

Plug 'godlygeek/tabular' "vim-markdown dependency
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } "Used to previe Markdown files
" Plug 'lervag/vimtex' "LaTex
" Plug 'chrisbra/csv.vim'
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
" Plug 'mattn/emmet-vim'

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
" Plug 'davidhalter/jedi-vim' "Code jump (go to)
Plug 'tpope/vim-fugitive'
Plug 'renerocksai/telekasten.nvim'

call plug#end()

"==============================================================================
"COLOR CONFIGURATION
"==============================================================================
colorscheme monokai
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

" Deoplete
let g:deoplete#enable_at_startup = 1 "Initiates deoplete.nvim at startup

"Treesitter
" Activate Modules
"lua <<EOF
"require'nvim-treesitter.configs'.setup {
  "ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  "highlight = {
    "enable = true,              -- false will disable the whole extension
    "disable = { "c", "rust" },  -- list of language that will be disabled
  "},
"}
"EOF

""Highlighting
"lua <<EOF
"require'nvim-treesitter.configs'.setup {
  "highlight = {
    "enable = true,
    "use_languagetree = false, -- Use this to enable language injection (this is very unstable)
    "custom_captures = {
      "-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      "["foo.bar"] = "Identifier",
    "},
  "},
"}
"EOF

"==============================================================================
"PLUGIN CONFIGURATION
"==============================================================================
""JEDI-VIM
"let g:jedi#completions_enabled = 0 "autocompletion disabled, because deoplete is used for completion
"let g:jedi#use_splits_not_buffers = "right" "open go-to function in split, not another buffer

"NerdTree
"autocmd vimenter * NERDTree "Opens NERDTree automatically when vim starts up
"Open NERDTree only if no file was specified or opening sesion
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif

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

" Supertab
" let g:SuperTabDefaultCompletionType = "context"

" dart-vim-plugin
let g:dart_style_guide = 2
let g:dart_format_on_save = 1


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
  db.preview_command = 'cat | lolcat -F 0.3'
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

lua << END
local home = vim.fn.expand("~/tests/vim-zettelcasten")
require('telekasten').setup({
    home         = home,

    -- if true, telekasten will be enabled when opening a note within the configured home
    take_over_my_home = true,

    -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
    --                               and thus the telekasten syntax will not be loaded either
    auto_set_filetype = true,

    -- dir names for special notes (absolute path or subdir name)
    dailies      = home .. '/' .. 'daily',
    weeklies     = home .. '/' .. 'weekly',
    templates    = home .. '/' .. 'templates',

    -- image (sub)dir for pasting
    -- dir name (absolute path or subdir name)
    -- or nil if pasted images shouldn't go into a special subdir
    image_subdir = "img",

    -- markdown file extension
    extension    = ".md",

    -- Generate note filenames. One of:
    -- "title" (default) - Use title if supplied, uuid otherwise
    -- "uuid" - Use uuid
    -- "uuid-title" - Prefix title by uuid
    -- "title-uuid" - Suffix title with uuid
    new_note_filename = "title",
    -- file uuid type ("rand" or input for os.date()")
    uuid_type = "%Y%m%d%H%M",
    -- UUID separator
    uuid_sep = "-",

    -- following a link to a non-existing note will create it
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,

    -- skip telescope prompt for goto_today and goto_thisweek
    journal_auto_open = false,

    -- template for new notes (new_note, follow_link)
    -- set to `nil` or do not specify if you do not want a template
    template_new_note = home .. '/' .. 'templates/new_note.md',

    -- template for newly created daily notes (goto_today)
    -- set to `nil` or do not specify if you do not want a template
    template_new_daily = home .. '/' .. 'templates/daily.md',

    -- template for newly created weekly notes (goto_thisweek)
    -- set to `nil` or do not specify if you do not want a template
    template_new_weekly= home .. '/' .. 'templates/weekly.md',

    -- image link style
    -- wiki:     ![[image name]]
    -- markdown: ![](image_subdir/xxxxx.png)
    image_link_style = "markdown",

    -- default sort option: 'filename', 'modified'
    sort = "filename",

    -- integrate with calendar-vim
    plug_into_calendar = true,
    calendar_opts = {
        -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
        weeknm = 4,
        -- use monday as first day of week: 1 .. true, 0 .. false
        calendar_monday = 1,
        -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
        calendar_mark = 'left-fit',
    },

    -- telescope actions behavior
    close_after_yanking = false,
    insert_after_inserting = true,

    -- tag notation: '#tag', ':tag:', 'yaml-bare'
    tag_notation = "#tag",

    -- command palette theme: dropdown (window) or ivy (bottom panel)
    command_palette_theme = "ivy",

    -- tag list theme:
    -- get_cursor: small tag list at cursor; ivy and dropdown like above
    show_tags_theme = "ivy",

    -- when linking to a note in subdir/, create a [[subdir/title]] link
    -- instead of a [[title only]] link
    subdirs_in_links = true,

    -- template_handling
    -- What to do when creating a new note via `new_note()` or `follow_link()`
    -- to a non-existing note
    -- - prefer_new_note: use `new_note` template
    -- - smart: if day or week is detected in title, use daily / weekly templates (default)
    -- - always_ask: always ask before creating a note
    template_handling = "smart",

    -- path handling:
    --   this applies to:
    --     - new_note()
    --     - new_templated_note()
    --     - follow_link() to non-existing note
    --
    --   it does NOT apply to:
    --     - goto_today()
    --     - goto_thisweek()
    --
    --   Valid options:
    --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
    --              all other ones in home, except for notes/with/subdirs/in/title.
    --              (default)
    --
    --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
    --                    except for notes with subdirs/in/title.
    --
    --     - same_as_current: put all new notes in the dir of the current note if
    --                        present or else in home
    --                        except for notes/with/subdirs/in/title.
    new_note_location = "smart",

    -- should all links be updated when a file is renamed
    rename_update_links = true,

    vaults = {
        vault2 = {
            -- alternate configuration for vault2 here. Missing values are defaulted to
            -- default values from telekasten.
            -- e.g.
            -- home = "/home/user/vaults/personal",
        },
    },

    -- how to preview media files
    -- "telescope-media-files" if you have telescope-media-files.nvim installed
    -- "catimg-previewer" if you have catimg installed
    media_previewer = "telescope-media-files",
})
END
