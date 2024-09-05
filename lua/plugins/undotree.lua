return {
	"jiaoshijie/undotree",
	config = true,
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = { -- load the plugin only when using it's keybinding:
		{
			"<leader>u",
			function()
				require("undotree").toggle()
			end,
		},
	},
}
