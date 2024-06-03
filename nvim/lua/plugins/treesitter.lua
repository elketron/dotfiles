return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = "all",
      auto_install = true,
      ignore_install = { "phpdoc" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
