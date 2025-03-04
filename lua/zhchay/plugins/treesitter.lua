local ts = require("nvim-treesitter.configs")

---@diagnostic disable-next-line: missing-fields
ts.setup({
  ensure_installed = {
    "lua",
    "c",
    "cpp",
    "cmake",
    "python",
    "typescript",
    "javascript",
    "html",
    "css",
    "markdown",
    "latex",
    "gitignore",
    "vim",
    "vimdoc",
    "dockerfile",
  },
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = false },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ir"] = "@parameter.inner",
        ["ar"] = "@parameter.outer",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
      },
      selection_modes = {
        ["@parameter.inner"] = "v", -- charwise
        ["@parameter.outer"] = "v", -- charwise
        ["@block.inner"] = "V", -- linewise
        ["@block.outer"] = "V", -- linewise
      },
      include_surrounding_whitespace = true,
    },
  },
})
