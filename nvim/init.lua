local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require('general')
require("lazy").setup("plugins", {
  install = {
    missing = true,
  },
})
require('mappings')
require('augroups')
require('_telescope')
require('_cmp')
require("_luasnip")
require('lsp')
require('treesitter')
require("_lspsaga")
require("angular")
--require('snips')
vim.cmd(":color srcery")

-- require('theme')
