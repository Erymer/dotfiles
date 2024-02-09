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

function RunPythonScript()
  local height = 20
  local current_file = vim.fn.expand('%:p')

  local term_command = "term://$BASH python " .. current_file
  vim.cmd("belowright split " .. term_command)

  vim.api.nvim_win_set_height(0, height)
end


function CompilePDF()
  local height = 5
  local current_file = vim.fn.expand('%:p')

  if vim.fn.match(current_file, '.md$') == -1 then
    print("Error: Current file is not a Markdown file.")
    return
  end

  local pandoc_command = "pandoc " .. current_file .. " -o /tmp/temp.pdf"
  local term_command = "term://$BASH " .. pandoc_command
  vim.cmd("belowright split " .. term_command)
  vim.api.nvim_win_set_height(0, height)
end

-- Define a command to run the function
vim.cmd('command! RunBashScript lua RunBashScript()')
vim.cmd('command! RunPythonScript lua RunPythonScript()')
vim.cmd('command! RunMavenTest lua RunMavenTest()')
vim.cmd('command! CompilePDF lua CompilePDF()')
