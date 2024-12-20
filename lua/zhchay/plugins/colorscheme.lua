require("catppuccin").setup({
  flavour = "macchiato",
  color_overrides = {
    all = {
      base = "#141519", -- literally unusable without this bg colour
    },
  },
  integrations = {
    telescope = { enabled = true },
    gitsigns = true,
    indent_blankline = { enabled = true, scope_color = "overlay2" },
  },
})

vim.cmd.colorscheme("catppuccin")
