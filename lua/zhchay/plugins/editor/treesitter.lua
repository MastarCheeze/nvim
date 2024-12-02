require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
  },
  highlight = {
    enabled = true,
  },
  incremental_selection = {
    enabled = true,
  },
  text_objects = {
    enabled = true, -- TODO set this up sometime (see joseans video)
  },
  indent = { enabled = true },
})
