local M = {}

M.setup = function()
  local telescope = require("telescope")
  local themes = require("telescope.themes")
  local builtin = require("telescope.builtin")

  telescope.setup({
    defaults = {
      preview = {
        filesize_limit = 1.2,
        timeout = 150,
      },
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

  local ivy_theme = themes.get_ivy()

  vim.keymap.set("n", "<leader>fm", function()
    telescope.extensions.metals.commands(ivy_theme)
  end, {
    desc = "Metals",
  })

  vim.keymap.set("n", "<leader>ff", function()
    builtin.find_files(ivy_theme)
  end, {
    desc = "Find files",
  })

  vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep(ivy_theme)
  end, {
    desc = "Grep in project",
  })

  vim.keymap.set("n", "<leader>k", function()
    builtin.grep_string(ivy_theme)
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
