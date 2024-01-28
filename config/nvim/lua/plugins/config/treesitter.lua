M = {}
M.setup = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "lua",
      "bash",
      "comment",
      "css",
      "dockerfile",
      "gitattributes",
      "javascript",
      "jsdoc",
      "json",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "ruby",
      "rust",
      "scss",
      "sql",
      "todotxt",
      "tsx",
      "typescript",
      "vim",
      "vue",
      "yaml",
    },
    sync_install = true,
    auto_install = false,
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = {},
    },
    indent = {
      enable = true,
    },
    endwise = {
      enable = true,
    },
  })
end
return M
