return {
	"folke/lazydev.nvim",
	lazy = true,
	ft = "lua",
	opts = {
		library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
	dependencies = {
		{ "Bilal2453/luvit-meta", lazy = true },
	},
}
