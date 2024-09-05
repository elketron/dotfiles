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
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 1, -- set group index to 0 to skip loading LuaLS completions
      })
    end,

    config = function()
      local cmp = require("cmp")

      cmp.setup({
        preselect = "None",
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<A-l>"] = cmp.mapping.scroll_docs(-4),
          ["<A-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<A-o>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "Insert", { "i", "c" } }),
          -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "Insert", { "i", "c" } }),
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
          { name = "luasnip", priority = 1 },
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
