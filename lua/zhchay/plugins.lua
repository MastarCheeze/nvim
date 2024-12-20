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
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("zhchay.plugins.telescope") end,
  },
  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("zhchay.plugins.gitsigns") end,
  },
  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("zhchay.plugins.indentblankline") end,
  },
  -- save and restore sessions
  {
    "rmagatti/auto-session",
    config = function() require("zhchay.plugins.autosession") end,
  },
  -- actions for surrounding pairs
  {
    "echasnovski/mini.surround",
    version = false,
    opts = {},
  },
  -- automatically insert closing pairs
  {
    "windwp/nvim-autopairs",
    opts = { disable_filetype = { "TelescopePrompt" } },
  },
  -- scroll past the end of the buffer
  {
    "Aasim-A/scrollEOF.nvim",
    opts = {},
  },
}
