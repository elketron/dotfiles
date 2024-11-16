return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({

        ---@since 1.0.0
        -- [Advanced setting]
        -- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
        -- multiple registries, the registry listed first will be used.
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "bashls",
          "cssls",
          --"volar",
          "gopls",
          "tailwindcss",
          "html",
          "ts_ls",
          "markdown_oxide",
          "zls",
          "angularls",
          --"roslyn",
          --"rzls",
        },
      })
    end,
  },
}
