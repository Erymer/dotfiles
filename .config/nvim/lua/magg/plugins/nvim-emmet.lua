return {
  "olrtg/nvim-emmet",
  config = function()
    vim.keymap.set({ "n", "v" }, '<C-y>', require('nvim-emmet').wrap_with_abbreviation)
  end,
}
