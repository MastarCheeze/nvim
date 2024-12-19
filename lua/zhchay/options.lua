local o = vim.opt

-- Line numbers
o.number = true
o.relativenumber = true
o.signcolumn = "yes" -- always show sign column
o.fillchars = { eob = " " } -- remove '~' characters from the gutter

-- Indentation
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.cindent = true

-- Window splitting
o.splitbelow = true
o.splitright = true

-- Search settings
o.ignorecase = true
o.smartcase = true

-- Misc
o.wrap = false -- turn off line wrap
o.scrolloff = 8 -- always keep at least 8 lines above/below cursor
o.clipboard = "unnamedplus" -- use system clipboard as default

