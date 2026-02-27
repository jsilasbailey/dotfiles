local read_apple_interface_style =
  "defaults read -g AppleInterfaceStyle 2>/dev/null"

-- Function to set background based on macOS system theme
local function set_background_from_system()
  local handle = io.popen(read_apple_interface_style)

  if handle then
    local result = handle:read("*a")
    handle:close()

    if result:match("Dark") then
      vim.opt.background = "dark"
    else
      vim.opt.background = "light"
    end
  else
    vim.opt.background = "light"
  end
end

local function setup_auto_background_change()
  -- Set background on startup
  set_background_from_system()

  -- Update background when Neovim gains focus
  vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
    callback = function()
      set_background_from_system()
    end,
  })
end

return {
  {
    "oskarnurm/koda.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      setup_auto_background_change()
      require("koda").setup()
      vim.cmd("colorscheme koda")
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   Set background on startup
    --   set_background_from_system()

    --   Update background when Neovim gains focus
    --   vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
    --     callback = function()
    --       set_background_from_system()
    --     end,
    --   })

    --   vim.cmd([[colorscheme zenwritten]])

    --   local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat" })
    --   vim.api.nvim_set_hl(0, "FloatBorder", {
    --     fg = normal_float.fg,
    --     bg = normal_float.bg,
    --   })
    -- end,
  },
}
