local map = vim.keymap.set

local cmd = "<cmd>Neotree position=current reveal<cr>"
local function opts(desc)
  return { desc = desc, noremap = true, silent = true }
end

map("n", "<leader>e", cmd, opts("Show file explorer"))
map("n", "<leader>seh", "<C-w>v<C-w>h" .. cmd, opts("Show file explorer in split to the left"))
map("n", "<leader>sel", "<C-w>v" .. cmd, opts("Show file explorer in split to the right"))
map("n", "<leader>sej", "<C-w>s" .. cmd, opts("Show file explorer in split below"))
map("n", "<leader>sek", "<C-w>s<C-w>k" .. cmd, opts("Show file explorer in split above"))

require("neo-tree").setup({
  window = {
    position = "current",
  },
  -- enabled sources
  sources = {
    "filesystem",
    "buffers",
    -- "git_status",
    -- "document_symbols",
  },
  -- filesystem source
  filesystem = {
    filtered_items = {
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_by_pattern = {
        ".DS_Store",
        "node_modules",
      },
      always_show_by_pattern = { -- uses glob style patterns
        ".gitignore",
      },
      never_show_by_pattern = { -- uses glob style patterns
        ".DS_Store",
      },
      show_hidden_count = true,
    },
    commands = {
      -- Override delete to use trash instead of rm
      delete = function(state)
        local inputs = require("neo-tree.ui.inputs")
        local path = state.tree:get_node().path
        local msg = "Trash " .. path .. "?"
        inputs.confirm(msg, function(confirmed)
          if not confirmed then return end

          vim.fn.system({ "trash", "-F", vim.fn.fnameescape(path) })
        end)
      end,
      -- over write default 'delete_visual' command to 'trash' x n.
      delete_visual = function(_, selected_nodes)
        local inputs = require("neo-tree.ui.inputs")

        -- get table items count
        function GetTableLen(tbl)
          local len = 0
          for _ in pairs(tbl) do
            len = len + 1
          end
          return len
        end

        local count = GetTableLen(selected_nodes)
        local msg = "Trash " .. count .. " files ?"
        inputs.confirm(msg, function(confirmed)
          if not confirmed then return end
          local toDelete = {}
          for _, node in ipairs(selected_nodes) do
            table.insert(toDelete, vim.fn.fnameescape(node.path))
          end
          vim.fn.system(vim.list_extend({ "trash", "-F" }, toDelete))
        end)
      end,
    },
    use_libuv_file_watcher = true,
  },
  -- buffer source
  buffers = {
    show_unloaded = true,
  },
  -- other config
  default_component_configs = {
    modified = {
      symbol = "●",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = "󱇬",
        deleted   = "󱘹",
        modified  = "󰏫",
        renamed   = "󰁕",
        -- Status type
        untracked = "",
        ignored   = "󰜥",
        unstaged  = "󱦰 󱈸",
        staged    = "󱦰 󰈻",
        conflict  = "",
      }
    },
    diagnostics = {
      symbols = {
        hint = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
        info = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
        warn = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
        error = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
      },
      highlights = {
        hint = "DiagnosticSignHint",
        info = "DiagnosticSignInfo",
        warn = "DiagnosticSignWarn",
        error = "DiagnosticSignError",
      },
    },
    -- info columns
    file_size = {
      enabled = true,
      required_width = 64, -- min width of window required to show this column
    },
    last_modified = {
      enabled = true,
      required_width = 80, -- min width of window required to show this column
    },
    type = { enabled = true },
    created = { enabled = false },
    symlink_target = { enabled = true },
  },
})
