require("catppuccin").setup({
  flavour = "macchiato",
  color_overrides = {
    all = {
      base = "#141519", -- literally unusable without this bg colour
    },
  },
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
