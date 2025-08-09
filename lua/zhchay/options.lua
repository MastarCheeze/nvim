local o = vim.opt

-- Gutter
o.number = true
o.relativenumber = true
o.signcolumn = "yes" -- always show sign column
o.cursorline = true -- highlights the current cursor line and line number
o.fillchars = { eob = " " } -- remove '~' characters from the gutter

-- Indentation
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.cindent = true

-- Disable comment continuation on newlines
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Disable comment continuation on newlines",
  group = vim.api.nvim_create_augroup("CommentFormatOpt", { clear = true }),
  callback = function()
    o.formatoptions:remove("c")
    o.formatoptions:remove("r")
    o.formatoptions:remove("o")
  end,
})

-- Window splitting
o.splitbelow = true
o.splitright = true

-- Search settings
o.ignorecase = true
o.smartcase = true

-- Display
o.colorcolumn = "120" -- editor ruler
o.wrap = false -- turn off line wrap
o.scrolloff = 4 -- always keep at least 8 lines above/below cursor

-- Misc
o.clipboard = "unnamedplus" -- use system clipboard as default
o.undofile = true -- persistent undo
o.mousemodel = "extend" -- disable the right click mouse menu
o.winborder = "rounded" -- set border on popups like signature help and documentation

-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight selection on yank",
  group = vim.api.nvim_create_augroup("TextYankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

-- Register some filetypes
local register_filetype = function(pattern, filetype, syntax)
  vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    desc = "Register filetypes",
    group = vim.api.nvim_create_augroup("RegisterFiletypes", { clear = true }),
    pattern = pattern,
    callback = function()
      o.filetype = filetype
      o.syntax = syntax
    end,
  })
end
register_filetype("*.njk", "njk", "html")
