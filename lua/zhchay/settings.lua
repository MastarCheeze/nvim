-- Settings
local M = {}

M.diagnostic_source = {
  value = false,
  desc = "diagnostic source in popup window",
  toggle = function()
    M.diagnostic_source.value = not M.diagnostic_source.value
    local s = M.diagnostic_source.value and "on" or "off"
    vim.notify("Toggled " .. M.diagnostic_source.desc .. " to " .. s)
  end,
}

-- Keymaps
vim.keymap.set("n", "<leader>'n", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative line number" })

return M
