return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = function()
      vim.opt.background = "dark"
      vim.g.zenbones = { darkness = "stark" }

      vim.cmd([[colorscheme zenbones]])
    end,
  },
}
