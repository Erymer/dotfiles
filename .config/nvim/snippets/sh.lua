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

local snippets, autosnippets = {}, {}

-- In this case multiline string had to be defined using `[=[ foo ]=]` because 
-- therere are double brackets inside the string.
local init_script = s("init", fmt([=[
#!/usr/bin/env bash
declare -A dependencies

# dependencies["package_name"]="package_command"
# eg. dependencies["bitwarden-cli"]="bw"
dependencies[{}]={}

help_text=$(cat <<EOF
Usage:
        $(basename "$0") [OPTION]

{}

Options:
  -s    Short description
  -l <argument_example>
        This is an example of a long description, it can describe options
        [ top | left ]
EOF
)

main() {{
  while getopts "h" opt; do
    case $opt in
      h) help 0;;
      ?) help 1 "Invalid option: -$OPTARG";;
    esac
  done

  check_dependencies

  {}

}}


help() {{
  # Helper function
  # First argument is error code.
  # Subsequent arguments are error messages.

  local error_code=0

  if [[ $# -ge 2 ]]  ; then
    error_code="$1" ; shift
    printf "%s\n\n" "$*" >&2
  fi

  echo "${{help_text}}"

  exit "$error_code"

}}


check_dependencies() {{
  local package command

  [ -z "${{dependencies}}" ] && return

  for package in "${{!dependencies[@]}}"; do
    command="${{dependencies[$package]}}"

    if ! command -v "${{command}}" &> /dev/null; then
      echo "Install ${{package}}"
      exit 1
    fi
  done

}}

main "$@"

]=],{
  i(1, "'Package name'"),
  i(2, "'Package Command'"),
  i(3, "Script Description"),
  i(2, "# Your code goes here"),
})
)

local dependencies = s("dependencies", fmt([=[
declare -A dependencies

# dependencies["package_name"]="package_command"
# eg. dependencies["bitwarden-cli"]="bw"
dependencies["{}"]="{}"

check_dependencies() {{
  local package command

  for package in "${{!dependencies[@]}}"; do
    command="${{dependencies[$package]}}"

    if ! command -v "${{command}}" &> /dev/null; then
      echo "Install ${{package}}"
      exit 1
    fi
  done

}}
]=],{
  i(1, "Package Name"),
  i(2, "Package Command"),
})
)


table.insert(snippets, init_script)
table.insert(snippets, dependencies)

return snippets, autosnippets
