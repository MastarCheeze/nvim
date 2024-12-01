-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})
