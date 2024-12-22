local ts = require("nvim-treesitter.configs")

---@diagnostic disable-next-line: missing-fields
ts.setup({
  ensure_installed = {
    "lua",
    "typescript",
    "javascript",
    "html",
    "css",
    "markdown",
    "latex",
    "gitignore",
  },
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        ["ir"] = "@parameter.inner",
        ["ar"] = "@parameter.outer",
      },
    }
  }
})
