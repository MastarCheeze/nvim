local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local cpMakefilePath = vim.fs.normalize("~/.config/nvim/lua/zhchay/snippets/Makefile")

if vim.fn.filereadable(cpMakefilePath) == 0 then
  vim.notify("Makefile template " .. cpMakefilePath .. " does not exist.")
else
  local f = assert(io.open(cpMakefilePath, "rb"))
  local template = f:read("*all")
  f:close()

  template = template:gsub("{", "{{")
  template = template:gsub("}", "}}")

  ls.add_snippets("make", {
    s("cp", fmt(template, {})),
  })
end
