-- neodev
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

local lsp = require 'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()
-- lsp config

lsp.pyright.setup {
  capabilities = capabilities,
}
lsp.clangd.setup {
  capabilities = capabilities,
}
lsp.html.setup {
  capabilities = capabilities,
}
lsp.zls.setup { capabilities = capabilities }

lsp.tsserver.setup { capabilities = capabilities }
local project_lib_path = vim.fn.expand("./node_modules/")
local global_lib_path = vim.fn.expand("~/.bun/install/global/node_modules")
local cmd = { "ngserver", "--stdio", "--tsProbeLocations", global_lib_path, project_lib_path, "--ngProbeLocations",
  global_lib_path, project_lib_path,
  "--includeCompletionsWithSnippetText" }
lsp.angularls.setup {
  capabilities = capabilities,
  cmd = cmd,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = cmd
  end,
}
lsp.tailwindcss.setup { capabilities = capabilities }
lsp.cssls.setup { capabilities = capabilities }
lsp.csharp_ls.setup {
  capabilities = capabilities,
  root_dir = function(startpath)
    return lsp.util.root_pattern("*.sln")(startpath)
        or lsp.util.root_pattern("*.csproj")(startpath)
        or lsp.util.root_pattern("*.fsproj")(startpath)
        or lsp.util.root_pattern(".git")(startpath)
  end,
}
lsp.arduino_language_server.setup({
  cmd = {
    "arduino-language-server",
    "-cli-config", "~/.arduino15/arduino-cli.yaml",
    "-fqbn", 'arduino:avr:nano'
  },
  capabilities = capabilities
})
lsp.sqlls.setup { capabilities = capabilities }
lsp.volar.setup { capabilities = capabilities }
lsp.bashls.setup { capabilities = capabilities }
lsp.rust_analyzer.setup { capabilities = capabilities, settings = {
    ["rust-analyzer"] = {
      procMacro = {
        ignored = {
          leptos_macro = {
            "server"
          }
        }
      }
    }
} }
lsp.gopls.setup { capabilities = capabilities }
lsp.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
lsp.elixirls.setup {
  cmd = {"/bin/elixir-ls"}
}

require 'lsp-lens'.setup({
  include_declaration = true,
  sections = {
    definitions = true,
    references = true,
    implementation = true,
  }
})

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
