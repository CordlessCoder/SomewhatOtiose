return {
	"norcalli/nvim-colorizer.lua",
	lazy = true,
	event = "VeryLazy",
	config = function()
		require("colorizer").setup({
			html = {
				mode = "background",
			},
		})
		vim.cmd.ColorizerAttachToBuffer()
	end,
}
