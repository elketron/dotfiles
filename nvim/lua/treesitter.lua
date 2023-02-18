require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    ignore_install = { "phpdoc" },
    autopairs = { enable = true },
    highlight = {
        enable = true
    },
}

local npairs = require("nvim-autopairs")

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = { 'string' }, -- it will not add pair on that treesitter node
        javascript = { 'template_string' },
        java = false, -- don't check treesitter on java
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')

local ts_query = require("nvim-treesitter.query")

-- vim.treesitter.query.set_query("c_sharp", "routes", [[
-- 
-- (file_scoped_namespace_declaration
--   (class_declaration
--     body: (declaration_list
--       (method_declaration
--         (modifier) @modifier
--         (#match? @modifier "public")
--         name:(identifier) @name
--       )
--     )
--   )
-- )
--   ]])

-- press % => %% is only inside comment or string
--npairs.add_rules({
--  Rule("%", "%", "lua")
--    :with_pair(ts_conds.is_ts_node({'string','comment'})),
--  Rule("$", "$", "lua")
--    :with_pair(ts_conds.is_not_ts_node({'function'}))
--})
