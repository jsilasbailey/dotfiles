local M = {}

local k = vim.keycode
local esc = k("<Esc>")

M.setup = function()
  local lsp_servers = {
    "lua_ls",
    "tsc",
    "eslint",
    "buf_ls",
    "tailwindcss",
    "rescriptls",
    "bashls",
    "jsonls",
    "ruby_lsp",
  }

  vim.lsp.enable(lsp_servers)

  -- At least `tsc` enables editing linked ranges in tsx html tags
  vim.lsp.linked_editing_range.enable()

  ---This is a workaround for nvim's current client implementation of linked range edits.
  ---For something like `ciw`, which clears the current text, the linked range
  ---disappears before entering the new text, breaking the linked ranges.
  vim.api.nvim_create_user_command("LinkedRename", function(opts)
    vim.cmd.normal({
      "viwo" .. esc .. "i" .. opts.args .. esc .. "lde",
      bang = true,
    })
  end, { nargs = 1, desc = "Rename the linked editing range under the cursor" })

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

      local client = vim.lsp.get_client_by_id(event.data.client_id)

      if client then
        vim.lsp.completion.enable(true, client.id, event.buf)
      end

      if
        client
        and client:supports_method("textDocument/linkedEditingRange")
      then
        vim.keymap.set("n", "grl", ":LinkedRename ", {
          buffer = event.buf,
          desc = "LSP: [R]ename [L]inked range",
        })
      end
    end,
  })
end

return M
