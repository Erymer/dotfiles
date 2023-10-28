require("magg.remap")
require("magg.lazy")
require("magg.set")
require("magg.functions")
vim.g.netrw_liststyle = 3

function CreateFileFromRegister()
  -- Get the content from the "0 register
  local file_name = vim.fn.getreg('0')
  local full_date = os.date("%Y-%m-%d %H:%M")

  local frontmatter = string.format([[
---
MARKDOWN_FILE_START: 
title: %s
date: 2023-09-21 11:06
id: 230921-java
---
]], file_name)

-- file name = name_in_lower_without_special_chars-YYMMDD.md
-- title = Name in Title Case
-- date = Date in YYYY-MM-DD HH:MM
-- id = file name without .md

  local file_path = vim.fn.expand('%:p:h') .. '/' .. file_name .. '.md'

  -- zettel
  local file = io.open(file_path, "w")
    if file then
      file:write(frontmatter)
      file:close()
      print("File created in " .. file_path)
    end
end

function TitleCase(input)
  return input:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper()..rest:lower()
  end)
end

function Foo()
  TitleCase("do not go gentle into that good night")
end
