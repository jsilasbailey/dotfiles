local M = {}

M.setup = function()
  local telescope = require("telescope")
  local themes = require("telescope.themes")
  local builtin = require("telescope.builtin")

  telescope.setup({
    defaults = {
      path_display = {
        shorten = { len = 2, exclude = { 1, 2, -1 } },
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

  vim.keymap.set("n", "<leader>ff", function()
    builtin.find_files(themes.get_ivy())
  end, {
    desc = "Find files",
  })

  vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep()
  end, {
    desc = "Grep in project",
  })

  vim.keymap.set("n", "<leader>k", function()
    builtin.grep_string()
  end, {
    desc = "Grep word under cursor",
  })

  vim.keymap.set("n", "z=", function()
    builtin.spell_suggest(themes.get_cursor())
  end, {
    noremap = true,
    silent = true,
    desc = "Spelling suggestions",
  })
end

return M
