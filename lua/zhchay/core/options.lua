local o = vim.opt

-- Line numbers
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.signcolumn = "yes"

-- Tabs, indentation and whitespace
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.cindent = true

-- Search
o.ignorecase = true
o.smartcase = true

-- Window splitting
o.splitbelow = true
o.splitright = true

-- Editor UI
o.cursorline = true
o.cursorlineopt = "both"
o.colorcolumn = "120" -- editor ruler
o.showmode = false
o.laststatus = 3      -- always show status line
o.showtabline = 0
o.wrap = false
o.scrolloff = 8             -- always keep 8 at least 8 lines above/below cursor
o.fillchars = { eob = " " } -- remove tildes from gutter when there is no text

-- Backup files
o.undofile = true
o.updatetime = 250

o.timeoutlen = 400 -- duration until keymap times out
o.mouse = "a"      -- this is for your own good

-- Use system clipboard as default
o.clipboard = "unnamedplus"
