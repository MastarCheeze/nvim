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
o.formatoptions:remove("c")
o.formatoptions:remove("r")
o.formatoptions:remove("o")

-- Window splitting
o.splitbelow = true
o.splitright = true

-- Search settings
o.ignorecase = true
o.smartcase = true

-- Display
o.colorcolumn = "120" -- editor ruler
o.wrap = false -- turn off line wrap
o.scrolloff = 8 -- always keep at least 8 lines above/below cursor

-- Misc
o.clipboard = "unnamedplus" -- use system clipboard as default
o.undofile = true -- persistent undo

-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})
