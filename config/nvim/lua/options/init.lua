vim.opt.swapfile = false
vim.opt.backup = false

local undodir = os.getenv("HOME") .. "/.vim/undodir"
local undo_max_age_days = 90

vim.opt.undodir = undodir
vim.opt.undofile = true

-- Neovim never expires undo files, so we have to trim it
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    if vim.fn.isdirectory(undodir) == 0 then
      return
    end
    vim.fn.jobstart({
      "find",
      undodir,
      "-type",
      "f",
      "-mtime",
      "+" .. undo_max_age_days,
      "-delete",
    }, { detach = true })
  end,
})

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

vim.opt.mouse = "a"
vim.o.scrolloff = 10

vim.opt.number = true

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
