vim.o.backup = false

vim.o.clipboard = "unnamedplus"

vim.o.number = true

-- Make it obvious where 80 characters is
vim.o.textwidth = 80
vim.o.colorcolumn = "+1"
vim.cmd([[
  autocmd! Filetype qf set colorcolumn&
]])

vim.o.mouse = "a"

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.expandtab = true

vim.o.termguicolors = true
