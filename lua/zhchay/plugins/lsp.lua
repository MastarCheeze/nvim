local servers = {
  lua_ls = {},
  ts_ls = true,
  html = true,
  cssls = true,
}

-- Setup LSP servers
local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
require("lazydev").setup({})

local capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities()
end

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, config)

  lspconfig[name].setup(config)
end

-- Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = args.buf
      vim.keymap.set(mode, l, r, opts)
    end
    local builtin = require("telescope.builtin")

    map("n", "gd", builtin.lsp_definitions, { desc = "Find definitions" })
    map("n", "gr", builtin.lsp_references, { desc = "Find references" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    map("n", "gT", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

    map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
    map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, { desc = "Show signature docs" })

    map("n", "<leader>lo", builtin.lsp_document_symbols, { desc = "Find document symbols" })
    map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "See all code actions" })
    map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
  end
})

-- Diagnostic symbols in the gutter
local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "󰋽" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
