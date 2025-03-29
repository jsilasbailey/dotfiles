vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true
vim.opt.cursorline = true

vim.opt.mouse = "a"
vim.o.scrolloff = 10

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.o.inccommand = "split"

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

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
