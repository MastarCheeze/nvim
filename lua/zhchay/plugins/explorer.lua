require("mini.files").setup({
  content = {
    -- Permanently hide files
    filter = function(fs_entry)
      return not (
        fs_entry.name == ".DS_Store"
      )
    end,
  },
  options = {
    permanent_delete = false,
  },
  mappings = {
    close = "<esc>",
    go_in_plus = "l",
    go_out_plus = "h",
  },
  windows = {
    width_focus = 30,
  },
})

require("mini.icons").setup({})
MiniIcons.mock_nvim_web_devicons()

-- Show explorer keymap
vim.keymap.set("n", "<leader>e", function()
  local bufname = vim.api.nvim_buf_get_name(0)
  print(bufname, vim.fn.filereadable(bufname))
  if vim.fn.filereadable(bufname) ~= 0 then
    MiniFiles.open(bufname, false)
    MiniFiles.reveal_cwd()
  else
    MiniFiles.open(nil, false)
  end
end, { desc = "Show file explorer" })

-- Show/hide dotfiles (thanks docs recipe)
local show_dotfiles = true
local filter_show = function(fs_entry) return true end
local filter_hide = function(fs_entry)
  return not (
    vim.startswith(fs_entry.name, ".") and
    fs_entry.name == "node_modules"
  )
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak left-hand side of mapping to your liking
    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
  end,
})
