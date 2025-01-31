return {
  "nvim-lua/plenary.nvim",
  -- "nvim-tree/nvim-web-devicons",
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = require("plugins.config.nvim_treesitter_context").config,
      },
    },
    tag = "v0.9.3",
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
    "tpope/vim-sleuth",
    desc = "Adjust 'shiftwidth' and 'expandtab' heuristically based on the current file",
  },
  {
    "tpope/vim-surround",
    desc = "Work with surrounding brackets/characters",
  },
  {
    "tpope/vim-commentary",
    desc = "Comment/Uncomment lines",
  },
  {
    "tpope/vim-repeat",
    desc = "Repeat plugin commands with `.`",
  },
  {
    "tpope/vim-fugitive",
    desc = "Doing the git; possibly the G.O.A.T",
  },
  { "tpope/vim-rails", ft = "ruby" },
  { "tpope/vim-bundler", ft = "ruby" },
  { "tpope/vim-rake", ft = "ruby" },
  -- TODO: Learn to use these better
  "tpope/vim-abolish",
  "tpope/vim-projectionist",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")
          local function set(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          set("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, "Git Next [H]unk")

          set("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, "Git Prev [H]unk")

          set("n", "<leader>hp", gitsigns.preview_hunk, "Git [H]unk [P]review")
          set("n", "<leader>hr", gitsigns.reset_hunk, "Git [H]unk [R]eset")
          set("n", "<leader>hs", gitsigns.stage_hunk, "Git [H]unk [S]tage")

          set("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "")
          set("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
          end, "Git [H]unk [B]lame")
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
    "stevearc/oil.nvim",
    dependencies = {
      { "echasnovski/mini.icons", opts = { style = "ascii" } },
    },
    config = function()
      ---@module 'oil'
      ---@type oil.SetupOpts
      local opts = {}
      require("oil").setup(opts)

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
  {
    "stevearc/conform.nvim",
    desc = "Smarter formatting using neovim builtin lsp format text edits",
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
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
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
      --
      vim.g["test#strategy"] = "dispatch"
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
    desc = "Split/Join lines utilizing treesitter syntax tree",
    keys = {
      "<space>m",
      "<space>j",
      "<space>s",
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- latest major release
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local i = ls.insert_node
      local fmt = require("luasnip.extras.fmt").fmt

      ls.add_snippets("typescriptreact", {
        s(
          "default",
          fmt(
            [[
          export default function {}({}) {{
            {}
          }}
          ]],
            {
              i(1),
              i(2),
              i(0),
            }
          )
        ),
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      {
        "petertriho/cmp-git",
        dependencies = "nvim-lua/plenary.nvim",
      },
      "folke/lazydev.nvim",
    },
    config = require("plugins.config.nvim_cmp").setup,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      -- vim.uv types
      { "Bilal2453/luvit-meta", lazy = true },
    },
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "b0o/schemastore.nvim",
      "folke/lazydev.nvim",
      {
        "j-hui/fidget.nvim",
        opts = {},
      },
      {
        "mfussenegger/nvim-dap",
        config = function()
          local dap = require("dap")
          local ui = require("dap.ui.widgets")

          vim.keymap.set("n", "<leader>dt", function()
            dap.toggle_breakpoint()
          end, { desc = "[D]ap [T]oggle breakpoint" })

          vim.keymap.set("n", "<leader>dr", function()
            dap.repl.toggle()
          end, { desc = "[D]ap [R]epl toggle" })

          vim.keymap.set("n", "<leader>dh", function()
            ui.hover()
          end, { desc = "[D]ap [H]over expression" })

          dap.configurations.scala = {
            {
              type = "scala",
              request = "launch",
              name = "Run or Test File",
              metals = { runType = "runOrTestFile" },
            },
            {
              type = "scala",
              request = "launch",
              name = "Test Target",
              metals = { runType = "testTarget" },
            },
            {
              type = "scala",
              request = "attach",
              name = "Attach to localhost",
              hostName = "localhost",
              port = 5005,
              buildTarget = "root",
            },
          }
        end,
      },
      {
        "scalameta/nvim-metals",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        ft = { "scala", "sbt", "java" },
        opts = function()
          local metals = require("metals")

          metals.setup_dap()

          local metals_config = metals.bare_config()
          -- "off" will enable LSP progress notifications by Metals and you'll need
          -- to ensure you have a plugin like fidget.nvim installed to handle them.
          --
          -- "on" will enable the custom Metals status extension and you *have* to have
          -- a have settings to capture this in your statusline or else you'll not see
          -- any messages from metals. There is more info in the help docs about this
          metals_config.init_options.statusBarProvider = "off"
          metals_config.settings = {
            showImplicitArguments = true,
            showImplicitConversionsAndClasses = true,
            showInferredType = true,
          }

          metals_config.root_patterns = { "build.sbt", "build.sc", "build.gradle", "pom.xml" }

          metals_config.capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
          )
          metals_config.on_attach = function(_client, bufnr)
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
    "folke/snacks.nvim",
    ---@module 'snacks'
    ---@type snacks.Config
    opts = { input = {} },
  },
  {
    "folke/snacks.nvim",
    ---@module 'snacks'
    ---@type snacks.Config
    opts = { input = {} },
  },
}
