vim.g["test#strategy"] = "dispatch"
vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>ta", ":TestSuite<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>tg", ":TestVisit<cr>", { silent = true })
