local M = {}

M.setup = function()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      path_display = { "truncate" },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        hidden = true,
        layout_strategy = "center",
        layout_config = { width = 0.5 },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  telescope.load_extension("fzf")

  vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<cr>", {
    noremap = true,
    silent = true,
    desc = "Find files",
  })

  vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<cr>", {
    noremap = true,
    silent = true,
    desc = "Grep in project",
  })

  vim.api.nvim_set_keymap("n", "<leader>k", ":Telescope grep_string<cr>", {
    noremap = true,
    silent = true,
    desc = "Grep word under cursor",
  })

  vim.api.nvim_set_keymap("n", "z=", ":Telescope spell_suggest<cr>", {
    noremap = true,
    silent = true,
    desc = "Spelling suggestions",
  })
end

return M
