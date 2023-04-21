local M = {}

function M.config()
  vim.g.splitjoin_ruby_curly_braces = 0
  vim.g.splitjoin_ruby_hanging_args = 0
  vim.g.splitjoin_ruby_options_as_arguments = 1
end

return M
