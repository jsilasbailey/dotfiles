return {
  "https://github.com/Wansmer/treesj",
  keys = {
    "<space>m",
    "<space>j",
    "<space>s",
  },
  dependencies = { "treesitter" },
  config = function()
    require("treesj").setup({ })
  end,
}
