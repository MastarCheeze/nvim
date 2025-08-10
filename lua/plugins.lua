return {
  -- colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("plugins.colorscheme")
    end,
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.statusline")
    end,
  },
  -- file explorer
  {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      require("plugins.explorer")
    end,
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.telescope")
    end,
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
      "b0o/SchemaStore.nvim",
    },
    config = function()
      require("plugins.lsp")
    end,
  },
  -- formatter
  {
    "stevearc/conform.nvim",
    config = function()
      require("plugins.formatter")
    end,
  },
  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- sources
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim", -- nice icons
    },
    config = function()
      require("plugins.completion")
    end,
  },
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      require("plugins.snippets")
    end,
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("plugins.treesitter")
    end,
  },
  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indentblankline")
    end,
  },
  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  },
  -- save and restore sessions
  {
    "rmagatti/auto-session",
    config = function()
      require("plugins.autosession")
    end,
  },
  -- greeter
  {
    "goolord/alpha-nvim",
    config = function()
      require("plugins.greeter")
    end,
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
  -- jsdoc autogeneration
  {
    "heavenshell/vim-jsdoc",
    build = "make install", -- install dependency lehre via npm
    lazy = true,
    ft = { "javascript", "typescript" },
  },
}
