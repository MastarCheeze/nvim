-- Keymaps
local map = vim.keymap.set
local wkAdd = require("zhchay.utils").wkAdd

map("n", "<leader>f", "<cmd>FzfLua files<cr>", { desc = "fzf Files" })
map("n", "<leader>o", "<cmd>FzfLua oldfiles<cr>", { desc = "fzf Oldfiles" })
map("n", "<leader>u", "<cmd>FzfLua live_grep<cr>", { desc = "fzf Grep" })
map("n", "<leader>b", "<cmd>FzfLua buffers<cr>", { desc = "fzf Buffers" })
map("n", "<leader>tt", "<cmd>FzfLua tabs<cr>", { desc = "fzf Tabs" })
map("n", "<leader>r", "<cmd>FzfLua registers<cr>", { desc = "fzf Registers" })
map("n", "<leader>?", "<cmd>FzfLua helptags<cr>", { desc = "fzf Help tags" })

wkAdd({ "<leader>g", group = "Git viewers" })
map("n", "<leader>gc", "<cmd>FzfLua git_commits<cr>", { desc = "fzf Git commits" })
map("n", "<leader>gx", "<cmd>FzfLua git_bcommits<cr>", { desc = "fzf Git buffer commits" })
map("n", "<leader>gb", "<cmd>FzfLua git_branches<cr>", { desc = "fzf Git branches" })
map("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", { desc = "fzf Git status" })

-- LSP
-- <leader>l
-- keymaps in editor/lsp.lua
