return {
  "https://github.com/pwntester/octo.nvim",
  name = "octo",
  dependencies = {
    "plenary",
    "telescope",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("octo").setup()
  end,
}
