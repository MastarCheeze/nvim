local conform = require("conform")

conform.formatters.prettier = {
  prepend_args = { "--prose-wrap=always" }, -- for markdown line wrap
}

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})

-- Format keymap (use)
vim.keymap.set({ "n", "v" }, "gq", function()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format buffer" })
