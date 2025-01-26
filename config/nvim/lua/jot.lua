local M = {}

-- Resolve the jot file path once when the module loads
local home = os.getenv("HOME")
local jot_file = home .. "/jot.md"

-- Clear the command line
local function clear()
  vim.cmd("redraw")
end

function M.append_note()
  vim.ui.input({
    prompt = "Note: ",
    default = "",
  }, function(input)
    if input then
      local note = "- " .. input .. "\n"
      local file = io.open(jot_file, "a")

      if file then
        file:write(note)
        file:close()

        clear()

        vim.notify("Note added to jot.md", vim.log.levels.INFO)
      else
        vim.notify("Failed to open jot.md", vim.log.levels.ERROR)
      end
    end
  end)
end

vim.api.nvim_create_user_command("Jot", function()
  M.append_note()
end, {})

vim.keymap.set("n", "<Leader>j", ":Jot<CR>", { noremap = true, silent = true })

return M
