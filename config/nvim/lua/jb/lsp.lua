local lspconfig_status, lsp_config = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

mason.setup({})
mason_lspconfig.setup({
	ensure_installed = {
		"emmet_ls",
		"rust_analyzer",
		"tailwindcss",
		"tsserver",
	},
})

local create_lsp_user_commands = function(bufnr)
	vim.api.nvim_buf_create_user_command(bufnr, "LspDiagnosticLine", vim.diagnostic.open_float, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspDiagnosticNext", vim.diagnostic.goto_next, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspDiagnosticPrev", vim.diagnostic.goto_prev, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspDiagnosticSetLoclist", vim.diagnostic.setloclist, {})

	vim.api.nvim_buf_create_user_command(bufnr, "LspDefintion", vim.lsp.buf.definition, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspCodeAction", vim.lsp.buf.code_action, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", vim.lsp.buf.formatting, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspHover", vim.lsp.buf.hover, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspImplementation", vim.lsp.buf.implementation, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspReferences", vim.lsp.buf.references, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspRename", vim.lsp.buf.rename, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspSignatureHelp", vim.lsp.buf.signature_help, {})
	vim.api.nvim_buf_create_user_command(bufnr, "LspTypeDefinition", vim.lsp.buf.type_definition, {})
end

local on_lsp_attach = function(client, bufnr)
	create_lsp_user_commands(bufnr)

	local opts = { buffer = bufnr, noremap = true, silent = true }

	vim.keymap.set("n", "K", ":LspHover<cr>", opts)
	vim.keymap.set("n", "<leader>d", ":LspDiagnosticLine<cr>", opts)
	vim.keymap.set("n", "[d", ":LspDiagnosticPrev<cr>", opts)
	vim.keymap.set("n", "]d", ":LspDiagnosticNext<cr>", opts)
	vim.keymap.set("n", "<leader>a", ":LspCodeAction<cr>", opts)
	vim.keymap.set("n", "gd", ":LspDefintion<cr>", opts)
	vim.keymap.set("n", "gy", ":LspTypeDefinition<cr>", opts)
	vim.keymap.set("n", "gR", ":TroubleToggle lsp_references<cr>", opts)
	vim.keymap.set("n", "<leader>f", ":LspFormat<cr>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("neodev").setup({})
lsp_config.lua_ls.setup({
	on_attach = on_lsp_attach,
	capabilities = capabilities,
})

lsp_config.solargraph.setup({
	capabilities = capabilities,
	on_attach = on_lsp_attach,
	init_options = {
		formatting = false,
	},
})

require("typescript").setup({
	server = {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			vim.api.nvim_buf_create_user_command(bufnr, "LspOrganizeImports", "TypescriptOrganizeImports", {})
			vim.api.nvim_buf_create_user_command(bufnr, "LspAddMissingImports", "TypescriptAddMissingImports", {})
			vim.api.nvim_buf_create_user_command(bufnr, "LspFixAll", "TypescriptFixAll", {})
			vim.api.nvim_buf_create_user_command(bufnr, "LspRemoveUnused", "TypescriptRemoveUnused", {})
			vim.api.nvim_buf_create_user_command(bufnr, "LspRenameFile", "TypescriptRenameFile", {})

			-- Delegate to prettier
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			on_lsp_attach(client, bufnr)
		end,
		init_options = {
			formatting = false,
		},
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

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

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
	create_lsp_user_commands(bufnr)

	local opts = { buffer = bufnr, noremap = true, silent = true }

	vim.keymap.set("n", "<leader>d", ":LspDiagnosticLine<cr>", opts)
	vim.keymap.set("n", "[d", ":LspDiagnosticPrev<cr>", opts)
	vim.keymap.set("n", "]d", ":LspDiagnosticNext<cr>", opts)
	vim.keymap.set("n", "<leader>a", ":LspCodeAction<cr>", opts)
	vim.keymap.set("n", "<leader>f", ":LspFormat<cr>", opts)

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
		diagnostics.vale.with({ filetypes = {
			"gitcommit",
			"markdown",
			"tex",
			"asciidoc",
		} }),
		diagnostics.zsh,
		formatting.eslint.with(eslint_options),
		formatting.prettierd.with(prettierd_opts),
		formatting.rubocop.with(rubocop_options),
		formatting.standardrb.with(standardrb_options),
		formatting.stylua,
	},
})
