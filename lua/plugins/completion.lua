local cmp = require("cmp")
local lspkind = require("lspkind")

vim.opt.pumheight = 25 -- completion window max height
local lspkind_formatter = lspkind.cmp_format({
  mode = "symbol_text",
  maxwidth = { abbr = 30 },
  ellipsis_char = "…",
  menu = {
    lazydev = "[lazy]",
    nvim_lsp = " [LSP]",
    luasnip = "[snip]",
    path = "[path]",
  },
})

cmp.setup({
  sources = cmp.config.sources({
    {
      name = "lazydev",
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
  }),
  formatting = {
    fields = { "abbr", "kind", "menu" },
    expandable_indicator = true,
    format = function(entry, vim_item)
      vim_item = lspkind_formatter(entry, vim_item)
      return vim_item
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
})
