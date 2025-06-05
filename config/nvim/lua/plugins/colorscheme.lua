return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = "dark"
      vim.g.zenbones = { darkness = "stark" }

      vim.cmd([[colorscheme zenbones]])

      local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat" })
      vim.api.nvim_set_hl(0, "FloatBorder", {
        fg = normal_float.fg,
        bg = normal_float.bg,
      })
    end,
  },
}
