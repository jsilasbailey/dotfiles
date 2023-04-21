local status, _ = pcall(require, "catppuccin")

if status then
  vim.api.nvim_command("colorscheme catppuccin")
end
