require("auto-session").setup({
  auto_restore = false,
  bypass_save_filetypes = {},
})

vim.keymap.set("n", "<leader>'r", "<cmd>SessionRestore<cr>", { desc = "Restore previous session" })
