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
  "https://github.com/tpope/vim-dispatch",
  -- Rake/Rails navigation and help
  "https://github.com/tpope/vim-rails",
  "https://github.com/tpope/vim-bundler",
  -- Generate ctags for bundled gems
  "https://github.com/tpope/gem-ctags",
  "https://github.com/tpope/vim-projectionist",
  "https://github.com/tpope/vim-rake",
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      -- recommended mappings
      -- resizing splits
      -- these keymaps will also accept a range,
      -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
      vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
      vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
      -- moving between splits
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
      -- swapping buffers between windows
      vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
      vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
      vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
      vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
    end,
  },
  "AndrewRadev/splitjoin.vim", -- Still need for erb files while not using treesitter on them
  "nvim-tree/nvim-web-devicons",
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "https://github.com/folke/trouble.nvim",
    name = "trouble",
    dependencies = "nvim-tree/nvim-web-devicons",
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
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  "https://github.com/jose-elias-alvarez/typescript.nvim",
  "https://github.com/folke/neodev.nvim",
  {
    "https://github.com/jose-elias-alvarez/null-ls.nvim",
    name = "null_ls",
    dependencies = "plenary",
  },
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
  }
}
