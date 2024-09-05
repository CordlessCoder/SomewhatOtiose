return {
	"NvChad/nvim-colorizer.lua",
	lazy = true,
	event = "VeryLazy",
	config = function()
		require("colorizer").setup({
			html = {
				mode = "background",
			},
		})
		require("colorizer").attach_to_buffer(0, {})
	end,
}
