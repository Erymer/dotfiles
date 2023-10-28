function OpenTerminal()
  local height = 20
  local current_file = vim.fn.expand('%:p')

  local term_command = "term://$BASH " .. current_file
  vim.cmd("belowright split " .. term_command)

  vim.api.nvim_win_set_height(0, height)
end

-- Define a command to run the function
vim.cmd('command! OpenTerminal lua OpenTerminal()')
vim.api.nvim_set_keymap('n', ',r', ':OpenTerminal<CR>', { noremap = true, silent = true })
