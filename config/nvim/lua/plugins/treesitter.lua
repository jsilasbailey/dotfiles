return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  config = function()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.embedded_template = {
      install_info = {
        url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
        files = { "src/parser.c" },
        branch = "main",
        requires_generate_from_grammar = false,
      },
      used_by = "eruby"
    }

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
      endwise = {
        enable = true,
      },
    })
  end,
}
