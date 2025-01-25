-- Icons
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- Explorer
require("oil").setup({
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      local always_hidden = { ".DS_Store", "__pycache__" }
      return vim.tbl_contains(always_hidden, name)
    end,
  },
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-k>"] = false,
    ["<C-j>"] = false,
  },
})
