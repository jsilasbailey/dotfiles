return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      tabline = {
        lualine_a = {},
        lualine_b = { { "tabs", mode = 2, use_mode_colors = true } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "branch" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "diff", "diagnostics" },
        lualine_c = { { "filename", path = 4 } },
        lualine_x = {},
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
}
