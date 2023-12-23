local set = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-- In explorer mode set `tree` listing style
vim.g.netrw_liststyle = 3

set.nu = true
set.relativenumber = true

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true

set.smartindent = true

set.wrap = false

set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

set.hlsearch = false
set.incsearch = true
set.ignorecase = true

set.termguicolors = true

set.scrolloff = 15
set.signcolumn = "yes"
set.isfname:append("@-@")

set.updatetime = 50

set.colorcolumn = "81"

-- In markdown files create new line after 80 characters
autocmd(
    "FileType", {
    pattern = { 'markdown' },
    command = 'setlocal textwidth=80',
    group = generalSettingsGroup,
    }
)

autocmd(
    "FileType", {
    pattern = { 'python' },
    command = 'setlocal softtabstop=4',
    group = generalSettingsGroup,
    }
)
autocmd(
    "FileType", {
    pattern = { 'python' },
    command = 'setlocal tabstop=4',
    group = generalSettingsGroup,
    }
)
autocmd(
    "FileType", {
    pattern = { 'python' },
    command = 'setlocal shiftwidth=4',
    group = generalSettingsGroup,
    }
)

autocmd(
    "FileType", {
    pattern = { 'java' },
    command = 'setlocal softtabstop=4',
    group = generalSettingsGroup,
    }
)
autocmd(
    "FileType", {
    pattern = { 'java' },
    command = 'setlocal tabstop=4',
    group = generalSettingsGroup,
    }
)
autocmd(
    "FileType", {
    pattern = { 'java' },
    command = 'setlocal shiftwidth=4',
    group = generalSettingsGroup,
    }
)

-- github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/autocmds.lua
autocmd(
    'CMDlineEnter', {
    command =  'command! Term :botright split term://$SHELL'
    }
)


-- Go insert mode when switching to terminal
autocmd(
    'TermOpen', {
    command = 'setlocal listchars= nonumber norelativenumber',
    }
)
autocmd(
    'TermOpen', {
    pattern = '',
    command = 'startinsert',
    }
)

-- Close terminal buffer on process exit
autocmd(
    'BufLeave', {
    pattern = 'term://*',
    command = 'stopinsert'
    }
)
