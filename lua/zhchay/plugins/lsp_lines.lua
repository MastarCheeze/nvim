require("lsp_lines").setup()
vim.diagnostic.config({ virtual_text = true, virtual_lines = false }) -- initially off

vim.keymap.set("n", "<leader>ll", function()
  local config = vim.diagnostic.config() or {}
  if config.virtual_text then
    vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
  else
    vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
  end
end, { desc = "Toggle LSP details" })
