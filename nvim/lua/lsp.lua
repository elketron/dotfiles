-- neodev
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

local lsp = require 'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()
-- lsp config

lsp.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
--lsp.pylsp.setup{}
lsp.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.tsserver.setup { capabilities = capabilities }
lsp.angularls.setup { capabilities = capabilities }
lsp.cssls.setup { capabilities = capabilities }
lsp.csharp_ls.setup { capabilities = capabilities }
--omnisharp_dll = vim.fn.expand("$HOME/omnisharp/OmniSharp.dll")
--lsp.omnisharp.setup {
--  capabilities = capabilities,
--  cmd = { "omnisharp" },
--  filetypes = { "cs", "vb", "razor" },
--  enable_roslyn_analyzers = true,
--  enable_import_completion = true,
--  organize_imports_on_format = true,
--}
lsp.arduino_language_server.setup({
  cmd = {
    "arduino-language-server",
    "-cli-config", "~/.arduino15/arduino-cli.yaml",
    "-fqbn", 'arduino:avr:nano'
  },
  capabilities = capabilities
})
lsp.sqlls.setup { capabilities = capabilities }
-- lsp.efm.setup{
--   init_options = {documentFormatting = true},
--   settings = {
--     rootMarkers = {".git/"},
--     languages = {
--       lua = {formatCommand = "lua-format -i", formatStdin = true},
--       python = {completion = true, codeAction = true}
--     }
--   },
--   filetypes = { 'python', 'lua'}
--}

lsp.vuels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.bashls.setup { capabilities = capabilities }
lsp.rust_analyzer.setup { capabilities = capabilities }
lsp.sumneko_lua.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})

-- omnisharp

local pid = vim.fn.getpid()
--local omnisharp_bin = "/usr/bin/omnisharp"

--require'lspconfig'.omnisharp.setup{
--  cmd = {omnisharp_bin},
--  enable_roslyn_analyzers = false,
--  enable_import_completion = false,
--}
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
  opts = opts or {}

  bufnr = bufnr or 0
  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

  local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
  if vim.tbl_isempty(line_diagnostics) then return end

  local diagnostic_message = ""
  for i, diagnostic in ipairs(line_diagnostics) do
    diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
    print(diagnostic_message)
    if i ~= #line_diagnostics then
      diagnostic_message = diagnostic_message .. "\n"
    end
  end
  vim.api.nvim_echo({ { diagnostic_message, "Normal" } }, false, {})
end
