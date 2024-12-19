return {
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        overridePalette = function(filter)
          return {
            background = "#141519",
          }
        end
      })

      vim.cmd.colorscheme("monokai-pro")
    end
  }
}
