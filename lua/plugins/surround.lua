return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	lazy = true,
	keys = {
		{ "<C-g>s", mode = "i" },
		{ "<C-g>S", mode = "i" },
		{ "ys", mode = "n" },
		{ "yss", mode = "n" },
		{ "yS", mode = "n" },
		{ "ySS", mode = "n" },
		{ "S", mode = "v" },
		{ "gS", mode = "v" },
		{ "ds", mode = "n" },
		{ "cs", mode = "n" },
		{ "cS", mode = "n" },
	},
	opts = {},
}
