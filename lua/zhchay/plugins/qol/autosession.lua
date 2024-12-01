require("auto-session").setup({
  auto_restore = true, -- TODO change this to false
  session_lens = { load_on_setup = false },
  suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  bypass_save_filetypes = { "neo-tree", "dashboard" },
})

vim.keymap.set("n", "<leader>'r", "<cmd>SessionRestore<cr>", { desc = "Restore previous session" })
