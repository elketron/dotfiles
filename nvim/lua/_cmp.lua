--local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    --{ name = 'cmdline' },
    --{ name = 'buffer-lines'},
    { name = 'calc' },
    { name = "rg", },
    { name = 'nvim_lsp_signature_help' },
  }, {
    --{ name = 'buffer' },
  })
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.filetype("sh", {
  sources = cmp.config.sources({
    { name = "cmdline" },
    { name = "buffer" }
  })
})
--cmp.event:on(
--  'confirm_done',
--  cmp_autopairs.on_confirm_done()
--)
