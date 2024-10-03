local close_unfocused_split_and_new = require("functions.close_unfocused_split_and_new")
local function split_window_res()
  close_unfocused_split_and_new("vsplit")
  vim.lsp.buf.definition()
  vim.defer_fn(function()
    vim.cmd("wincmd p")
  end, 500)
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} },

      { "stevearc/conform.nvim", opts = {} },
      "b0o/SchemaStore.nvim",
    },
    opts = {
      inlay_hints = {
        enable = true,
      },
      codelens = {
        enable = true,
      },
      document_highlight = {
        enable = true,
      },
    },
    config = function()
      local capabilities = nil
      capabilities = require("cmp_nvim_lsp").default_capabilities()

      capabilities.workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      }

      local lspconfig = require("lspconfig")
      local project_lib_path = vim.fn.expand("./node_modules/")
      local global_lib_path = vim.fn.expand("~/.bun/install/global/node_modules")
      local cmd = {
        "ngserver",
        "--stdio",
        "--tsProbeLocations",
        global_lib_path,
        project_lib_path,
        "--ngProbeLocations",
        global_lib_path,
        project_lib_path,
        "--includeCompletionsWithSnippetText",
      }

      local servers = {
        bashls = true,
        --rust_analyzer = true,
        cssls = true,
        --sqlls = true,
        --sqls = {
        --  settings = {
        --    sqls = {
        --      connections = {
        --        {
        --          driver = "sqlite",
        --        },
        --      },
        --    },
        --  },
        --},
        volar = true,
        gopls = true,
        tailwindcss = true,
        html = true,
        csharp_ls = true,
        --tsserver = true,
        ts_ls = true,
        pyright = true,
        markdown_oxide = true,
        --pylyzer = true,
        zls = true,
        angularls = {
          cmd = cmd,
          on_new_config = function(new_config, new_root_dir)
            new_config.cmd = cmd
          end,
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
        },
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

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.diagnostic.enable(true, nil)
      vim.lsp.inlay_hint.enable(true, nil)

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
          vim.keymap.set("n", "vd", split_window_res, { buffer = 0 })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })

      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          cs = { "csharpier" },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
