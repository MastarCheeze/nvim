local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local cpTemplatePath = vim.fs.normalize("~/.config/nvim/lua/zhchay/snippets/template.cpp")

if vim.fn.filereadable(cpTemplatePath) == 0 then
  vim.notify("CP template " .. cpTemplatePath .. " does not exist.")
else
  local f = assert(io.open(cpTemplatePath, "rb"))
  local template = f:read("*all")
  f:close()

  template = template:gsub("{", "{{")
  template = template:gsub("}", "}}")
  template = template:gsub("//$0", "{}")

  ls.add_snippets("cpp", {
    s("template", fmt(template, { i(0) })),
  })
end
