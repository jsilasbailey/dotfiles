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
      vim.cmd("colorscheme rose-pine")
    end,
  },
}
