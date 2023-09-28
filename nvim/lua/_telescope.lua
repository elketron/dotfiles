require('telescope').setup {
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  },
  file_ignore_patterns = {"node_modules", "bin", "obj"}
}

-- Disable folding in Telescope's result window.
vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>')
vim.keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<cr>')
vim.keymap.set('n', '<leader>gs', '<cmd>Telescope git_status<cr>')
vim.keymap.set('n', '<leader>tr', '<cmd>Telescope treesitter<cr>')
vim.keymap.set('n', '<leader>k', '<cmd>Telescope keymaps<cr>')
vim.keymap.set('n', '<leader>ld', '<cmd>Telescope lsp_definitions<cr>')
vim.keymap.set('n', '<leader>li', '<cmd>Telescope lsp_implementations<cr>')
