local lspconfig_status, nvim_lsp = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local lsp_installer_status, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_status then
	return
end

-- Include the servers you want to have installed by default below
local servers = {
	"html",
	"solargraph",
	"tailwindcss",
	"tsserver",
}

for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found then
		if not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end
end

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
	buf_set_keymap("n", "gd", ":LspDefintion<cr>", opts)
	buf_set_keymap("n", "gy", ":LspTypeDefinition<cr>", opts)

	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = capabilities,
	}

	if server.name == "solargraph" then
		opts.init_options = {
			formatting = false,
		}
		opts.root_dir = nvim_lsp.util.root_pattern(".solargraph.yml")
	end

	if server.name == "tsserver" then
		-- Needed for inlayHints. Merge this table with your settings or copy
		-- it from the source if you want to add your own init_options.
		opts.init_options = require("nvim-lsp-ts-utils").init_options
		opts.on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({})
			-- required to fix code action ranges and filter diagnostics
			ts_utils.setup_client(client)

			vim.cmd("command! LspTSOrganize TSLspOrganize")
			vim.cmd("command! LspTSRenameFile TSLspRenameFile")
			vim.cmd("command! LspTSImportAll TSLspImportAll")

			on_attach(client, bufnr)
		end
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local eslint_d_options = {
	prefer_local = "node_modules/.bin",
	condition = function(utils)
		return utils.root_has_file({
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
	prefer_local = "node_modules/.bin",
}

local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	on_attach = on_attach,
	sources = {
		code_actions.eslint_d.with(eslint_d_options),
		code_actions.proselint.with({
			extra_filetypes = { "gitcommit" },
		}),
		diagnostics.eslint_d.with(eslint_d_options),
		diagnostics.gitlint,
		diagnostics.proselint.with({
			extra_filetypes = { "gitcommit" },
		}),
		diagnostics.standardrb,
		diagnostics.write_good.with({
			extra_filetypes = { "gitcommit" },
		}),
		-- formatting.eslint_d.with(eslint_d_options),
		diagnostics.shellcheck,
		formatting.prettierd.with(prettierd_opts),
		formatting.standardrb,
		formatting.stylua,
	},
})
