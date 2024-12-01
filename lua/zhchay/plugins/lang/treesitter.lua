require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
  },
  highlight = {
    enabled = true,
  },
  textobjects = {
    enabled = true,
  },
  indent = {
    enabled = true
  },
})
