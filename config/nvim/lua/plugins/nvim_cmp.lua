return {
  "https://github.com/hrsh7th/nvim-cmp",
  name = "nvim_cmp",
  dependencies = {
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/hrsh7th/cmp-cmdline",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/petertriho/cmp-git",
    "https://github.com/SirVer/ultisnips",
    "https://github.com/quangnguyen30192/cmp-nvim-ultisnips",
    "https://github.com/honza/vim-snippets",
  },
  config = function()
    -- Setup nvim-cmp.
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
      return
    end

    require("cmp_git").setup()

    -- Provide text completion from all open buffers
    local all_open_buffers_source = {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    }

    local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
          cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          cmp_ultisnips_mappings.jump_backwards(fallback)
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP completion.
        { name = "ultisnips" }, -- Ultisnip completion.
        all_open_buffers_source,
      }),
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
        { name = "github" },
      }, {
        all_open_buffers_source,
      }),
    })

    -- Use current buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
