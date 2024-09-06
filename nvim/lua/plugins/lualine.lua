return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    return {
      options = {
        theme = "ayu_dark",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = {
          --            {"progress", separator = " ", padding = {left = 1, right = 0}},
          { "location", padding = { left = 1, right = 1 } },
        },
        lualine_z = {
          function()
            return os.date("%R") .. "  "
          end,
        },
      },
    }
  end,
}
