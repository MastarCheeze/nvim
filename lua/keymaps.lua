local map = vim.keymap.set
vim.g.mapleader = " "

-- Write buffer
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Write buffer" })
map("n", "<leader>W", "<cmd>wa<cr>", { desc = "Write all buffer" })

-- File explorer
map("n", "<leader>e", ":Oil<cr>", { silent = true, desc = "Show file explorer" })

-- Window navigation
map({ "n", "i", "v" }, "<C-h>", "<C-w>h", { desc = "Move to left window" })
map({ "n", "i", "v" }, "<C-l>", "<C-w>l", { desc = "Move to right window" })
map({ "n", "i", "v" }, "<C-j>", "<C-w>j", { desc = "Move to window below" })
map({ "n", "i", "v" }, "<C-k>", "<C-w>k", { desc = "Move to window above" })
map({ "n", "i", "v" }, "<C-w>d", "<C-w>c", { desc = "Close window" }) -- <C-w><C-c> can't be remapped because <C-c> cancels the command
map({ "n", "i", "v" }, "<C-w><C-d>", "<C-w>c", { desc = "Close window" })

-- Tab navigation
map({ "n", "i", "v" }, "<C-t>t", "<cmd>tabnew<cr>", { desc = "New tab" })
map({ "n", "i", "v" }, "<C-t><C-t>", "<cmd>tabnew<cr>", { desc = "New tab" })
map({ "n", "i", "v" }, "<C-t>d", "<cmd>tabclose<cr>", { desc = "Close tab" })
map({ "n", "i", "v" }, "<C-t><C-d>", "<cmd>tabclose<cr>", { desc = "Close tab" })
map({ "n", "v" }, "<C-t>p", "<cmd>tabprevious<cr>", { desc = "Previous tab" }) -- can't set insert mode for this because issue with tmux (^[ is the escape sequence)
map({ "n", "v" }, "<C-t><C-p>", "<cmd>tabprevious<cr>", { desc = "Previous tab" }) -- can't set insert mode for this because issue with tmux (^[ is the escape sequence)
map({ "n", "i", "v" }, "<C-t>n", "<cmd>tabnext<cr>", { desc = "Next tab" })
map({ "n", "i", "v" }, "<C-t><C-n>", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- Custom text-editing actions
map({ "n", "v" }, "<leader>d", '"_d', { noremap = true, desc = "Delete to void register" })
-- map("n", "<leader>vo", "o<esc>o<esc>", { desc = "Insert two newlines below" })
-- map("n", "<leader>vO", "O<esc>O<esc>", { desc = "Insert two newlines above" })
-- map("n", "<leader>vp", "O<esc>jo<esc>k", { desc = "Pad with newlines above and below" })
map("n", "<leader>va", "ggVG", { desc = "Select entire buffer" })
map("n", "<leader>vr", ":%s/", { desc = "Replace text" })

-- Sourcing files
map("n", "<leader><leader>x", "<cmd>w<cr><cmd>source %<cr>", { desc = "Execute the current file" })
map("n", "<leader><leader>X", "<cmd>.lua<cr>", { desc = "Execute the current line" })
map("v", "<leader><leader>X", "<cmd>lua<cr>", { desc = "Execute the current selection" })

-- QOL changes
map("n", "<C-d>", "<C-d>zz", { noremap = true }) -- center cursor on screen when moving with <C-u> and <C-d>
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map("n", "n", "nzzzv", { noremap = true }) -- center cursor on screen when jumping between search results
map("n", "N", "Nzzzv", { noremap = true })
map({ "n", "v" }, "<esc>", "<cmd>noh<cr>", { desc = "Clear highlights" }) -- clear highlights from searching
