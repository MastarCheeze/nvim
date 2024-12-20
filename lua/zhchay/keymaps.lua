local map = vim.keymap.set
vim.g.mapleader = " "

-- File explorer
map("n", "<leader>e", ":e .<cr>", { desc = "Show file explorer" })

-- Comments
map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
map("n", "<C-w>d", "<C-w>c", { desc = "Close window" }) -- <C-w><C-c> can't be remapped because <C-c> cancels the command
map("n", "<C-w><C-d>", "<C-w>c", { desc = "Close window" })

-- Tab navigation
map("n", "<C-,>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<C-.>", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- Custom text-editing actions
map("n", "<leader>vo", "o<esc>o", { desc = "Insert two newlines below cursor" })
map("n", "<leader>vO", "O<esc>O", { desc = "Insert two newlines above cursor" })
map("n", "<leader>vp", "O<esc>jo<esc>k", { desc = "Pad current line with newlines above and below" })
map({ "n", "v" }, "<leader>vd", "\"_d", { noremap = true, desc = "Delete to void register" })

-- Settings
map("n", "<leader>'n", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative line number" })
map("n", "<leader>'x", "<cmd>w<cr><cmd>source %<cr>", { desc = "Execute the current file" })
map("n", "<leader>'X", "<cmd>.lua<cr>", { desc = "Execute the current line" })

-- QOL changes
map("n", "<C-d>", "<C-d>zz", { noremap = true }) -- center cursor on screen when moving with <C-u> and <C-d>
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map("n", "n", "nzzzv", { noremap = true }) -- center cursor on screen when jumping between search results
map("n", "N", "Nzzzv", { noremap = true })
map({ "n", "v" }, "<esc>", "<cmd>noh<cr>", { desc = "Clear highlights" }) -- clear highlights from searching
