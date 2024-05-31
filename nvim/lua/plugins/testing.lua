return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "Issafalcon/neotest-dotnet",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    --require("neotest").setup({
    --  adapters = {
        --require("neotest-dotnet")({
        --  dap = { discovery_root = "solution" },
        --}),
      --},
   -- })

    --require("neodev").setup({
    --  library = { plugins = { "neotest", types = true } },
    --})

    --vim.keymap.set("n", "<F6>", require("neotest").run.run())
    --vim.keymap.set("n", "<F7>", require("neotest").run.run(vim.fn.expand("%")))
    --vim.keymap.set("n", "<F8>", require("neotest").run.run({ strategy = "dap" }))
    --vim.keymap.set("n", "<F12>", require("neotest").run.stop())
  end,
}
