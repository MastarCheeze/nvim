require("barbecue").setup({
  show_dirname = false,
  show_basename = true,
  show_modified = true,
  create_autocmd = false, -- prevent barbecue from updating itself automatically
})

vim.api.nvim_create_autocmd({
  "WinResized",
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",
  "BufModifiedSet",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})

vim.keymap.set("n", "<leader>'b", "<cmd>Barbecue toggle<cr>", { desc = "Toggle breadcrumbs" })
