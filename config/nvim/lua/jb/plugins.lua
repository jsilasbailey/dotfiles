local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  -- Required
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- Split and join lines more intelligently
  use "AndrewRadev/splitjoin.vim"

  -- Easy commenting of lines
  use "tpope/vim-commentary"

  -- Add "end" when needed
  use "tpope/vim-endwise"

  -- Simply designed fast navigation
  use "ggandor/lightspeed.nvim"

  -- Dark pastels colorscheme
  use "frenzyexists/aquarium-vim"

  -- Auto instert bracket pairs
  use "jiangmiao/auto-pairs"

  -- Work with surrounding brackets/characters
  use "tpope/vim-surround"

  -- Doing the git
  use "tpope/vim-fugitive"

  -- Rake/Rails navigation and help
  -- https://github.com/tpope/vim-rails
  -- https://github.com/tpope/vim-rake
  use { "tpope/vim-rails" }
  use {
    "tpope/vim-rake",
    requires = "tpope/vim-projectionist",
  }

  -- cmp completion plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "hrsh7th/vim-vsnip" -- snippets
  use "hrsh7th/cmp-vsnip" -- snippet completion
  use {
    "petertriho/cmp-git",
    requires = "nvim-lua/plenary.nvim",
  } -- git completion
  use "hrsh7th/cmp-nvim-lsp" -- LSP completion

  -- LSP plugins
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/nvim-lsp-ts-utils"

  -- Sync packer
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
