return {
	"axieax/urlview.nvim",
	lazy = true,
	cmd = "UrlView",
	keys = { { "[u", mode = "n" }, { "u]", mode = "n" }, "gx" },
	config = function()
		require("urlview").setup({ default_picker = "telescope" })
	end,
	dependencies = { "telescope.nvim" },
}
