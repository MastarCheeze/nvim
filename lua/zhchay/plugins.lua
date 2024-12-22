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
  -- explorer
  {
    "echasnovski/mini.files",
    version = false,
    config = function() require("zhchay.plugins.explorer") end,
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("zhchay.plugins.telescope") end,
  },
  -- lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "folke/lazydev.nvim", -- configure LSP for neovim config, runtime and plugins
        ft = "lua",
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function() require("zhchay.plugins.lsp") end,
  },
  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim", -- nice icons
    },
    config = function() require("zhchay.plugins.completion") end,
  },
  -- formatter
  {
      "stevearc/conform.nvim",
      config = function() require("zhchay.plugins.formatter") end,
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function() require("zhchay.plugins.treesitter") end,
  },
  -- better diagnostics virtual text
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function() require("zhchay.plugins.lsp_lines") end,
  },
  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("zhchay.plugins.indentblankline") end,
  },
  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
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
