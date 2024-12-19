local cmp = require("cmp")
local utils = require("zhchay.utils")

local icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = utils.icons.file,
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}

local source_labels = {
  buffer = "[Buf]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  luasnip = "[Snp]",
}

local cmp_label_maxwidth = 25 -- completion window max width
vim.o.pumheight = 20 -- completion indow max height

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = {
      completeopt = "menu,menuone,preview,noselect,scrollbar",
      border = utils.border,
    },
    documentation = {
      border = utils.border,
      max_width = 80,
      max_height = 60,
    },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = icons[vim_item.kind] -- icon
      if vim.fn.strchars(vim_item.abbr) > cmp_label_maxwidth - 1 then -- abbreviate completion label if too long
        vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, cmp_label_maxwidth - 1) .. "…"
      end
      vim_item.menu = source_labels[entry.source.name] -- source label
      vim_item.dup = 0
      return vim_item
    end,
    fields = { "kind", "abbr", "menu" },
  },
})
