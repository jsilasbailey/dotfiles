return {
   "nvim-lua/plenary.nvim" ,
  -- Auto instert bracket pairs
  "jiangmiao/auto-pairs",
  -- Work with surrounding brackets/characters
  "tpope/vim-surround",
  -- Comment/Uncomment lines
  "tpope/vim-commentary",
  -- Repeat plugin commands with `.`
  "tpope/vim-repeat",
  -- The "hub" stuffz,
  "tpope/vim-rhubarb",
  -- Doing the git
  "tpope/vim-fugitive",
  -- Unix helpers
  "tpope/vim-eunuch",
  "tpope/vim-dispatch",
  -- Rake/Rails navigation and help
  "tpope/vim-rails",
  "tpope/vim-bundler",
  -- Generate ctags for bundled gems
  "tpope/gem-ctags",
  "tpope/vim-projectionist",
  "tpope/vim-rake",
  {
    "mrjones2014/smart-splits.nvim",
    config = require("plugins.config.smartsplits").config,
  },
  "AndrewRadev/splitjoin.vim", -- Still need for erb files while not using treesitter on them
  "nvim-tree/nvim-web-devicons",
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
    end,
  },
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  {
    "petertriho/cmp-git",
    dependencies = "nvim-lua/plenary.nvim",
  },
  "SirVer/ultisnips",
  "quangnguyen30192/cmp-nvim-ultisnips",
  "honza/vim-snippets",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "glepnir/lspsaga.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
  },
  "jose-elias-alvarez/typescript.nvim",
  "folke/neodev.nvim",
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = require("plugins.config.nvim_treesitter_context").config
  },
  {
    "rose-pine/neovim",
  }
}
