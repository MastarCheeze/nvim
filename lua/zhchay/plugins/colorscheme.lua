require("catppuccin").setup({
  flavour = "macchiato",
  color_overrides = {
    all = {
      base = "#141519", -- literally unusable without this bg colour
    },
  },
  integrations = {
    telescope = { enabled = true },
  },
})

vim.cmd.colorscheme("catppuccin")

