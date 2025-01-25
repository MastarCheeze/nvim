-- Icons
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- Explorer
require("oil").setup({
  delete_to_trash = true,
  view_options = {
    is_always_hidden = function(name, _)
      local always_hidden = { ".DS_Store", "__pycache__" }
      return vim.tbl_contains(always_hidden, name)
    end,
  },
  use_default_keymaps = false,
  keymaps = {
    ["<CR>"] = "actions.select",
    ["<ESC>"] = { "actions.close", mode = "n" },
    ["<BS>"] = { "actions.parent", mode = "n" },
    ["-"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gr"] = "actions.refresh",
    ["gx"] = "actions.open_external",
    ["g?"] = { "actions.show_help", mode = "n" },
  },
})
