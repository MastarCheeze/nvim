local monokai = require("monokai")

-- Color palette
local c = monokai.ristretto
c.base2 = "#14161a" -- editor background
c.base3 = "#23282E" -- selected items, cursor line, color column
-- c.base4 -- visual highlight
-- c.base5 -- line number, visible whitespace characters
-- c.base6 -- comments
-- c.border
c.red = "#f87171"
c.purple = "#c084fc"
c.green = "#4ade80"
c.blue = "#60a5fa"

monokai.setup({ palette = c })

-- Highlight groups
local hlgroups = {
  -- GUI
  CursorLineNr = { fg = c.white, bg = c.base2 },
  WinSeparator = { fg = c.border },

  NormalFloat = { bg = c.base2 },
  FloatBorder = { fg = c.border, bg = c.base2 },

  Search = { bg = c.base4 },
  CurSearch = { fg = c.base2, bg = c.yellow },
  IncSearch = { link = "CurSearch" },

  MatchParen = { fg = c.orange, standout = true },

  -- Text editor
  String = { fg = c.green },
  Character = { link = "String" },
  ["@string"] = { link = "String" },
  ["@character"] = { link = "String" },

  Function = { fg = c.yellow },
  ["@function"] = { link = "Function" },
  ["@method"] = { link = "Function" },

  PreProc = { fg = c.yellow },
  ["@preproc"] = { link = "PreProc" },
  ["@function.macro"] = { link = "PreProc" },

  -- ["@annotation"] = { fg = c.yellow },
  -- ["@attribute"] = { fg = c.yellow },
  -- ["@tag.attribute"] = { fg = c.yellow },
  -- ["@text"] = { fg = c.yellow },

  -- ["@definition"] = { fg = c.yellow },
  -- ["@definition.associated"] = { fg = c.yellow  },
  -- ["@definition.constant"] = { fg = c.yellow },
  -- ["@definition.enum"] = { fg = c.yellow },
  -- ["@definition.field"] = { fg = c.yellow },
  -- ["@definition.function"] = { fg = c.yellow },
  -- ["@definition.macro"] = { fg = c.yellow },
  -- ["@definition.method"] = { fg = c.yellow },
  -- ["@definition.type"] = { fg = c.yellow },
  -- ["@definition.var"] = { fg = c.yellow },

  Keyword = { fg = c.pink }, -- applies to words, not symbols
  ["@keyword"] = { link = "Keyword" },
  ["@keyword.function"] = { link = "Keyword" },
  ["@keyword.operator"] = { link = "Keyword" },
  ["@keyword.return"] = { link = "Keyword" },

  -- completion
  PMenu = { link = "NormalFloat" },
  PMenuSel = { bg = c.base4 },
  PMenuThumb = { bg = c.border },

  -- diagnostics
  DiagnosticOk = { fg = c.green },
  DiagnosticHint = { fg = c.purple },
  DiagnosticInfo = { fg = c.aqua },
  DiagnosticWarn = { fg = c.yellow },
  DiagnosticError = { fg = c.red },
  DiagnosticVirtualTextOk = { link = "DiagnosticOk" },
  DiagnosticVirtualTextHint = { link = "DiagnosticHint" },
  DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
  DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
  DiagnosticVirtualTextError = { link = "DiagnosticError" },
  DiagnosticSignOk = { link = "DiagnosticOk" },
  DiagnosticSignHint = { link = "DiagnosticHint" },
  DiagnosticSignInfo = { link = "DiagnosticInfo" },
  DiagnosticSignWarn = { link = "DiagnosticWarn" },
  DiagnosticSignError = { link = "DiagnosticError" },
  DiagnosticUnderlineOk = { sp = c.green, underline = true },
  DiagnosticUnderlineHint = { sp = c.purple, undercurl = true },
  DiagnosticUnderlineInfo = { sp = c.aqua, undercurl = true },
  DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
  DiagnosticUnderlineError = { sp = c.red, undercurl = true },

  -- fzf
  FzfLuaBorder = { link = "FloatBorder" },

  -- which-key
  WhichKeyBorder = { link = "FloatBorder" },

  -- neo-tree
  NeoTreeDimText = { fg = c.base6 },

  -- indent-blankline
  IblIndent = { fg = c.base3 }, -- normal indentline
  IblScope = { fg = c.base4 },  -- highlighted indentline

  -- gitsigns
  Added = { fg = c.green },
  Changed = { fg = c.grey },
  Removed = { fg = c.red },

  -- lualine
  lualine_a_normal = { fg = c.base3, bg = c.green, bold = true },
  lualine_b_normal = { fg = c.green, bg = c.base3 },
  lualine_a_insert = { fg = c.base3, bg = c.blue, bold = true },
  lualine_b_insert = { fg = c.blue, bg = c.base3 },
  lualine_a_visual = { fg = c.base3, bg = c.purple, bold = true },
  lualine_b_visual = { fg = c.purple, bg = c.base3 },
  lualine_a_command = { fg = c.base3, bg = c.yellow, bold = true },
  lualine_b_command = { fg = c.yellow, bg = c.base3 },
  lualine_a_replace = { fg = c.base3, bg = c.pink, bold = true },
  lualine_b_replace = { fg = c.pink, bg = c.base3 },
  lualine_a_terminal = { fg = c.base3, bg = c.white, bold = true },
  lualine_b_terminal = { fg = c.white, bg = c.base3 },

  lualine_c_normal = { fg = c.white, bg = c.base3 },
  lualine_c_insert = { link = "lualine_c_normal" },
  lualine_c_visual = { link = "lualine_c_normal" },
  lualine_c_command = { link = "lualine_c_normal" },
  lualine_c_replace = { link = "lualine_c_normal" },
  lualine_c_terminal = { link = "lualine_c_normal" },

  lualine_x_tabs_active = { fg = c.white, bg = c.base4 }, -- active tab

  lualine_b_diagnostics_hint = { fg = c.purple, bg = c.base3 },
  lualine_b_diagnostics_info = { fg = c.aqua, bg = c.base3 },
  lualine_b_diagnostics_warn = { fg = c.yellow, bg = c.base3 },
  lualine_b_diagnostics_error = { fg = c.purple, bg = c.base3 },

  LuaLineDiffAdd = { link = "Added" },
  LuaLineDiffChange = { link = "Changed" },
  LuaLineDiffRemove = { link = "Removed" },
}

local hooks = require("ibl.hooks") -- have to set a hook to change the highlight color
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IblIndent", hlgroups.IblIndent)
  vim.api.nvim_set_hl(0, "IblScope", hlgroups.IblScope)
end)

return function()
  for name, val in pairs(hlgroups) do
    vim.api.nvim_set_hl(0, name, val)
  end
end
