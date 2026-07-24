local M = {}

M.setup = function()
  local lsp_servers = {
    "lua_ls",
    "tsgo",
    "eslint",
    "buf_ls",
    "tailwindcss",
    "rescriptls",
    "bashls",
    "jsonls",
    "ruby_lsp",
  }

  vim.lsp.enable(lsp_servers)

  vim.lsp.config("tailwindcss", {
    settings = {
      tailwindCSS = {
        classFunctions = { "tw", "twx", "clsx" },
        experimental = {
          classRegex = {
            "[a-zA-Z]*ClassName='([^']+)'",
            '[a-zA-Z]*ClassName="([^"]+)"',
            "[a-zA-Z]*ClassName={`([^`]+)`}",
          },
        },
      },
    },
  })

  vim.lsp.config("jsonls", {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),

    callback = function(event)
      -- TODO: If supports go to def
      vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
      end, { buffer = event.buf, desc = "LSP: [G]o to [D]efinition" })

      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded" })
      end, { buffer = event.buf, desc = "LSP: [H]over" })
    end,
  })
end

return M
