require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      {
        "diff",
        diff_color = {
          -- Same color values as the general color option can be used here.
          added    = "LuaLineDiffAdd",      -- Changes the diff's added color
          modified = "LuaLineDiffChange",   -- Changes the diff's modified color
          removed  = "LuaLineDiffRemove",   -- Changes the diff's removed color you
        },
      },
      {
        "diagnostics",
        diagnostics_color = {
          hint  = "", -- lualine_b_diagnostics_hint
          info  = "",
          warn  = "",
          error = "",
        },
      },
    },
    lualine_c = {
      {
        "filename",
        path = 1,
        symbols = {
          modified = "●",
          readonly = "",
        },
      },
    },
    lualine_x = {
      "filetype",
      {
        "tabs",
        show_modified_status = false,
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  extensions = {
    "fzf",
    "lazy",
    "mason",
  },
})
