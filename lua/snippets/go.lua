local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
  s(
    "errNil",
      fmt(
      [[
if err != nil {{
  {}
}}
  ]], {i(0)}
    )
  ),
  s(
    "errNilPanic",
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
    "errNilFatal",
    fmt(
      [[
if err != nil {{
  log.Fatal(err)
}}
  ]],
      {}
    )
  ),
  s(
    "errNilReturn",
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
