require("neorg").setup({
	load = {
		["core.defaults"] = {}, -- Loads default behaviour
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
