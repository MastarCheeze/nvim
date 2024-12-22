local o = vim.opt

-- Gutter
o.number = true
o.relativenumber = true
o.signcolumn = "yes" -- always show sign column
o.cursorline = true -- highlights the current cursor line and line number
o.fillchars = { eob = " " } -- remove '~' characters from the gutter

-- Indentation
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.cindent = true

-- Window splitting
o.splitbelow = true
o.splitright = true

-- Search settings
o.ignorecase = true
o.smartcase = true

-- Display
o.colorcolumn = "120" -- editor ruler
o.wrap = false -- turn off line wrap
o.scrolloff = 8 -- always keep at least 8 lines above/below cursor

-- Misc
o.clipboard = "unnamedplus" -- use system clipboard as default
o.undofile = true -- persistent undo

-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

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
