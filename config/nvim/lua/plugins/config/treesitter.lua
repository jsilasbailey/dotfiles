local M = {}

local languages = {
  "bash",
  "comment",
  "css",
  "dockerfile",
  "gitattributes",
  "javascript",
  "jsdoc",
  "json",
  "make",
  "python",
  "regex",
  "ruby",
  "rust",
  "scala",
  "scss",
  "sql",
  "todotxt",
  "tsx",
  "typescript",
  "vue",
  "yaml",
  "lua",
}

M.setup = function()
  require("nvim-treesitter").install(languages)

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
    callback = function(event)
      local lang = vim.treesitter.language.get_lang(event.match)
      if not lang then
        return
      end

      local ok, added = pcall(vim.treesitter.language.add, lang)
      if not (ok and added) then
        return
      end

      vim.treesitter.start(event.buf, lang)
      vim.bo[event.buf].indentexpr =
        "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return M
