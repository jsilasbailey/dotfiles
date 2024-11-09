local M = {}

M.setup = function()
  local cmp = require("cmp")
  -- TODO: Change to luasnip? Learn how to build your own snippets.
  local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
  local cmp_git = require("cmp_git")
  cmp_git.setup()

  -- Provide text completion from all open buffers
  local all_open_buffers_source = {
    name = "buffer",
    option = {
      get_bufnrs = function()
        return vim.api.nvim_list_bufs()
      end,
    },
  }

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    completion = { completeopt = "menu,menuone,noinsert" },
    mapping = cmp.mapping.preset.insert({
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<C-Space>"] = cmp.mapping.complete({ select = true }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<C-l>"] = cmp.mapping(function(fallback)
        cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
      end, { "i", "s" }),
      ["<C-h>"] = cmp.mapping(function(fallback)
        cmp_ultisnips_mappings.jump_backwards(fallback)
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = "lazydev", group_index = 0 },
      { name = "nvim_lsp" },
      { name = "lazydev" },
      { name = "ultisnips" },
    }, {
      { name = "buffer" },
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
end

return M
