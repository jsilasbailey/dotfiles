vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.colorcolumn="80"

vim.opt.mouse = "a"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false

vim.opt.timeout = true
vim.opt.timeoutlen = 300

vim.opt.completeopt = "menuone,noselect"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.shiftround = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.termguicolors = true
