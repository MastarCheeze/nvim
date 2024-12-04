local map = vim.keymap.set
vim.g.mapleader = " "
local wkAdd = require("zhchay.utils").wkAdd

-- TODO move all keymaps here

-- Habit keymaps
-- map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write buffer" })
-- map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all windows" })
map("n", "<leader>n", "mqHmwgg=G`wzt`q", { desc = "Format buffer indentation" })

-- Copy and paste
map("x", "<leader>p", "\"_dP", { noremap = true, desc = "Paste over & retain buffer" })
map({ "n", "v" }, "<leader>d", "\"_d", { noremap = true, desc = "Delete to void register" })

-- Comments
map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })

-- Text actions
wkAdd({ "<leader>v", group = "Text actions" })
map("n", "<leader>vo", "O<esc>O", { desc = "Insert two newlines above cursor" })
map("n", "<leader>vp", "O<esc>jo<esc>k", { desc = "Pad current line with newlines above and below" })
map("n", "<leader>vr", ":%s/\\<<c-r><c-w>\\>//g<left><left>", { desc = "Replace word under cursor" })

-- Move cursor between windows
map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

-- Window management
wkAdd({ "<leader>s", group = "Windows" })
map("n", "<leader>sh", "<C-w>v<C-w>h", { desc = "Split window to the left" })
map("n", "<leader>sl", "<C-w>v", { desc = "Split window to the right" })
map("n", "<leader>sj", "<C-w>s", { desc = "Split window below" })
map("n", "<leader>sk", "<C-w>s<C-w>k", { desc = "Split window above" })
map("n", "<leader>sd", "<cmd>close<cr>", { desc = "Close current split" })

-- Tab management
wkAdd({ "<leader>t", group = "Tabs" })
-- <leader>tt FzfLua tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Open new tab" })
map("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close current tab" })
map("n", "]t", "<cmd>tabn<cr>", { desc = "Go to next tab" })
map("n", "[t", "<cmd>tabp<cr>", { desc = "Go to previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<cr>", { desc = "Open current buffer in new tab" })

-- Shift selected lines
map("v", "J", ":m '>+1<cr>gv=gv", { silent = true, desc = "Shift lines up" })
map("v", "K", ":m '<-2<cr>gv=gv", { silent = true, desc = "Shift lines down" })

-- Settings
wkAdd({ "<leader>'", group = "Settings" })
map("n", "<leader>'n", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative line number" })
-- more settings in respective plugins

-- QOL changes --
-- center cursor on screen when moving vertically
map("n", "<C-d>", "<C-d>zz", { noremap = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })

-- clear highlights using esc
map({ "n", "v" }, "<esc>", "<cmd>noh<cr>", { desc = "Clear highlights" })
