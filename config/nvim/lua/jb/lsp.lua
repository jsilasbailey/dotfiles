require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"emmet_ls",
		"ruby_ls",
		"rust_analyzer",
		"tailwindcss",
		"tsserver",
	},
})

local lsp_config = require("lspconfig")
local null_ls = require("null-ls")

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
		vim.api.nvim_buf_create_user_command(bufnr, "LspCodeAction", vim.lsp.buf.code_action, { range = nil })
		vim.keymap.set("n", "<leader>a", ":LspCodeAction<cr>", opts)
	end

	if client.supports_method("textDocument/definition") then
		vim.api.nvim_buf_create_user_command(bufnr, "LspDefintion", vim.lsp.buf.definition, {})
		vim.keymap.set("n", "gd", ":LspDefintion<cr>", opts)
	end

	if client.supports_method("textDocument/hover") then
		vim.api.nvim_buf_create_user_command(bufnr, "LspHover", vim.lsp.buf.hover, {})
		vim.keymap.set("n", "K", ":LspHover<cr>", opts)
	end

	if client.supports_method("textDocument/implementation") then
		vim.api.nvim_buf_create_user_command(bufnr, "LspImplementation", vim.lsp.buf.implementation, {})
	end

	if client.supports_method("textDocument/typeDefinition") then
		vim.api.nvim_buf_create_user_command(bufnr, "LspTypeDefinition", vim.lsp.buf.type_definition, {})
		vim.keymap.set("n", "gy", ":LspTypeDefinition<cr>", opts)
	end

	if client.supports_method("textDocument/signatureHelp") then
		vim.api.nvim_buf_create_user_command(bufnr, "LspSignatureHelp", vim.lsp.buf.signature_help, {})
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
		vim.keymap.set("n", "<leader>f", ":LspFormat<cr>", opts)
	end

	if client.supports_method("textDocument/rangeFormatting") then
		vim.keymap.set("v", "<leader>f", filtered_formatting, opts)
	end

	if client.supports_method("textDocument/references") then
		vim.api.nvim_buf_create_user_command(bufnr, "LspReferences", vim.lsp.buf.references, {})
	end

	if client.supports_method("textDocument/rename") then
		vim.api.nvim_buf_create_user_command(bufnr, "LspRename", vim.lsp.buf.rename, {})
	end
end

local on_lsp_attach = function(client, bufnr)
	create_lsp_user_commands(client, bufnr)

	-- TODO: Move to trouble config
	vim.keymap.set("n", "gR", ":TroubleToggle lsp_references<cr>", { buffer = bufnr })
end

require("neodev").setup({})
lsp_config.lua_ls.setup({
	on_attach = on_lsp_attach,
	capabilities = capabilities,
})

-- TODO: Ruby LSP Not working the way I would expect
-- lsp_config.ruby_ls.setup({
-- 	capabilities = capabilities,
-- })

require("typescript").setup({
	server = {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			vim.api.nvim_buf_create_user_command(bufnr, "LspOrganizeImports", "TypescriptOrganizeImports", {})
			vim.api.nvim_buf_create_user_command(bufnr, "LspAddMissingImports", "TypescriptAddMissingImports", {})
			vim.api.nvim_buf_create_user_command(bufnr, "LspFixAll", "TypescriptFixAll", {})
			vim.api.nvim_buf_create_user_command(bufnr, "LspRemoveUnused", "TypescriptRemoveUnused", {})
			vim.api.nvim_buf_create_user_command(bufnr, "LspRenameFile", "TypescriptRenameFile", {})

			on_lsp_attach(client, bufnr)
		end,
	},
})

lsp_config.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = on_lsp_attach,
})

lsp_config.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_lsp_attach,
})

lsp_config.emmet_ls.setup({
	on_attach = on_lsp_attach,
	capabilities = capabilities,
	filetypes = {
		"erb",
		"eruby",
		"html",
		"javascriptreact",
		"javascript.jsx",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
})

local eslint_options = {
	prefer_local = "node_modules/.bin",
	filetypes = {
		"javascript",
		"javascriptreact",
	},
	condition = function(utils)
		return utils.root_has_file({
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.yaml",
			".eslintrc.yml",
			".eslintrc.json",
		})
	end,
}

local prettierd_opts = {
	condition = function(utils)
		return utils.root_has_file({
			".prettierrc",
			".prettierrc.json",
			".prettierrc.yml",
			".prettierrc.yaml",
			".prettierrc.json5",
			".prettierrc.js",
			".prettierrc.cjs",
			".prettierrc.toml",
			"prettier.config.js",
			"prettier.config.cjs",
		})
	end,
}

local standardrb_options = {
	condition = function(utils)
		return utils.root_has_file({
			".standard.yml",
		})
	end,
}

local rubocop_options = {
	condition = function(utils)
		return utils.root_has_file({
			".rubocop.yml",
		})
	end,
}

local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local on_null_ls_attach = function(client, bufnr)
	create_lsp_user_commands(client, bufnr)

	-- Keep internal formatting for `gq`
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
	vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
end

null_ls.setup({
	debug = true,
	on_attach = on_null_ls_attach,
	sources = {
		code_actions.eslint.with(eslint_options),
		code_actions.shellcheck,
		diagnostics.eslint.with(eslint_options),
		diagnostics.gitlint,
		diagnostics.rubocop.with(rubocop_options),
		diagnostics.shellcheck,
		diagnostics.standardrb.with(standardrb_options),
		diagnostics.vale.with({
			filetypes = {
				"gitcommit",
				"markdown",
				"tex",
				"asciidoc",
			},
		}),
		diagnostics.zsh,
		formatting.eslint.with(eslint_options),
		formatting.prettierd.with(prettierd_opts),
		formatting.rubocop.with(rubocop_options),
		formatting.standardrb.with(standardrb_options),
		formatting.stylua,
	},
})
