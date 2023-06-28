return {
  "https://github.com/folke/which-key.nvim",
  name = "which-key",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local whichkey = require("which-key")

    whichkey.setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })

    -- TODO: spread out registrations where keybindings are defined.
    -- Look up a better way to centralize keybindings AND have them register from different plugins when available
    whichkey.register({
      ["<leader>f"] = { name = "+find" },
      ["<leader>g"] = { name = "+goto" },
      ["<leader>h"] = { name = "+githunk" },
      ["<leader>t"] = { name = "+test" },
    })
  end,
}
