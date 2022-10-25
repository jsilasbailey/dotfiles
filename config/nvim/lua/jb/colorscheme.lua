-- local material = require("material")
-- material.setup({ plugins = { "telescope", "trouble", "nvim-cmp" } })
-- vim.g.material_style = "palenight"
-- vim.cmd "colorscheme material"
--
local catppuccin = require("catppuccin")

catppuccin.setup({
	-- Options: latte, frappe, macchiato, mocha
	flavour = "mocha",
	integrations = {
		cmp = true,
		lightspeed = true,
		lsp_trouble = true,
		mason = true,
		telescope = true,
		treesitter = true,

		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
	},
})

vim.api.nvim_command("colorscheme catppuccin")
