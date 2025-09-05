local M = {}

M.setup = function()
  require("mason").setup()

  local lsp_servers = {
    "lua_ls",
    "ts_ls",
    "eslint",
    "buf_ls",
    "tailwindcss",
    "rescriptls",
    "bashls",
    "jsonls",
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

  vim.lsp.config("lua_ls", {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath("config")
          and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            "lua/?.lua",
            "lua/?/init.lua",
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          },
          -- Or pull in all of 'runtimepath'.
          -- NOTE: this is a lot slower and will cause issues when working on
          -- your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- library = {
          --   vim.api.nvim_get_runtime_file('', true),
          -- }
        },
      })
    end,
    settings = {
      Lua = {},
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
        vim.lsp.buf.hover({ border = "solid" })
      end, { buffer = event.buf, desc = "LSP: [H]over" })
    end,
  })
end

return M
