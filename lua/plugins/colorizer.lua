return {
	"catgoose/nvim-colorizer.lua",
	lazy = true,
	event = "BufReadPre",
	config = function()
		require("colorizer").setup({
			html = {
				mode = "background",
			},
		})
	end,
	keys = {
		{
			"<leader>ct",
			function()
				vim.cmd.ColorizerToggle()
			end,
			desc = "󰌁   Toggle colorizer",
		},
	},
}
