local lualine = require("lualine")

lualine.setup({
  options = {
    globalstatus = true,
    section_separators = "",
    component_separators = "",
    always_show_tabline = false,
  },
  sections = {
    lualine_b = {
      { "branch", icon = "󰘬" },
      "diff",
      "diagnostics",
    },
    lualine_c = {
      {
        "filename",
        path = 1,
        symbols = {
          modified = "●",
          readonly = "",
        },
      },
    },
  },
  tabline = {
    lualine_a = {
      {
        "tabs",
        mode = 1,
        max_length = vim.o.columns,
        show_modified_status = false,
      },
    },
  },
})

vim.opt.showmode = false -- hide redundant mode indicator in command bar
