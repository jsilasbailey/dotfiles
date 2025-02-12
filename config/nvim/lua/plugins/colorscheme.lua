vim.cmd([[
  highlight CursorLine gui=none cterm=none guibg=#201d2a
  highlight ColorColumn guibg=#201d2a
]])

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    branch = "main",
    config = function()
      require("rose-pine").setup({
        groups = {
          border = "foam",
        },
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },
  { "jaredgorski/fogbell.vim" },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
  },
}
