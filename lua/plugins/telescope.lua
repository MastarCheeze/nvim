require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      ".git/",
    },
    mappings = {
      i = {
        ["<C-y>"] = require("telescope.actions").select_default,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

-- Keymaps
local map = vim.keymap.set
local builtin = require("telescope.builtin")

map("n", "<leader>f", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>o", builtin.oldfiles, { desc = "Telescope find old files" })
map("n", "<leader>g", function()
  if not pcall(builtin.git_status) then
    vim.notify("The current directory is not a git repository.")
  end
end, { desc = "Telescope git status" })
map("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>u", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>i", builtin.current_buffer_fuzzy_find, { desc = "Telescope find in buffer" })
map("n", "<leader>?", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>\\", builtin.builtin, { desc = "Telescope all pickers" })

-- Dim background when picker is open
local blend = 50

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function(ctx)
    local backdropName = "TelescopeBackdrop"
    local telescopeBufnr = ctx.buf

    -- `Telescope` does not set a zindex, so it uses the default value
    -- of `nvim_open_win`, which is 50: https://neovim.io/doc/user/api.html#nvim_open_win()
    local telescopeZindex = 50

    local backdropBufnr = vim.api.nvim_create_buf(false, true)
    local winnr = vim.api.nvim_open_win(backdropBufnr, false, {
      relative = "editor",
      row = 0,
      col = 0,
      width = vim.o.columns,
      height = vim.o.lines - 2,
      focusable = false,
      style = "minimal",
      zindex = telescopeZindex - 1, -- ensure it's below the reference window
    })

    vim.api.nvim_set_hl(0, backdropName, { bg = "#000000", default = true })
    vim.wo[winnr].winhighlight = "Normal:" .. backdropName
    vim.wo[winnr].winblend = blend
    vim.bo[backdropBufnr].buftype = "nofile"

    -- close backdrop when the reference buffer is closed
    vim.api.nvim_create_autocmd({ "WinClosed", "BufLeave" }, {
      once = true,
      buffer = telescopeBufnr,
      callback = function()
        if vim.api.nvim_win_is_valid(winnr) then
          vim.api.nvim_win_close(winnr, true)
        end
        if vim.api.nvim_buf_is_valid(backdropBufnr) then
          vim.api.nvim_buf_delete(backdropBufnr, { force = true })
        end
      end,
    })
  end,
})
