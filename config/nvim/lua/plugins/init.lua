return {
  "nvim-lua/plenary.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = require("plugins.config.treesitter").setup
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  -- Work with surrounding brackets/characters
  "tpope/vim-surround",
  "tpope/vim-abolish",
  -- Comment/Uncomment lines
  "tpope/vim-commentary",
  -- Repeat plugin commands with `.`
  "tpope/vim-repeat",
  -- The "hub" stuffz,
  "tpope/vim-rhubarb",
  -- Doing the git
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  -- Unix helpers
  "tpope/vim-eunuch",
  {
    "vim-test/vim-test",
    requires = "tpope/vim-dispatch",
    config = function()
      -- Async test execution
      --
      -- CustomStrategy to return focus to current window
      --
      -- vim-test/vim-test/issues/448
      -- function! CustomStrategy(cmd)
      --   execute 'bel 10 new'
      --   call termopen(a:cmd)
      --   wincmd p " switch back to last window
      -- endfunction
      --
      -- let test#custom_strategies = {'custom': function('CustomStrategy')}
      -- let test#strategy = "custom"
      --
      -- OR use neotest for lua async strategies
      -- nvim-neotest/neotest
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#start_normal"] = "1"
    end,
    keys = {
      { "<leader>tn", ":TestNearest<cr>", desc = "Test nearest to line" },
      { "<leader>tf", ":TestFile<cr>",    desc = "Test file" },
      { "<leader>ta", ":TestSuite<cr>",   desc = "Test all tests" },
      { "<leader>tl", ":TestLast<cr>",    desc = "Test last test" },
      { "<leader>gt", ":TestVisit<cr>",   desc = "Go to test" },
    },
  },
  {
    "tpope/vim-dispatch",
    config = function()
      -- Formatting --
      -- Temporary
      -- rubocop for ruby files
      vim.api.nvim_create_user_command(
        "RubocopFixProject",
        "Dispatch! bundle exec rubocop -A",
        { desc = "Run rubocop on the project" }
      )

      vim.api.nvim_create_user_command(
        "PrettierFile",
        "Dispatch! prettier -w %",
        { desc = "Run prettier on the current file" }
      )

      vim.api.nvim_create_user_command(
        "DashWord",
        "Dispatch! open dash://<cword>",
        { desc = "Open the word under the cursor in Dash" }
      )
    end
  },
  -- Rake/Rails navigation and help
  "tpope/vim-rails",
  "tpope/vim-bundler",
  -- Generate ctags for bundled gems
  "tpope/gem-ctags",
  "tpope/vim-projectionist",
  "tpope/vim-rake",
  {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      -- recommended mappings
      -- resizing splits
      -- these keymaps will also accept a range,
      -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
      vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
      vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
      vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
      vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
      -- moving between splits
      vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
      vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
      vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
      vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
      -- swapping buffers between windows
      vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
      vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
      vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
      vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
    end,
  },
  "nvim-tree/nvim-web-devicons",
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = require("plugins.config.nvim_treesitter_context").config
  },
  {
    "Wansmer/treesj",
    keys = {
      "<space>m",
      "<space>j",
      "<space>s",
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("treesj").setup() end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "petertriho/cmp-git",
      "SirVer/ultisnips",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "honza/vim-snippets",
    },
    config = require("plugins.config.nvim_cmp").setup
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
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/typescript.nvim",
    },
    config = require("plugins.config.lspconfig").setup
  },
  "jose-elias-alvarez/typescript.nvim",
  "folke/neodev.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    branch = "0.1.x",
    config = require("plugins.config.telescope").setup
  }
}
