return {
	{
		"https://github.com/nvim-lua/plenary.nvim",
		name = "plenary",
	},
	-- Auto instert bracket pairs
	"https://github.com/jiangmiao/auto-pairs",
	-- Work with surrounding brackets/characters
	"https://github.com/tpope/vim-surround",
	-- Repeat plugin commands with `.`
	"https://github.com/tpope/vim-repeat",
	-- Doing the git
	"https://github.com/tpope/vim-fugitive",
	-- Unix helpers
	"https://github.com/tpope/vim-eunuch",
	"https://github.com/airblade/vim-gitgutter",
	"https://github.com/tpope/vim-dispatch",
	-- Rake/Rails navigation and help
	"https://github.com/tpope/vim-rails",
	"https://github.com/tpope/vim-bundler",
	-- Generate ctags for bundled gems
	"https://github.com/tpope/gem-ctags",
	"https://github.com/tpope/vim-projectionist",
	"https://github.com/tpope/vim-rake",
	{
		"https://github.com/kyazdani42/nvim-web-devicons",
		name = "devicons",
	},
	{
		"https://github.com/RRethy/nvim-treesitter-endwise",
		dependencies = "treesitter",
	},
	{
		"https://github.com/folke/trouble.nvim",
		name = "trouble",
		dependencies = "devicons",
	},
	{
		"https://github.com/folke/todo-comments.nvim",
		dependencies = "plenary",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	{
		"https://github.com/petertriho/cmp-git",
		name = "cmp_git",
		dependencies = "plenary",
	},
	"https://github.com/SirVer/ultisnips",
	"https://github.com/quangnguyen30192/cmp-nvim-ultisnips",
	"https://github.com/honza/vim-snippets",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/jose-elias-alvarez/typescript.nvim",
	"https://github.com/folke/neodev.nvim",
	{
		"https://github.com/jose-elias-alvarez/null-ls.nvim",
		name = "null_ls",
		dependencies = "plenary",
	},
}
