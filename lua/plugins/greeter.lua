local starter = require("alpha")
require("alpha.term")

starter.setup({
  layout = {
    { type = "padding", val = 8 },
    {
      type = "group",
      val = {
        {
          type = "text",
          val = {
            [[                                             o8o                   ]],
            [[                                             `"'                   ]],
            [[ooo. .oo.    .ooooo.   .ooooo.  oooo    ooo oooo  ooo. .oo.  .oo.  ]],
            [[`888P"Y88b  d88' `88b d88' `88b  `88.  .8'  `888  `888P"Y88bP"Y88b ]],
            [[ 888   888  888ooo888 888   888   `88..8'    888   888   888   888 ]],
            [[ 888   888  888    .o 888   888    `888'     888   888   888   888 ]],
            [[o888o o888o `Y8bod8P' `Y8bod8P'     `8'     o888o o888o o888o o888o]],
          },
          opts = {
            position = "center",
            hl = (function()
              local tbl = {}
              local sub_tbl = { { "AlphaHeader1", 0, 32 }, { "AlphaHeader2", 32, -1 } }
              for _ = 1, 7 do
                table.insert(tbl, sub_tbl)
              end
              return tbl
            end)(),
          },
        },
        {
          type = "text",
          val = "v" .. tostring(vim.version()),
          opts = {
            position = "center",
            hl = "AlphaHeaderLabel",
          },
        },
      },
      opts = { spacing = 2 },
    },
  },
})
