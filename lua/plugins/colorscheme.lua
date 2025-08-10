require("catppuccin").setup({
  flavour = "mocha",
  color_overrides = {
    all = {
      base = "#12121C", -- darker bg colours
      mantle = "#060609",
      crust = "#000000",
    },
  },
  custom_highlights = function(colours)
    return {
      WinSeparator = { fg = colours.overlay0 },
      -- duotone neovim greeter header
      AlphaHeader1 = { fg = colours.blue, style = { "bold" } },
      AlphaHeader2 = { fg = colours.green, style = { "bold" } },
      -- set neotree background to base
      NeoTreeNormal = { fg = colours.text, bg = colours.base },
      NeoTreeNormalNC = { fg = colours.text, bg = colours.base },
    }
  end,
  default_integrations = false,
  integrations = {
    telescope = { enabled = true },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
        ok = { "italic" },
      },
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
        ok = { "undercurl" },
      },
      inlay_hints = {
        background = true,
      },
    },
    cmp = true,
    neotree = true,
    alpha = true,
    mason = true,
    gitsigns = true,
    indent_blankline = { enabled = true, scope_color = "overlay2" },
  },
})

vim.cmd.colorscheme("catppuccin")
