local lint = require("lint")

vim.env.ESLINT_D_PPID = vim.fn.getpid() -- eslint_d needs this idk why

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
