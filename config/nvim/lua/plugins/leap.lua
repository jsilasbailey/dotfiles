return {
  "https://github.com/ggandor/leap.nvim",
  name = "leap",
  config = function()
    require("leap").add_default_mappings()
  end,
}
