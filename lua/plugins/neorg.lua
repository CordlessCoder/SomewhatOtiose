return {
	"nvim-neorg/neorg",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.keybinds"] = {
					config = {
						default_keybinds = true,
					},
				},
				["core.concealer"] = {}, -- Adds pretty icons to your documents
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/notes",
						},
					},
				},
				["core.integrations.treesitter"] = {
					config = {
						configure_parsers = true,
						install_parsers = true,
					},
				},
				["core.export"] = {},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
			},
		})
	end,
	dependencies = { { "nvim-lua/plenary.nvim", { "vhyrro/luarocks.nvim", config = true } } },
	lazy = true,
	cmd = { "Neorg" },
	ft = "norg",
}
