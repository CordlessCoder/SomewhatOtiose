return {
	"lukas-reineke/indent-blankline.nvim",
	lazy = true,
	event = "VeryLazy",
	config = function()
		require("ibl").setup({})
	end,
}
