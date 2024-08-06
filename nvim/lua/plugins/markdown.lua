--return {
--  "lukas-reineke/headlines.nvim",
--  dependencies = "nvim-treesitter/nvim-treesitter",
--  config = true, -- or `opts = {}`
--}
--return {
--  {
--    "MeanderingProgrammer/markdown.nvim",
--    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
--    dependencies = { "nvim-treesitter/nvim-treesitter" },
--    config = function()
--      require("render-markdown").setup({})
--    end,
--  },
--}

return {
  "OXY2DEV/markview.nvim",
  ft = "markdown",

  dependencies = {
    -- You may not need this if you don't lazy load
    -- Or if the parsers are in your $RUNTIMEPATH
    "nvim-treesitter/nvim-treesitter",

    "nvim-tree/nvim-web-devicons",
  },
}
