local map = vim.keymap.set

map(
  "n", "<leader>e", "<cmd>Neotree position=current reveal<cr>",
  { desc = "Show file explorer", noremap = true, silent = true }
)

require("neo-tree").setup({
  window = {
    position = "current",
  },
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 0,
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = nil,       -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "󰜌",
      provider = function(icon, node, state)       -- default icon provider utilizes nvim-web-devicons if available
        if node.type == "file" or node.type == "terminal" then
          local success, web_devicons = pcall(require, "nvim-web-devicons")
          local name = node.type == "terminal" and "terminal" or node.name
          if success then
            local devicon, hl = web_devicons.get_icon(name)
            icon.text = devicon or icon.text
            icon.highlight = hl or icon.highlight
          end
        end
      end,
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted   = "✖", -- this can only be used in the git_status source
        renamed   = "󰁕", -- this can only be used in the git_status source
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "󰄱",
        staged    = "",
        conflict  = "",
      }
    },
    -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
    file_size = {
      enabled = true,
      required_width = 64,       -- min width of window required to show this column
    },
    type = {
      enabled = true,
      required_width = 122,       -- min width of window required to show this column
    },
    last_modified = {
      enabled = true,
      required_width = 88,       -- min width of window required to show this column
    },
    created = {
      enabled = true,
      required_width = 110,       -- min width of window required to show this column
    },
    symlink_target = {
      enabled = false,
    },
  },
})
