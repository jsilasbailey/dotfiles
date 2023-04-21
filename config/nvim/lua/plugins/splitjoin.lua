return {
	"https://github.com/AndrewRadev/splitjoin.vim",
	name = "splitjoin",
	config = function()
		vim.g.splitjoin_ruby_curly_braces = 0
		vim.g.splitjoin_ruby_hanging_args = 0
		vim.g.splitjoin_ruby_options_as_arguments = 1
	end,
	keys = {
		{ "gS", nil, desc = "Split to lines" },
		{ "gJ", nil, desc = "Join to line" }
	}
}
