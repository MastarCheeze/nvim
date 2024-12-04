require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "javascript",
    "typescript",
    "html",
    "css",
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
