local servers = {
  lua_ls = true,
  clangd = true,
  ts_ls = true,
  html = true,
  emmet_language_server = true,
  cssls = true,
  texlab = true,
  vimls = true,
  dockerls = true,

  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },

  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
}

-- Setup LSP servers
local lspconfig = require("lspconfig")
require("mason").setup({ ui = { border = "rounded" } })
require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
require("lazydev").setup({})

-- Autocompletion capabilities
local capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities()
end

-- Hover and signature popup window handlers
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    max_width = 120,
    border = "rounded",
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    max_width = 120,
    border = "rounded",
  }),
}

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities, handlers = handlers }, config)

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

    -- LSP find and go to hovered symbol
    map("n", "gd", builtin.lsp_definitions, { desc = "Find definitions" })
    map("n", "gr", builtin.lsp_references, { desc = "Find references" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    map("n", "gT", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

    -- Documentation
    map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
    map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, { desc = "Show signature documentation" })

    -- LSP actions
    map("n", "<leader>lo", builtin.lsp_document_symbols, { desc = "Find document symbols" })
    map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "See all code actions" })
    map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })

    map("n", "<leader>ll", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
    map("n", "<leader>ld", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Show buffer diagnostics" })
    map("n", "]d", function()
      local jump = vim.diagnostic.get_next()
      vim.diagnostic.goto_next({ float = true })
      if jump then
        vim.cmd("normal! zz")
      end
      -- vim.diagnostic.jump({ count = 1, float = true }) -- use these in 0.11
    end, { desc = "Next diagnostic" })
    map("n", "[d", function()
      local jump = vim.diagnostic.get_prev()
      vim.diagnostic.goto_prev({ float = true })
      if jump then
        vim.cmd("normal! zz")
      end
      -- vim.diagnostic.jump({ count = -1, float = true }) -- use these in 0.11
    end, { desc = "Previous diagnostic" })
  end,
})

-- Diagnostic popup window
local setting = require("zhchay.settings").diagnostic_source
vim.keymap.set("n", "<leader>'d", setting.toggle, { desc = "Toggle " .. setting.desc })

vim.diagnostic.config({
  virtual_text = { prefix = "" },
  float = {
    header = "",
    format = function(diagnostic)
      local source = ""
      if setting.value and diagnostic.source ~= nil then
        source = diagnostic.source
        ---@diagnostic disable-next-line: need-check-nil, cast-local-type
        source = source:sub(-1) == "." and source:sub(1, -2) or source
        source = " <" .. source .. ">"
      end
      return diagnostic.message .. source
    end,
    border = "rounded",
  },
})

-- Diagnostic symbols in the gutter
local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "󰋽" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
