local gitsigns = require("gitsigns")

gitsigns.setup({
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Hunk navigation
    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({"]h", bang = true})
      else
        gitsigns.nav_hunk("next")
      end
    end)

    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({"[h", bang = true})
      else
        gitsigns.nav_hunk("prev")
      end
    end)

    -- Hunk git actions
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
    map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")

    -- Hunk text object
    map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end
})
