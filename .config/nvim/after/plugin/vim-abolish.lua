local autocmd = vim.api.nvim_create_autocmd
autocmd(
    "FileType", {
    pattern = { 'markdown' },
    command = 'source ~/.config/abbreviations/abolish.vim',
    group = generalSettingsGroup,
    }
)

autocmd(
    "FileType", {
    pattern = { 'markdown' },
    command = 'source ~/.config/abbreviations/steno.vim',
    group = generalSettingsGroup,
    }
)
