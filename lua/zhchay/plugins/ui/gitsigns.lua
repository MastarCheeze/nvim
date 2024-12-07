local gitsigns = require("gitsigns")
local wkAdd = require("zhchay.utils").wkAdd

gitsigns.setup({
  signs_staged_enable = false,
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]h", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Next hunk"})

    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[h", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Prev hunk"})

    -- Actions
    wkAdd({ "<leader>h", group = "Git actions" })
    map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Stage hunk" })
    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Reset hunk" })
    map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })

    map("n", "<leader>gl", function()
      gitsigns.blame_line({ full = true })
    end, { desc = "gitsigns Git blame line" })
    map("n", "<leader>gd", gitsigns.diffthis, { desc = "gitsigns Git diff panel" })
    map("n", "<leader>gL", gitsigns.blame, { desc = "gitsigns Git blame panel" })
    map("n", "<leader>gh", gitsigns.preview_hunk, { desc = "Preview hunk" })

    map("n", "<leader>'d", gitsigns.toggle_deleted, { desc = "Toggle git deleted" })
    map("n", "<leader>'l", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Hunk" })
  end,
})
