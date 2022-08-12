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
		"rust-analyzer",
		"sumneko_lua",
		"solargraph",
		"typescript-language-server",
		"tailwindcss-language-server",
	},
})

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
	vim.cmd("command! LspDefintion lua vim.lsp.buf.definition()")
	vim.cmd("command! LspDiagnosticLine lua vim.diagnostic.open_float({float = { border = 'rounded' }})")
	vim.cmd("command! LspDiagnosticNext lua vim.diagnostic.goto_next({float = { border = 'rounded' }})")
	vim.cmd("command! LspDiagnosticPrev lua vim.diagnostic.goto_prev({float = { border = 'rounded' }})")
	vim.cmd(
		"command! LspDiagnosticCurrent lua vim.diagnostic.open_float({scope = 'cursor', float = { border = 'rounded' }})"
	)
	vim.cmd("command! LspDiagnosticSetLoclist lua vim.diagnostic.set_loclist()")
	vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
	vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
	vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
	vim.cmd("command! LspReferences lua vim.lsp.buf.references()")
	vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
	vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
	vim.cmd("command! LspTypeDefinition lua vim.lsp.buf.type_definition()")

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "K", ":LspHover<cr>", opts)
	buf_set_keymap("n", "[d", ":LspDiagnosticPrev<cr>", opts)
	buf_set_keymap("n", "]d", ":LspDiagnosticNext<cr>", opts)
	buf_set_keymap("n", "<leader>d", ":LspDiagnosticCurrent<cr>", opts)
	buf_set_keymap("n", "<leader>a", ":LspCodeAction<cr>", opts)
	buf_set_keymap("n", "gd", ":LspDefintion<cr>", opts)
	buf_set_keymap("n", "gy", ":LspTypeDefinition<cr>", opts)

	-- Format on <leader>f
	buf_set_keymap("n", "<leader>f", ":lua vim.lsp.buf.formatting()<cr>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local luadev = require("lua-dev").setup({})
lsp_config.sumneko_lua.setup(luadev)

lsp_config.solargraph.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		formatting = false,
	},
	root_dir = lsp_config.util.root_pattern(".solargraph.yml"),
})

local ts_utils = require("nvim-lsp-ts-utils")
local ts_utils_init_options = ts_utils.init_options
ts_utils_init_options.formatting = false
lsp_config.tsserver.setup({
	init_options = ts_utils_init_options,
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		ts_utils.setup({})
		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		vim.cmd("command! LspTSOrganize TSLspOrganize")
		vim.cmd("command! LspTSRenameFile TSLspRenameFile")
		vim.cmd("command! LspTSImportAll TSLspImportAll")

		on_attach(client, bufnr)
	end,
})

lsp_config.tailwindcss.setup({
	on_attach = on_attach
})

lsp_config.rust_analyzer.setup({
	on_attach = on_attach
})

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local eslint_options = {
	prefer_local = "node_modules/.bin",
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

local erb_lint_options = {
	condition = function(utils)
		return utils.root_has_file({
			".erb-lint.yml",
		})
	end
}

local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = true,
	on_attach = on_attach,
	sources = {
		code_actions.eslint.with(eslint_options),
		code_actions.proselint.with({
			extra_filetypes = { "gitcommit" },
		}),
		code_actions.shellcheck,
		diagnostics.eslint.with(eslint_options),
		diagnostics.erb_lint.with(erb_lint_options),
		diagnostics.gitlint,
		diagnostics.shellcheck,
		diagnostics.proselint.with({
			extra_filetypes = { "gitcommit" },
		}),
		diagnostics.rubocop.with(rubocop_options),
		diagnostics.standardrb.with(standardrb_options),
		diagnostics.write_good.with({
			extra_filetypes = { "gitcommit" },
		}),
		diagnostics.shellcheck,
		diagnostics.zsh,
		formatting.eslint.with(eslint_options),
		formatting.erb_lint.with(erb_lint_options),
		formatting.prettierd.with(prettierd_opts),
		formatting.rubocop.with(rubocop_options),
		formatting.standardrb.with(standardrb_options),
	},
})
