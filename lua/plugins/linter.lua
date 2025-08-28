local lint = require("lint")

vim.env.ESLINT_D_PPID = vim.fn.getpid() -- eslint_d needs this idk why

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "InsertLeave" }, {
  callback = function()
    -- check if eslint config exists
    if vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
      local eslintConfigFilenames = {
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc.cjs",
      }
      if vim.fs.root(0, eslintConfigFilenames) == nil then
        return
      end
    end

    lint.try_lint()
  end,
})
