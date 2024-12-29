require("auto-session").setup({
  auto_restore = false,
  bypass_save_filetypes = { "alpha" },
})

vim.keymap.set("n", "<leader><leader>r", "<cmd>SessionRestore<cr>", { desc = "Restore previous session" })
