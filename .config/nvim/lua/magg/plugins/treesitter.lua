return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        -- 1. The setup function is now top-level
        ts.setup({})

        -- 2. Install parsers using the new install command
        ts.install({
            "c", "lua", "vim", "vimdoc", "query", "regex", "markdown", "bash", "python"
        })

        -- 3. Neovim 0.12+ handles highlighting natively now! 
        -- We just need an autocommand to start it when you open a file.
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
            callback = function()
                -- pcall prevents errors if a parser isn't installed yet
                pcall(vim.treesitter.start)
            end,
        })
    end
}
