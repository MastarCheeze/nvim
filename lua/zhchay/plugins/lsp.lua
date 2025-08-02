local servers = {
  lua_ls = nil,
  clangd = nil,
  pyright = nil,
  ts_ls = nil,
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
  cssls = nil,
  texlab = nil,
  vimls = nil,
  dockerls = nil,

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

require("mason").setup({ ui = { border = "rounded" } })
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
})

-- Diagnostic symbols in the gutter
local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "󰋽" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Command to print all attached clients
local function get_attached_clients()
  -- Get active clients for current buffer
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  local buf_ft = vim.bo.filetype
  local buf_client_names = {}
  local num_client_names = #buf_client_names

  -- Add lsp-clients active in the current buffer
  for _, client in pairs(buf_clients) do
    num_client_names = num_client_names + 1
    buf_client_names[num_client_names] = client.name
  end

  -- Add linters for the current filetype (nvim-lint)
  local lint_success, lint = pcall(require, "lint")
  if lint_success then
    for ft, ft_linters in pairs(lint.linters_by_ft) do
      if ft == buf_ft then
        if type(ft_linters) == "table" then
          for _, linter in pairs(ft_linters) do
            num_client_names = num_client_names + 1
            buf_client_names[num_client_names] = linter
          end
        else
          num_client_names = num_client_names + 1
          buf_client_names[num_client_names] = ft_linters
        end
      end
    end
  end

  -- Add formatters (conform.nvim)
  local conform_success, conform = pcall(require, "conform")
  if conform_success then
    for _, formatter in pairs(conform.list_formatters_for_buffer(0)) do
      if formatter then
        num_client_names = num_client_names + 1
        buf_client_names[num_client_names] = formatter
      end
    end
  end

  return buf_client_names
end

vim.api.nvim_create_user_command("AttachedClients", function()
  local clients = get_attached_clients()
  if #clients == 0 then
    print("No active clients")
  end
  print(table.concat(clients, ", "))
end, {})
