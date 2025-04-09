if vim.o.modifiable then
  vim.api.nvim_set_option_value("spell", true, { scope = "local" })
  vim.api.nvim_set_option_value("textwidth", 100, { scope = "local" })

  -- Function to toggle markdown checkboxes
  local function toggle_checkbox()
    -- Get current line
    local line = vim.api.nvim_get_current_line()

    -- Check if the line contains an unchecked checkbox
    if line:match("- %[ %]") then
      -- Replace unchecked with checked
      local new_line = line:gsub("- %[ %]", "- [x]", 1)
      vim.api.nvim_set_current_line(new_line)
      -- Check if the line contains a checked checkbox
    elseif line:match("- %[x%]") then
      -- Replace checked with unchecked
      local new_line = line:gsub("- %[x%]", "- [ ]", 1)
      vim.api.nvim_set_current_line(new_line)
    end
  end

  -- Map <leader>x to toggle checkbox function
  -- vim.api.nvim_set_keymap("n", "<leader>x", toggle_checkbox, { noremap = true, silent = true })
  vim.keymap.set("n", "<leader>x", toggle_checkbox, { noremap = true, silent = true })
end
