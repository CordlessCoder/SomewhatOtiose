return {
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		lazy = true,
		ft = { "html", "css" },
		cmd = {
			"TailwindConcealEnable",
			"TailwindConcealDisable",
			"TailwindConcealToggle",
			"TailwindColorEnable",
			"TailwindColorDisable",
			"TailwindColorToggle",
			"TailwindSort",
			"TailwindSortSync",
			"TailwindSortSelection",
			"TailwindSortSelectionSync",
			"TailwindNextClass",
			"TailwindPrevClass",
		},
		opts = {},
	},
	{
		"barrett-ruth/live-server.nvim",
		build = "yarn global add live-server",
		config = true,
		lazy = true,
		cmd = { "LiveServerStart", "LiveServerStop" },
	},
}
