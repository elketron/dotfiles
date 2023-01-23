-- general settings
vim.o.wildmenu = true
vim.o.showcmd  = true
vim.o.autoindent = true
vim.o.confirm = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth=2
vim.o.softtabstop=2
vim.o.expandtab = true
vim.o.foldmethod='indent'
--vim.o.nofoldenable = true
vim.o.termguicolors = true
vim.o.guicursor=''
--vim.o.nohlsearch = true
vim.o.nu = true
vim.o.hidden = true
vim.o.incsearch = true
--vim.o.nobackup = true
--vim.o.nowritebackup = true
vim.o.cmdheight=2
vim.o.updatetime=300
vim.opt.completeopt = "menu,menuone,noinsert"
--vim.o.shortmess+=c
-- ultisnips
--vim.g["UltiSnipsJumpForwardTrigger"] = "<A-n>"
--vim.g["UltiSnipsJumpBackwardTrigger"] = "<A-e>"

--set leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- set temporary files
vim.api.nvim_set_option('directory', '~/.vim/swap')
vim.api.nvim_set_option('undodir', '~/.vim/undo')

vim.g.godot_executable = "/usr/bin/godot-mono"

