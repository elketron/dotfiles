--local utils = require('utils')

-- normal mode mappings
vim.keymap.set('n', '<leader>Y', '"*y')
vim.keymap.set('n', '<leader>P', '"*p')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>n', ':bNext<cr>')
vim.keymap.set('n', '<leader>p', ':bprevious<cr>')
vim.keymap.set('n', '<leader>tt', ':term<cr>')
vim.keymap.set('n', '<leader>en', ":lua vim.diagnostic.goto_next()<cr>")
vim.keymap.set('n', '<leader>ep', ":lua vim.diagnostic.goto_prev()<cr>")

vim.keymap.set('n', '<leader>eq', ':lua require("nabla").action()<cr>')
vim.keymap.set('n', '<leader>re', ':lua vim.lsp.buf.rename()<cr>')

vim.keymap.set('n', '<leader>cm', ':Com ')
vim.keymap.set('n', '<leader>cu', ':Unc ')
--vim.keymap.set('n', 'gt', ':tabn<CR>')
--vim.keymap.set('n', 'gT', ':tabp<CR>')
--vim.keymap.set('n', 'gN', 'tabnew<CR>')

-- visual mode mappings
vim.keymap.set('v', '<leader>Y', '"*y')
vim.keymap.set('v', '<leader>P', '"*p')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>p', '"+p')

-- insert mode mappings
vim.keymap.set('i', 'jj', '<Esc>')

-- terminal mode mappings
vim.keymap.set('t', '<Esc>', "<C-\\><C-n>")

-- copilot
vim.keymap.set('n', '<leader>pa', ':Copilot panel<cr>')
vim.keymap.set('v', '<leader>pa', ':Copilot panel<cr>')
