require("catppuccin").setup({
  flavour = "mocha",
  color_overrides = {
    all = {
      base = "#12121C", -- darker bg colours (hsl lightness -6)
      mantle = "#0C0C13",
      crust = "#060609",
    },
  },
  custom_highlights = function(colours)
    return {
      AlphaHeader1 = { fg = colours.blue, style = { "bold" } },
      AlphaHeader2 = { fg = colours.green, style = { "bold" } },
    }
  end,
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
    neotree = true,
    alpha = true,
    mason = true,
    gitsigns = true,
    indent_blankline = { enabled = true, scope_color = "overlay2" },
  },
})

vim.cmd.colorscheme("catppuccin")
