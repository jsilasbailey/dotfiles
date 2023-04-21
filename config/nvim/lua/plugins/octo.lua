return {
  "https://github.com/pwntester/octo.nvim",
  name = "octo",
  dependencies = {
    "plenary",
    "telescope",
    "devicons",
  },
  config = function()
    require("octo").setup()
  end,
}
