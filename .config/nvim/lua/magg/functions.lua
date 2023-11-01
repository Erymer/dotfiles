function RunBashScript()
  local height = 20
  local current_file = vim.fn.expand('%:p')

  local term_command = "term://$BASH " .. current_file
  vim.cmd("belowright split " .. term_command)

  vim.api.nvim_win_set_height(0, height)
end

function RunMavenTest()
  local height = 40
  local current_dir = vim.fn.getcwd()

  local mvn_command = "mvn -f " .. current_dir .. "/pom.xml test"


  local term_command = "term://$BASH " .. mvn_command
  vim.cmd("belowright split " .. term_command)

  vim.api.nvim_win_set_height(0, height)
end

-- Define a command to run the function
vim.cmd('command! RunBashScript lua RunBashScript()')
vim.cmd('command! RunMavenTest lua RunMavenTest()')
