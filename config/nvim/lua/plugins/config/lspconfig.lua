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
    rust_analyzer = {},
    solargraph = {},
    eslint = {},
    buf_ls = {},
    tailwindcss = {
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
    },
    rescriptls = {},
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
    automatic_installation = false,
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
