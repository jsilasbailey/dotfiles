vim.filetype.add({
  pattern = {
    [".*%.scala%.html"] = "twirl",
    [".*%.scala%.xml"] = "twirl",
    [".*%.scala%.js"] = "twirl",
    [".*%.scala%.txt"] = "twirl",
  },
})
