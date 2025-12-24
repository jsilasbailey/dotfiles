-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- https://lazy.folke.io/
require("lazy").setup({
  spec = { { import = "plugins" } },

  -- Automatically check for plugin updates
  checker = {
    enabled = true,
    notify = false,
  },

  -- Disable plugin file change detection
  change_detection = { enabled = false },
})

require("options")
require("keymaps")
require("jot")
