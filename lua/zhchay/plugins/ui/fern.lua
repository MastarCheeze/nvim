vim.g["fern#disable_default_mappings"] = 1
vim.g["fern#default_hidden"] = 1
vim.g["fern#renderer"] = "nerdfont"

vim.g["fern#default_exclude"] = "\\.git$\\|\\.DS_Store$"

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>e", "<cmd>Fern . -reveal=%<cr>", { desc = "Show file explorer", noremap = true, silent = true })

local fern_custom_id = vim.api.nvim_create_augroup("fern-custom", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fern",
  callback = function()
    -- nice color
    vim.fn["glyph_palette#apply"]()

    -- fern keymaps
    map("n", "<Plug>(fern-custom-open)", function()
      return vim.fn["fern#smart#root"](
        "<Plug>(fern-action-leave)",
        "<Plug>(fern-custom-open-expand)"
      )
    end, { expr = true, noremap = true })
    map("n", "<Plug>(fern-custom-open-expand)", function()
      return vim.fn["fern#smart#leaf"](
        "<Plug>(fern-action-open)",
        "<Plug>(fern-action-expand:stay)",
        "<Plug>(fern-action-collapse)"
      )
    end, { expr = true, noremap = true })

    map("n", "N", "<Plug>(fern-action-new-file)", { buffer = true, desc = "fern New file" })
    map("n", "K", "<Plug>(fern-action-new-dir)", { buffer = true, desc = "fern New directory" })
    map("n", "D", "<Plug>(fern-action-trash)", { buffer = true, desc = "fern Trash" })

    map("n", "c", "<Plug>(fern-action-copy)", { buffer = true, desc = "fern Copy" })
    map("n", "m", "<Plug>(fern-action-move)", { buffer = true, desc = "fern Move" })
    map("n", "r", "<Plug>(fern-action-rename)", { buffer = true, desc = "fern Rename" })
    map("n", "-", "<Plug>(fern-action-mark:toggle)", { buffer = true, desc = "fern Toggle" })
    map("v", "-", "<Plug>(fern-action-mark:toggle)", { buffer = true, desc = "fern Toggle" })

    map("n", "<cr>", "<Plug>(fern-custom-open)", { buffer = true, desc = "fern Open" })
    map("n", "o", "<Plug>(fern-action-enter)", { buffer = true, desc = "fern Enter" })
    map("n", "i", "<Plug>(fern-action-hidden:toggle)", { buffer = true, desc = "fern Toggle hidden" })
    map("n", "l", "<Plug>(fern-action-expand-tree:stay)", { buffer = true, desc = "fern Expand recursively" })
  end,
  group = fern_custom_id,
})
