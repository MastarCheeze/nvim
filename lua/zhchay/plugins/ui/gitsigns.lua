require("gitsigns").setup({
  signs_staged_enable = false,
})

local map = vim.keymap.set
local wkAdd = require("zhchay.utils").wkAdd

map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "gitsigns Git diff" })
map("n", "<leader>gl", "<cmd>Gitsigns blame<cr>", { desc = "gitsigns Git blame" })

map("n", "<leader>il", "<cmd>Gitsigns blame_line<cr>", { desc = "Show line git blame" })

map("n", "<leader>'d", "<cmd>Gitsigns toggle_deleted<cr>", { desc = "Toggle deleted" })
map("n", "<leader>'l", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle current line blame" })
