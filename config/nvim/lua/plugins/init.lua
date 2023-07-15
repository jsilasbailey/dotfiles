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
    config = function()
      require 'treesitter-context'.setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end
  },
  {
    "rose-pine/neovim",
  }
}
