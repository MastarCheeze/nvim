local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

local utils = require("zhchay.utils")

-- LSPs to install
local servers = {
  "lua_ls",
}
--

-- Mason setup
mason.setup()
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- Autocompletion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Hover and signature popup window handlers
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    max_width = 64,
    border = utils.border,
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    max_width = 64,
    border = utils.border,
  }),
}

-- Setup LSP server configurations
for _, name in ipairs(servers) do
  local modulePath = "zhchay.plugins.editor.lsp_config." .. name
  local config = {}
  if utils.moduleExists(modulePath) then
    config = require(modulePath)
  end
  config.capabilities = capabilities
  config.handlers = handlers
  lspconfig[name].setup(config)
end

-- Keymaps (buffer specific)
local map = vim.keymap.set
local wkAdd = utils.wkAdd

local function on_attach(args)
  local function opts(desc)
    return { noremap = true, silent = true, buffer = args.buf, desc = desc }
  end

  wkAdd({ "<leader>l", group = "LSP" })
  map("n", "<leader>lf", "<cmd>FzfLua lsp_references<cr>", opts("fzf References"))
  map("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<cr>", opts("fzf Definitions"))
  map("n", "<leader>lc", "<cmd>FzfLua lsp_declarations<cr>", opts("fzf Declarations"))
  -- map("n", "<leader>lt", "<cmd>FzfLua lsp_typedefs<cr>", opts("fzf Type definitions"))
  -- map("n", "<leader>lm", "<cmd>FzfLua lsp_implementations<cr>", opts("fzf Implementations"))
  map("n", "<leader>lo", "<cmd>FzfLua lsp_document_symbols<cr>", opts("fzf Symbols"))
  map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts("See all code actions"))
  map("n", "<leader>lr", vim.lsp.buf.rename, opts("Rename symbol"))

  wkAdd({ "<leader>i", group = "Diagnostics" })
  map("n", "<leader>ii", vim.diagnostic.open_float, opts("Show line diagnostics"))
  map("n", "<leader>io", "<cmd>FzfLua diagnostics_document<cr>", opts("Show buffer diagnostics"))
  map("n", "]d", function()
    local jump = vim.diagnostic.get_next()
    vim.diagnostic.goto_next({ float = true })
    if jump then
      vim.cmd("normal! zz")
    end
    -- vim.diagnostic.jump({ count = 1, float = true }) -- use these in 0.11
  end, opts("Next diagnostic"))
  map("n", "[d", function()
    local jump = vim.diagnostic.get_prev()
    vim.diagnostic.goto_prev({ float = true })
    if jump then
      vim.cmd("normal! zz")
    end
    -- vim.diagnostic.jump({ count = -1, float = true }) -- use these in 0.11
  end, opts("Previous diagnostic"))

  map("n", "K", vim.lsp.buf.hover, opts("Show hover docs"))
  map({ "n", "i" }, "<C-S>", vim.lsp.buf.signature_help, opts("Show signature docs"))

  vim.api.nvim_buf_create_user_command(args.buf, "Format", function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = "Format buffer with LSP" })
  map("n", "<leader>m", "<cmd>Format<cr>", { desc = "Format buffer" })
end

vim.api.nvim_create_autocmd("LspAttach", { -- setup keymaps on attach
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = on_attach,
})

-- Diagnostic popup window
vim.diagnostic.config({
  virtual_text = { prefix = "" },
  float = {
    header = "",
    format = function(diagnostic)
      return diagnostic.message .. " [" .. diagnostic.source .. "]"
    end,
    border = utils.border,
  },
})

-- Diagnostic symbols in the gutter
local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "󰋽" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
