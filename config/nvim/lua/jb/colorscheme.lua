-- local catppuccin = require("catppuccin")
-- Options: latte, frappe, macchiato, mocha
-- vim.g.catppuccin_flavour = "mocha"
-- catppuccin.setup()

local material = require("material")
material.setup({ plugins = { "telescope", "trouble", "nvim-cmp" } })
vim.g.material_style = "palenight"

vim.cmd "colorscheme material"
