return {
  -- colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function() require("zhchay.plugins.colorscheme") end,
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("zhchay.plugins.statusline") end,
  },
}
