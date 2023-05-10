return {
  "https://github.com/vim-test/vim-test",
  requires = "https://github.com/tpope/vim-dispatch",
  config = function()
    -- Async test execution
    --
    -- CustomStrategy to return focus to current window
    --
    -- https://github.com/vim-test/vim-test/issues/448
    -- function! CustomStrategy(cmd)
    --   execute 'bel 10 new'
    --   call termopen(a:cmd)
    --   wincmd p " switch back to last window
    -- endfunction
    --
    -- let test#custom_strategies = {'custom': function('CustomStrategy')}
    -- let test#strategy = "custom"
    --
    -- OR use neotest for lua async strategies
    -- https://github.com/nvim-neotest/neotest
    vim.g["test#strategy"] = "neovim"
  end,
  keys = {
    { "<leader>tn", ":TestNearest<cr>", desc = "Test nearest to line" },
    { "<leader>tf", ":TestFile<cr>", desc = "Test file" },
    { "<leader>ta", ":TestSuite<cr>", desc = "Test all tests" },
    { "<leader>tl", ":TestLast<cr>", desc = "Test last test" },
    { "<leader>gt", ":TestVisit<cr>", desc = "Go to test" },
  },
}
