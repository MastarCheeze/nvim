local install = {
  -- UI
  { "tanvirtin/monokai.nvim" },                 -- colorscheme
  { "folke/which-key.nvim" },                   -- keybind guide
  { "ibhagwan/fzf-lua" },                       -- fuzzy finder and picker
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    }
  },
  { "nvim-lualine/lualine.nvim" }, -- status line
  { "lewis6991/gitsigns.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  -- Editor
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
    },
  },
  { "nvim-treesitter/nvim-treesitter",    build = ":TSUpdate" },
  { "windwp/nvim-autopairs" },
  { "kylechui/nvim-surround" },

  -- QOL tweaks
  { "Aasim-A/scrollEOF.nvim" },              -- scroll past the end of buffer
  { "lukas-reineke/indent-blankline.nvim" }, -- indentation guides
  { "rmagatti/auto-session" },               -- restore last session
  {
    "utilyre/barbecue.nvim",
    dependencies = { "SmiteshP/nvim-navic" },
  }, -- vscode-like breadcrumbs
}

local load = {
  "ui.which-key",
  "ui.fzf-lua",
  "ui.neo-tree",
  "ui.lualine",
  "ui.gitsigns",
  "editor.lsp",
  "editor.cmp",
  "editor.treesitter",
  "editor.autopairs",
  "editor.surround",
  "qol.indent-blankline",
  "qol.scrolleof",
  "qol.autosession",
  "qol.barbecue",
}

-- Setup
require("zhchay.plugins.lazy").install(install)
local after = require("zhchay.plugins.ui.colorscheme")
for _, name in ipairs(load) do
  require("zhchay.plugins." .. name)
end
after()
