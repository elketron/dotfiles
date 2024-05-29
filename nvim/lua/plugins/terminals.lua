return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        shade_terminals = true,
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local ranger = Terminal:new({
        cmd = "ranger",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "single",
        },
      })
      local terminal = Terminal:new({
        hidden = true,
        direction = "float",
        float_opts = { border = "single" },
      })

      function _ranger_toggle()
        ranger:toggle()
      end

      function _teminal_toggle()
        terminal:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>rt", "<cmd>lua _ranger_toggle()<cr>", { noremap = true, silent = true })
      --vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua _terminal_toggle()<cr>", { noremap = true, silent = true })
    end,
  },
}
