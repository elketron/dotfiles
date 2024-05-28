return {
  {'neovim/nvim-lspconfig',
  dependencies = {
    "folke/neodev.nvim",
    {"j-hui/fidget.nvim", opts = {}},

    --"stevearce/conform.nvim",
      "b0o/SchemaStore.nvim",
  },
  config = function()
    require("neodev").setup{}

    local capabilities = nil
    capabilities = require("cmp_nvim_lsp").default_capabilities()

    local lspconfig = require "lspconfig"

    local global_lib_path = vim.fn.expand("~/.bun/install/global/node_modules")

    local servers = {
      bashls = true,
      rust_analyzer = true,
      cssls = true,
      sqlls = true,
      volar = true,
      gopls = true,
      tailwindcss = true,
      csharp_ls = true,
      tsserver = true,
      pyright = true,
      zls = true,
      angularls = {
        cmd = {"ngserver", "--stdio", "--tsProbeLocations", global_lib_path, "--ngProbeLocations", global_lib_path, "--includeCompletionWithSnippetText"}
      },
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      }
    }

    for name, config in pairs(servers) do 
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend("force", {}, {
        capabilities = capabilities,
      }, config)

      lspconfig[name].setup(config)
    end

  end
  }
}
