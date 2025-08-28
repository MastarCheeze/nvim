-- All LSP servers installed using Mason will be automatically loaded by mason-lspconfig
-- Any extra configuration for LSP servers can be specified here
local servers = {
  html = {
    filetypes = { "html", "templ", "njk" },
  },

  emmet_language_server = {
    filetypes = {
      "css",
      "eruby",
      "html",
      "htmldjango",
      "javascriptreact",
      "less",
      "pug",
      "sass",
      "scss",
      "typescriptreact",
      "htmlangular",
      "njk",
    },
  },

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
require("lspconfig")

local capabilities = nil -- Autocompletion capabilities
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities()
end

for name, config in pairs(servers) do
  config = config or {}
  config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, config)
  vim.lsp.config(name, config)
end

require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
require("lazydev").setup({})

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
    map("n", "gR", builtin.lsp_references, { desc = "Find references" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })

    -- Documentation
    map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
    map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, { desc = "Show signature documentation" })

    -- LSP actions
    map("n", "<leader>lo", builtin.lsp_document_symbols, { desc = "Find document symbols" })
    map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "See all code actions" })
    map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })

    map("n", "<leader>ll", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
    map("n", "<leader>ld", builtin.diagnostics, { desc = "Show buffer diagnostics" })
    map("n", "]d", function()
      local jump = vim.diagnostic.get_next()
      vim.diagnostic.jump({ count = 1, float = true })
      if jump then
        vim.cmd("normal! zz")
      end
    end, { desc = "Next diagnostic" })
    map("n", "[d", function()
      local jump = vim.diagnostic.get_prev()
      vim.diagnostic.jump({ count = -1, float = true })
      if jump then
        vim.cmd("normal! zz")
      end
    end, { desc = "Previous diagnostic" })
  end,
})

-- Diagnostic popup window
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = { prefix = "" },
  float = {
    header = "",
    format = function(diagnostic)
      local source = diagnostic.source or ""
      source = source:sub(-1) == "." and source:sub(1, -2) or source
      source = " <" .. source .. ">"
      return diagnostic.message .. source
    end,
  },
  -- Diagnostic symbols in the gutter
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.HINT] = "󰌶",
      [vim.diagnostic.severity.INFO] = "󰋽",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
})

