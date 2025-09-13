local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
  s(
    "errPanic",
    fmt(
      [[
if err != nil {{
  panic(err)
}}

  ]],
      {}
    )
  ),
  s(
    "errReturn",
    fmt(
      [[
if err != nil {{
  return {}
}}

  ]],
      { i(0) }
    )
  ),
})
