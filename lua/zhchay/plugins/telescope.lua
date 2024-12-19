-- Keymaps
local map = vim.keymap.set
local builtin = require("telescope.builtin")

map("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>o", builtin.oldfiles, { desc = "Telescope find old files" })
map("n", "<leader>g", builtin.git_status, { desc = "Telescope git status" })
map("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>u", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>i", builtin.current_buffer_fuzzy_find, { desc = "Telescope find in buffer" })
map("n", "<leader>?", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>\\", builtin.builtin, { desc = "Telescope all pickers" })
