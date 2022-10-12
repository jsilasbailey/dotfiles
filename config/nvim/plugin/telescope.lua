local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local trouble = require("trouble.providers.telescope")

telescope.setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			n = { ["<C-q>"] = trouble.open_with_trouble },
			i = { ["<C-q>"] = trouble.open_with_trouble },
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		find_files = {
			theme = "ivy",
			hidden = true,
		},
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		dash = {
			debounce = 100,
			file_type_keywords = {
				ruby = { "ruby", "rails", "rubygems" },
			},
		},
	},
})

telescope.load_extension("fzf")

vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<cr>", {
	noremap = true,
	silent = true,
})

vim.api.nvim_set_keymap("n", "<leader>rg", ":Telescope live_grep<cr>", {
	noremap = true,
	silent = true,
})

vim.api.nvim_set_keymap("n", "<leader>k", ":Telescope grep_string<cr>", {
	noremap = true,
	silent = true,
})
