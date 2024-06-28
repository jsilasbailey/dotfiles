return {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = require("plugins.config.treesitter").setup,
  },
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = require("plugins.config.nvim_treesitter_context").config,
  },
  -- Adjust 'shiftwidth' and 'expandtab' heuristically based on the current file
  "tpope/vim-sleuth",
  -- Work with surrounding brackets/characters
  "tpope/vim-surround",
  "tpope/vim-abolish",
  -- Explore improvements
  "tpope/vim-vinegar",
  -- Rake/Rails navigation and help
  "tpope/vim-rails",
  "tpope/vim-bundler",
  "tpope/vim-projectionist",
  "tpope/vim-rake",
  -- Comment/Uncomment lines
  "tpope/vim-commentary",
  -- Repeat plugin commands with `.`
  "tpope/vim-repeat",
  -- Unix helpers
  "tpope/vim-eunuch",
  -- Doing the git
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")
          vim.keymap.set("n", "]h", gitsigns.next_hunk, { buffer = bufnr })
          vim.keymap.set("n", "[h", gitsigns.prev_hunk, { buffer = bufnr })
          vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr })
          vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr })
          vim.keymap.set("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { buffer = bufnr })
          vim.keymap.set("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
          end, { buffer = bufnr })
        end,
      })
    end,
  },
  {
    "tpope/vim-dispatch",
    config = function()
      vim.api.nvim_create_user_command(
        "DashWord",
        "Dispatch! open dash://<cword>",
        { desc = "Open the word under the cursor in Dash" }
      )
    end,
  },
  {
    "stevearc/conform.nvim",
    desc = "Smarter formatting control using formatting fallbacks and formatting smaller sections of the buffer via LSP",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({
            async = true,
            lsp_format = "fallback",
          })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
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
      -- vim.g["test#neovim#start_normal"] = "1"
    end,
    keys = {
      { "<leader>tn", ":TestNearest<cr>", desc = "Test nearest to line" },
      { "<leader>tf", ":TestFile<cr>", desc = "Test file" },
      { "<leader>ta", ":TestSuite<cr>", desc = "Test all tests" },
      { "<leader>tl", ":TestLast<cr>", desc = "Test last test" },
      { "<leader>gt", ":TestVisit<cr>", desc = "Go to test" },
    },
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").create_default_mappings()
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      "<space>m",
      "<space>j",
      "<space>s",
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "SirVer/ultisnips",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "honza/vim-snippets",
      {
        "petertriho/cmp-git",
        dependencies = "nvim-lua/plenary.nvim",
      },
      "folke/lazydev.nvim",
    },
    config = require("plugins.config.nvim_cmp").setup,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/typescript.nvim",
      "hrsh7th/nvim-cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {},
      },
      {
        "scalameta/nvim-metals",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        ft = { "scala", "sbt", "java" },
        opts = function()
          local metals_config = require("metals").bare_config()
          -- "off" will enable LSP progress notifications by Metals and you'll need
          -- to ensure you have a plugin like fidget.nvim installed to handle them.
          --
          -- "on" will enable the custom Metals status extension and you *have* to have
          -- a have settings to capture this in your statusline or else you'll not see
          -- any messages from metals. There is more info in the help docs about this
          metals_config.init_options.statusBarProvider = "off"

          metals_config.capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
          )
          metals_config.on_attach = function(client, bufnr)
            vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, {
              buffer = bufnr,
              desc = "LSP: [C]ode [L]ens Run",
            })

            vim.keymap.set("n", "<leader>ws", function()
              require("metals").hover_worksheet()
            end, { buffer = bufnr, desc = "LSP: [W]ork[S]heet Hover" })

            vim.keymap.set(
              "n",
              "<leader>oi",
              ":MetalsOrganizeImports<cr>",
              { buffer = bufnr, desc = "LSP: [O]rganize [I]mports" }
            )
          end

          return metals_config
        end,
        config = function(self, metals_config)
          local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
          vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
              require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
          })
        end,
      },
    },
    config = require("plugins.config.lspconfig").setup,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    branch = "0.1.x",
    config = require("plugins.config.telescope").setup,
  },
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    config = function()
      -- Generate comment for current line
      vim.keymap.set("n", "<Leader>dg", "<Plug>(doge-generate)")

      -- Interactive mode comment todo-jumping
      vim.keymap.set("n", "<TAB>", "<Plug>(doge-comment-jump-forward)")
      vim.keymap.set("n", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
      vim.keymap.set("i", "<TAB>", "<Plug>(doge-comment-jump-forward)")
      vim.keymap.set("i", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
      vim.keymap.set("x", "<TAB>", "<Plug>(doge-comment-jump-forward)")
      vim.keymap.set("x", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
    end,
  },
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>z", ":ZenMode<CR>" },
    },
    opts = {
      plugins = {
        tmux = { enabled = true },
        options = {
          enabled = true,
          colorcolumn = false,
        },
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}
