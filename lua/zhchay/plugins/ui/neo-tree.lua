local map = vim.keymap.set
local utils = require("zhchay.utils")

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
  -- enabled sources
  sources = {
    "filesystem",
    "buffers",
  },
  popup_border_style = utils.border,
  use_default_mappings = false,
  window = {
    position = "current",
    -- mappings
    mappings = {
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["<esc>"] = "cancel",
      ["q"] = "close_window",
      ["C"] = "close_node",
      ["X"] = "close_all_nodes",
      ["Z"] = "expand_all_nodes",
      ["a"] = "add",
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy",
      ["m"] = "move",
      ["R"] = "refresh",
      ["\\"] = "next_source",
      ["?"] = "show_help",
    },
  },
  -- filesystem source
  filesystem = {
    window = {
      mappings = {
        ["I"] = "toggle_hidden",
        ["i"] = "show_file_details",
        ["/"] = "fuzzy_finder",
        ["#"] = "fuzzy_finder_directory",
        ["<C-x>"] = "clear_filter",
        ["."] = "set_root",
        ["<bs>"] = "navigate_up",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["og"] = { "order_by_git_status", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
      },
    },
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
    -- command overrides
    commands = {
      -- Override delete to use trash instead of rm
      delete = function(state)
        local inputs = require("neo-tree.ui.inputs")
        local path = state.tree:get_node().path
        local msg = "Trash " .. path .. "?"
        inputs.confirm(msg, function(confirmed)
          if not confirmed then
            return
          end

          vim.fn.system({ "trash", vim.fn.fnameescape(path) })
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
          if not confirmed then
            return
          end
          local toDelete = {}
          for _, node in ipairs(selected_nodes) do
            table.insert(toDelete, vim.fn.fnameescape(node.path))
          end
          vim.fn.system(vim.list_extend({ "trash" }, toDelete))
        end)
      end,
    },
    use_libuv_file_watcher = true,
  },
  -- buffer source
  buffers = {
    show_unloaded = true,
    window = {
      mappings = {
        ["."] = "set_root",
        ["<bs>"] = "navigate_up",
        ["d"] = "buffer_delete",
        ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
        ["i"] = { "show_file_details" },
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
        ["a"] = "none",
        ["A"] = "none",
        ["r"] = "none",
        ["y"] = "none",
        ["x"] = "none",
        ["p"] = "none",
        ["c"] = "none",
        ["m"] = "none",
      },
    },
  },
  -- other config
  default_component_configs = {
    modified = {
      symbol = "●",
    },
    git_status = {
      symbols = {
        -- Change type
        added = "󱇬",
        deleted = "󱘹",
        modified = "󰏫",
        renamed = "󰁕",
        -- Status type
        untracked = "",
        ignored = "󰜥",
        unstaged = "󱦰 󱈸",
        staged = "󱦰 󰈻",
        conflict = "",
      },
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
    },
    last_modified = {
      enabled = true,
      width = 15,
      format = function(seconds)
        local now = os.time()
        local diff = now - seconds

        local function pluralise(value, unit)
          return value .. " " .. unit .. (value == 1 and "" or "s") .. " ago"
        end

        if diff < 60 then
          return "Just now"
        elseif diff < 3600 then
          local minutes = math.floor(diff / 60)
          return pluralise(minutes, "minute")
        elseif diff < 86400 then
          local hours = math.floor(diff / 3600)
          return pluralise(hours, "hour")
        elseif diff < 86400 * 30 then
          local days = math.floor(diff / 86400)
          return pluralise(days, "day")
        elseif diff < 86400 * 365 then
          local months = math.floor(diff / (86400 * 30))
          return pluralise(months, "month")
        else
          local years = math.floor(diff / (86400 * 365))
          return pluralise(years, "year")
        end
      end,
    },
    type = { enabled = true },
    created = { enabled = false },
    symlink_target = { enabled = true },
  },
})
