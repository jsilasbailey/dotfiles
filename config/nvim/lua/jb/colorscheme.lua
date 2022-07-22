local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
	vim.notify("Catppuccin not found. Get it here: https://github.com/catppuccin/nvim")
	return
end

-- Options: latte, frappe, macchiato, mocha
catppuccin.setup()
vim.g.catppuccin_flavour = "mocha"
vim.cmd([[colorscheme catppuccin]])
