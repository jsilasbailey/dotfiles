return {
	"https://github.com/vim-test/vim-test",
	requires = "https://github.com/tpope/vim-dispatch",
	config = function()
		vim.g["test#strategy"] = "dispatch"
	end,
	keys = {
		{ "<leader>tn", ":TestNearest<cr>", desc = "Dispatch test nearest to line" },
		{ "<leader>tf", ":TestFile<cr>", desc = "Dispatch test file" },
		{ "<leader>ta", ":TestSuite<cr>", desc = "Dispatch test all tests" },
		{ "<leader>tl", ":TestSuite<cr>", desc = "Dispatch test last test" },
		{ "<leader>gt", ":TestVisit<cr>", desc = "Go to test" },
	},
}
