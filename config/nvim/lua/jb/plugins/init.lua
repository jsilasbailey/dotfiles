local utils = require("jb.utils")

return require("packer").startup({
	function(use)
		-- Required
		use("https://github.com/wbthomason/packer.nvim")
		use("https://github.com/nvim-lua/popup.nvim")
		use("https://github.com/nvim-lua/plenary.nvim")

		-- Split and join lines more intelligently
		use({
			"https://github.com/AndrewRadev/splitjoin.vim",
			config = utils.config("splitjoin"),
			keys = { "gS", "gJ" },
		})

		-- Easy commenting of lines
		use({
			"https://github.com/tpope/vim-commentary",
		})

		-- Dispatch testing from vim
		use({
			"https://github.com/vim-test/vim-test",
			requires = "https://github.com/tpope/vim-dispatch",
			config = utils.config("vim-test"),
		})

		-- Simply designed fast navigation
		use({
			"https://github.com/ggandor/lightspeed.nvim",
		})

		-- Catppuccin colorschemes
		use({
			"https://github.com/catppuccin/nvim",
			as = "catppuccin",
		})

		-- Distraction free editing
		use({
			"https://github.com/junegunn/goyo.vim",
		})

		-- Auto instert bracket pairs
		use({
			"https://github.com/jiangmiao/auto-pairs",
		})

		-- Work with surrounding brackets/characters
		use({
			"https://github.com/tpope/vim-surround",
		})

		-- Repeat plugin commands with `.`
		use({
			"https://github.com/tpope/vim-repeat",
		})

		-- Doing the git
		use({
			"https://github.com/tpope/vim-fugitive",
		})

		-- Unix helpers
		use({
			"https://github.com/tpope/vim-eunuch",
		})

		-- Navigate tmux panes like vim
		use({
			"https://github.com/christoomey/vim-tmux-navigator",
		})

		-- Git gutter signs
		use({
			"https://github.com/airblade/vim-gitgutter",
		})

		-- Rake/Rails navigation and help
		use({
			"https://github.com/tpope/vim-rails",
		})
		use({
			"https://github.com/tpope/vim-bundler",
		})
		-- Generate ctags for bundled gems
		use({
			"https://github.com/tpope/gem-ctags",
		})
		use({
			"https://github.com/tpope/vim-rake",
			requires = "https://github.com/tpope/vim-projectionist",
		})

		-- Treesitter, for syntax
		use({
			"https://github.com/nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = utils.config("nvim-treesitter"),
		})
		use({
			"https://github.com/RRethy/nvim-treesitter-endwise",
			requires = "https://github.com/nvim-treesitter/nvim-treesitter",
		})

		-- Diagnostics reporting
		use({
			"https://github.com/folke/trouble.nvim",
			requires = "https://github.com/kyazdani42/nvim-web-devicons",
		})

		-- File finder
		use({
			"https://github.com/nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			config = utils.config("telescope"),
			requires = {
				{ "https://github.com/nvim-lua/plenary.nvim" },
				{
					"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
					run = "make",
				},
			},
			after = "trouble.nvim",
		})

		use({
			"https://github.com/mrjones2014/dash.nvim",
			run = "make install",
		})

		-- Completion
		use({
			"https://github.com/hrsh7th/nvim-cmp",
		})
		use({
			"https://github.com/hrsh7th/cmp-buffer",
		})
		use({
			"https://github.com/hrsh7th/cmp-path",
		})
		use({
			"https://github.com/hrsh7th/cmp-cmdline",
		})
		use({
			"https://github.com/hrsh7th/cmp-nvim-lsp",
		})
		use({
			"https://github.com/petertriho/cmp-git",
			requires = "https://github.com/nvim-lua/plenary.nvim",
		})
		use({
			"https://github.com/SirVer/ultisnips",
		})
		use({
			"https://github.com/quangnguyen30192/cmp-nvim-ultisnips",
		})
		use({
			"https://github.com/honza/vim-snippets",
		})

		-- LSP plugins
		use({
			"https://github.com/neovim/nvim-lspconfig",
		})
		use({
			"https://github.com/williamboman/mason.nvim",
		})
		use({
			"https://github.com/williamboman/mason-lspconfig.nvim",
		})
		use({
			"https://github.com/jose-elias-alvarez/typescript.nvim",
		})
		use({
			"https://github.com/folke/neodev.nvim",
		})

		-- Null.ls
		use({
			"https://github.com/jose-elias-alvarez/null-ls.nvim",
			requires = "https://github.com/nvim-lua/plenary.nvim",
		})
	end,
	config = {
		max_jobs = 50,
	},
})
