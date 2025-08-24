require("mason").setup({ ui = { border = "rounded" } })

-- Command to print all attached clients
local function get_attached_clients()
  local clients = {
    lsp = {},
    linter = {},
    formatter = {},
  }

  -- Add lsp-clients active in the current buffer
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in pairs(buf_clients) do
    table.insert(clients.lsp, client.name)
  end

  -- Add linters for the current filetype (nvim-lint)
  local lint_success, lint = pcall(require, "lint")
  local buf_ft = vim.bo.filetype
  if lint_success then
    for ft, ft_linters in pairs(lint.linters_by_ft) do
      if ft == buf_ft then
        if type(ft_linters) == "table" then
          for _, linter in pairs(ft_linters) do
            table.insert(clients.linter, linter)
          end
        else
          table.insert(clients.linter, ft_linters)
        end
      end
    end
  end

  -- Add formatters (conform.nvim)
  local conform_success, conform = pcall(require, "conform")
  if conform_success then
    for _, formatter in pairs(conform.list_formatters_for_buffer(0)) do
      if formatter then
        table.insert(clients.formatter, formatter)
      end
    end
  end

  return clients
end

vim.api.nvim_create_user_command("AttachedClients", function()
  local clients = get_attached_clients()
  local out = ""

  out = out .. "LSPs: { " .. table.concat(clients.lsp, ", ") .. " }, "
  out = out .. "Linters: { " .. table.concat(clients.linter, ", ") .. " }, "
  out = out .. "Formatters: { " .. table.concat(clients.formatter, ", ") .. " }"

  print(out)
end, {})
