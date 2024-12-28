local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local cp_template_path = vim.fs.normalize("~/.config/nvim/lua/zhchay/snippets/template.cpp")
local cp_snippet = nil

if vim.fn.filereadable(cp_template_path) == 0 then
  vim.notify("CP template " .. cp_template_path .. " does not exist.")
else
  local f = assert(io.open(cp_template_path, "rb"))
  local text = f:read("*all")
  f:close()

  local snip_text = text
  snip_text = snip_text:gsub("{", "{{")
  snip_text = snip_text:gsub("}", "}}")
  snip_text = snip_text:gsub("//$0", "{}")

  cp_snippet = s("template", fmt(snip_text, { i(0) }))
  ls.add_snippets("cpp", { cp_snippet })
end

-- Create new cp folder with main.cpp and data, open them side-by-side
vim.api.nvim_create_user_command("CPNew", function(opts)
  local dir = opts.args
  vim.fn.mkdir(dir, "p")
  vim.fn.writefile({}, dir .. "/main.cpp")
  vim.fn.writefile({}, dir .. "/data")

  vim.cmd("edit " .. dir .. "/main.cpp | only")
  vim.cmd("vnew | edit " .. dir .. "/data")
  vim.cmd("vertical resize 44")
  vim.cmd("wincmd h")
  ls.snip_expand(cp_snippet)
end, { nargs = 1 })
