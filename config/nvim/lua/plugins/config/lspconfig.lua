M = {}

M.setup = function()
  -- TODO: Extract concerns to different plugin configs

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "gopls",
      "lua_ls",
      "marksman",
      "rust_analyzer",
      "solargraph",
      "tailwindcss",
      "tsserver",
    },
  })

  local lsp_config = require("lspconfig")

  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
  local capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilities)

  local create_lsp_user_commands = function(client, bufnr)
    local opts = { buffer = bufnr }

    vim.api.nvim_buf_create_user_command(bufnr, "LspDiagnosticLine", vim.diagnostic.open_float, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspDiagnosticNext", vim.diagnostic.goto_next, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspDiagnosticPrev", vim.diagnostic.goto_prev, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspDiagnosticSetLoclist", vim.diagnostic.setloclist, {})
    vim.keymap.set("n", "<leader>d", ":LspDiagnosticLine<cr>", opts)
    vim.keymap.set("n", "[d", ":LspDiagnosticPrev<cr>", opts)
    vim.keymap.set("n", "]d", ":LspDiagnosticNext<cr>", opts)

    if client.supports_method("textDocument/codeAction") then
      vim.api.nvim_buf_create_user_command(bufnr, "LspCodeAction", vim.lsp.buf.code_action, {})
      vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
    end

    if client.supports_method("textDocument/definition") then
      vim.api.nvim_buf_create_user_command(bufnr, "LspDefintion", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gd", ":LspDefintion<cr>", opts)
    end

    if client.supports_method("textDocument/implementation") then
      vim.api.nvim_buf_create_user_command(bufnr, "LspImplementation", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "gi", ":LspImplementation<cr>", opts)
    end

    if client.supports_method("textDocument/typeDefinition") then
      vim.api.nvim_buf_create_user_command(bufnr, "LspTypeDefinition", vim.lsp.buf.type_definition, {})
      vim.keymap.set("n", "gy", ":LspTypeDefinition<cr>", opts)
    end

    if client.supports_method("textDocument/hover") then
      vim.api.nvim_buf_create_user_command(bufnr, "LspHover", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "K", ":LspHover<cr>", opts)
    end

    if client.supports_method("textDocument/signatureHelp") then
      vim.api.nvim_buf_create_user_command(bufnr, "LspSignatureHelp", vim.lsp.buf.signature_help, {})
    end

    if client.supports_method("textDocument/documentSymbols") then
      vim.api.nvim_buf_create_user_command(bufnr, "LspDocumentSymbols", vim.lsp.buf.document_symbol, {})
    end

    local filtered_formatting = function()
      vim.lsp.buf.format({
        -- TODO: Depend on abstractions not concretions
        filter = function(ls_client)
          return ls_client.name ~= "tsserver"
        end,
        bufnr = bufnr,
      })
    end

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", filtered_formatting, {})
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("v", "<leader>f", filtered_formatting, opts)
    end

    if client.supports_method("textDocument/references") then
      vim.api.nvim_buf_create_user_command(bufnr, "LspReferences", vim.lsp.buf.references, {})
      -- TODO: Move to trouble config
      vim.keymap.set("n", "gR", ":TroubleToggle lsp_references<cr>", { buffer = bufnr })
    end

    -- FIXME: Range actions not working in TS?
    if client.supports_method("textDocument/rename") then
      vim.api.nvim_buf_create_user_command(bufnr, "LspRename", vim.lsp.buf.rename, {})
    end
  end

  local on_lsp_attach = function(client, bufnr)
    create_lsp_user_commands(client, bufnr)
  end

  require("neodev").setup({})
  lsp_config.lua_ls.setup({
    on_attach = on_lsp_attach,
    capabilities = capabilities,
  })

  lsp_config.solargraph.setup({
    cmd = { "bin/solargraph", "stdio" },
    on_attach = on_lsp_attach,
    capabilities = capabilities
  })

  lsp_config.dockerls.setup({
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  })

  lsp_config.docker_compose_language_service.setup({
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  })

  lsp_config.bashls.setup({
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  })

  lsp_config.tsserver.setup({
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  })

  lsp_config.tailwindcss.setup({
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  })

  lsp_config.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  })

  lsp_config.gopls.setup({
    capabilities = capabilities,
    on_attach = on_lsp_attach,
  })

  lsp_config.marksman.setup({
    capabilities = capabilities,
    on_attach = on_lsp_attach,
    filetypes = {
      "markdown",
    }
  })
end

return M
