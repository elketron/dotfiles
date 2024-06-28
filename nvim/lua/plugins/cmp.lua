return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    event = "InsertEnter",
    priority = 100,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-calc",
      "saadparwaiz1/cmp_luasnip",
      "amarakon/nvim-cmp-buffer-lines",
      "lukas-reineke/cmp-rg",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            options = {
              markdown_oxide = {
                keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
              },
            },
          },
          { name = "luasnip" },
          { name = "path" },
          --{ name = 'cmdline' },
          --{ name = 'buffer-lines'},
          { name = "calc" },
          { name = "rg" },
          { name = "nvim_lsp_signature_help" },
        }, {
          --{ name = 'buffer' },
        }),
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.filetype("sh", {
        sources = cmp.config.sources({
          { name = "cmdline" },
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },
}
