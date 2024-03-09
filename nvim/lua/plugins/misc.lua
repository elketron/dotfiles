local function inWorkDirectory()
	local cwd = vim.fn.getcwd()
	if string.find(cwd, 'Werk') ~= nil then
		return true
	else
		return false
	end
end


return {
	--packer
	'wbthomason/packer.nvim',
	--utilities
	'Tpope/vim-surround',
	'yggdroot/indentline',
	'ap/vim-css-color',
	'MunifTanjim/nui.nvim',
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	'jbyuki/nabla.nvim',
	'habamax/vim-godot',
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	},
	'smithbm2316/centerpad.nvim',
	'nvim-treesitter/playground',
	-- snippets
	-- 'L3MON4D3/LuaSnip'
	-- syntax
	'scrooloose/syntastic',
	'sheerun/vim-polyglot',
	-- themes
	-- 'ghifarit53/tokyonight-vim'
	--{'srcery-colors/srcery-vim', name="srcery"},
	--{ "catppuccin/nvim", name = "catppuccin" },
	'ayu-theme/ayu-vim',
	'vim-airline/vim-airline',
	'ryanoasis/vim-devicons',

	-- windowing
	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',

	--lsp
	'neovim/nvim-lspconfig',
	'simrat39/symbols-outline.nvim',
	{
		'windwp/nvim-autopairs',
		config = function()
			require("nvim-autopairs").setup {}
		end
	},
	'VidocqH/lsp-lens.nvim',
	{
		'nvimdev/lspsaga.nvim',
		event = 'LspAttach',
    config = function()
        require('lspsaga').setup({})
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons'     -- optional
    }
	},
	{ 'joeveiga/ng.nvim' },

	-- 'tjdevries/nlua.nvim'
	"folke/neodev.nvim",
	'mfussenegger/nvim-dap',
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	'theHamsta/nvim-dap-virtual-text',

	--cmp
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-calc',
	{
		"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp"
	},
	'saadparwaiz1/cmp_luasnip',
	"amarakon/nvim-cmp-buffer-lines",
	"lukas-reineke/cmp-rg",
	--personal plugins
	'elketron/elk-funcs',
	'elketron/elk-manager',

	--git
	{ 'sindrets/diffview.nvim',              dependencies = 'nvim-lua/plenary.nvim' },

	--copilot
	{
		"github/copilot.vim",
		enabled = inWorkDirectory() == false,
	},
	--codeium
	{
		'Exafunction/codeium.vim',
		event = 'BufEnter',
		enabled = inWorkDirectory() == true,
	},

	-- extra
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl",                          opts = {} },

	--development
	--{ dir = "elketron/ng-tools",             dev = true,                            config = true }

}
