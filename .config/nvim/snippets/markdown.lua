local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")


-- snippets are added via ls.add_snippets(filetype, snippets[, opts]), where
-- opts may specify the `type` of the snippets ("snippets" or "autosnippets",
-- for snippets that should expand directly after the trigger is typed).
--
-- opts can also specify a key. By passing an unique key to each add_snippets, it's possible to reload snippets by
-- re-`:luafile`ing the file in which they are defined (eg. this one).
 ls.add_snippets("lua", {
     s("help", {
         t("# Im helping"),
     }),
 })

local snippets, autosnippets = {}, {}

local insert_img = s("img", fmt("![{}]({})",{
  i(1, "Image Description"),
  i(2, "Image Path"),
})
)

local insert_link = s("link", fmt("[{}]({})",{
  i(1, "Link Description"),
  i(2, "URL"),
})
)

local section_link = s("sectionlink", fmt("[{}]({})",{
  i(1, "Link Description"),
  i(2, "#section-lowercase-kebabcase"),
})
)

-- local insert_date = ls.snippet({ trig = "date", wordTrig = true }, os.date("%Y-%m-%d"))
local insert_date = s("date", {
  t(os.date("%d-%m-%Y"))
})




table.insert(snippets, insert_img)
table.insert(snippets, insert_link)
table.insert(snippets, section_link)
table.insert(snippets, insert_date)

return snippets, autosnippets
