
return require('packer').startup(function()
 --packer
 use 'wbthomason/packer.nvim'
	--utilities
	use 'Tpope/vim-surround'
	use 'yggdroot/indentline'
	use 'ap/vim-css-color'
	use 'MunifTanjim/nui.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'jbyuki/nabla.nvim'
	use 'habamax/vim-godot'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = 'TSUpdate'
	}
	use { 'smithbm2316/centerpad.nvim' }
	use 'nvim-treesitter/playground'
	-- snippets
	use 'sirver/ultisnips'
	--use 'L3MON4D3/LuaSnip'
	-- syntax
	use 'scrooloose/syntastic'
	use 'sheerun/vim-polyglot'
	-- themes
	--use 'ghifarit53/tokyonight-vim'
	use 'srcery-colors/srcery-vim'
	use 'ayu-theme/ayu-vim'
	use 'vim-airline/vim-airline'
	use 'ryanoasis/vim-devicons'

	-- windowing
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'

 --lsp
	use 'neovim/nvim-lspconfig'
	use 'simrat39/symbols-outline.nvim'
	use 'windwp/nvim-autopairs'
	--use 'tjdevries/nlua.nvim'
	use "folke/neodev.nvim"

 --cmp
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-calc'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use "amarakon/nvim-cmp-buffer-lines"
	use "lukas-reineke/cmp-rg"
	--personal plugins
	use 'elketron/elk-funcs'
	use 'elketron/elk-manager'

end)

