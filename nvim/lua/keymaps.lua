local close_unfocused_split_and_new = require("functions.close_unfocused_split_and_new")
-- ----------------------------------------------------------------------------
-- normal mode
-- ----------------------------------------------------------------------------
vim.keymap.set("n", "<leader>Y", '"*y')
vim.keymap.set("n", "<leader>P", '"*p')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>n", ":bNext<cr>")
vim.keymap.set("n", "<leader>p", ":bprevious<cr>")
vim.keymap.set("n", "<leader>tt", ":term<cr>")
vim.keymap.set("n", "<leader>dn", ":lua vim.diagnostic.goto_next()<cr>")
vim.keymap.set("n", "<leader>dp", ":lua vim.diagnostic.goto_prev()<cr>")

vim.keymap.set("n", "<leader>eq", ':lua require("nabla").action()<cr>')
vim.keymap.set("n", "<leader>re", ":lua vim.lsp.buf.rename()<cr>")
vim.keymap.set("n", "<A-k>", ":lua print('hello')<cr>")

vim.keymap.set("n", "<C-W>s", function()
  close_unfocused_split_and_new("split")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-W>v", function()
  close_unfocused_split_and_new("vsplit")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>w", "<C-w>w", { noremap = true, silent = true })

-- ----------------------------------------------------------------------------
-- visual mode
-- ----------------------------------------------------------------------------
vim.keymap.set("v", "<leader>Y", '"*y')
vim.keymap.set("v", "<leader>P", '"*p')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>p", '"+p')

-- ----------------------------------------------------------------------------
-- terminal
-- ----------------------------------------------------------------------------
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- ----------------------------------------------------------------------------
-- telescope
-- ----------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>")
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>")
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>")
vim.keymap.set("n", "<leader>tr", "<cmd>Telescope treesitter<cr>")
vim.keymap.set("n", "<leader>k", "<cmd>Telescope keymaps<cr>")
vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>")
vim.keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>")
vim.keymap.set("n", "<leader>da", "<cmd>Telescope diagnostics<cr>")
vim.keymap.set("n", "<leader>lf", function()
  require("telescope.builtin").lsp_document_symbols({ symbols = "function" })
end)
