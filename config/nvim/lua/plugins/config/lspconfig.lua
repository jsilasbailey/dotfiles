local M = {}

M.setup = function()
  -- TODO: Extract concerns to different plugin configs

  local lsp_config = require("lspconfig")
  require("mason").setup()

  local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
  )

  local function ts_organize_imports()
    local params = {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
      title = "",
    }
    vim.lsp.buf.execute_command(params)
  end

  local servers = {
    lua_ls = {},
    bashls = {},
    docker_compose_language_service = {},
    dockerls = {},
    gopls = {},
    marksman = {},
    rust_analyzer = {},
    solargraph = {},
    eslint = {},
    tailwindcss = {
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              "[a-zA-Z]*ClassName='([^']+)'",
              '[a-zA-Z]*ClassName="([^"]+)"',
              "[a-zA-Z]*ClassName={`([^`]+)`}",
            },
          },
        },
      },
    },
    ts_ls = {
      on_attach = function(_, bufnr)
        vim.keymap.set(
          "n",
          "<leader>oi",
          ":OrganizeImports<cr>",
          { buffer = bufnr, desc = "LSP: [O]rganize [I]mports" }
        )
      end,
      commands = {
        OrganizeImports = {
          ts_organize_imports,
          description = "Organize Typescript Imports",
        },
      },
    },
    jsonls = {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
  }
  local ensure_installed = vim.tbl_keys(servers or {})

  require("mason-lspconfig").setup({
    ensure_installed = ensure_installed,
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        lsp_config[server_name].setup(server)
      end,
    },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),

    callback = function(event)
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      local hover_options = {
        border = "double",
        anchor_bias = "below",
      }
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, hover_options)
    end,
  })
end

return M
