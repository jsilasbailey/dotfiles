M = {}

M.setup = function()
  -- TODO: Extract concerns to different plugin configs

  local lsp_config = require("lspconfig")
  require("mason").setup()

  local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
  )
  local function organize_imports()
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
      on_attach = function(event)
        vim.keymap.set(
          "n",
          "<leader>oi",
          ":OrganizeImports<cr>",
          { buffer = event.buf, desc = "LSP: [O]rganize [I]mports" }
        )
      end,
      commands = {
        OrganizeImports = {
          organize_imports,
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

      -- Jump to the definition of the word under your cursor.
      --  This is where a variable was first declared, or where a function is defined, etc.
      --  To jump back, press <C-t>.
      map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

      -- Find references for the word under your cursor.
      map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

      -- Jump to the implementation of the word under your cursor.
      --  Useful when your language has ways of declaring types without an actual implementation.
      map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

      -- Jump to the type of the word under your cursor.
      --  Useful when you're not sure what type a variable is and you want to see
      --  the definition of its *type*, not where it was *defined*.
      map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

      -- Fuzzy find all the symbols in your current document.
      --  Symbols are things like variables, functions, types, etc.
      map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

      -- Fuzzy find all the symbols in your current workspace.
      --  Similar to document symbols, except searches over your entire project.
      map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      -- Opens a popup that displays documentation about the word under your cursor
      --  See `:help K` for why this keymap.
      map("K", vim.lsp.buf.hover, "Hover Documentation")

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    end,
  })
end

return M
