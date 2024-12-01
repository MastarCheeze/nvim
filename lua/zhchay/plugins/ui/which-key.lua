local wk = require("which-key")
local utils = require("zhchay.utils")

wk.setup({
  preset = "classic",
  delay = 400,
  triggers = {
    { "<auto>", mode = "nixsotc" },
    { "ds", mode = "n" },
  },
  win = {
    width = 100,
    height = { min = 4, max = 15 },
    col = 0.5,
    border = utils.border,
    padding = { 1, 1 },
    no_overlap = false,
  },
  layout = {
    spacing = 2, -- spacing between columns
  },
  keys = {
    scroll_down = "<Down>",
    scroll_up = "<Up>",
  },

  plugins = {
    marks = false,     -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
    },
    presets = {
      operators = true,    -- adds help for operators like d, y, ...
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  icons = {
    breadcrumb = "",
  },
})

-- vim.keymap.set({ "n", "v" }, "<leader>?", "<cmd>WhichKey<cr>", { desc = "WhichKey all keymaps" })
-- <leader> then backspace works just well
utils.wkInit()
