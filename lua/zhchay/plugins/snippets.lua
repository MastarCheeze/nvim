local ls = require("luasnip")

ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})

-- Load snippets
for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/zhchay/snippets/*.lua", true)) do
  loadfile(ft_path)()
end

-- Keymaps
vim.keymap.set("i", "<C-k>", function()
  ls.expand()
end, { silent = true, desc = "Expand snippet" })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  ls.jump(1)
end, { silent = true, desc = "Jump to next snippet item" })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  ls.jump(-1)
end, { silent = true, desc = "Jump to previous snippet item" })

vim.keymap.set({ "i", "s" }, "<C-e>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true, desc = "Select next snippet choice" })
