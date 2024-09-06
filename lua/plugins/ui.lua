return {
	{ "stevearc/dressing.nvim", event = "VeryLazy", lazy = true },
	{ "https://gitlab.com/HiPhish/rainbow-delimiters.nvim", event = "VeryLazy", lazy = true },
	{
		"folke/noice.nvim",
		enabled = false,
		lazy = false,
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		cond = vim.g.multigrid ~= 1,
	},
	{
		"numToStr/FTerm.nvim",
		enabled = false,
		lazy = true,
		opts = { blend = 20 },
		keys = {
			{
				"<A-x>",
				mode = "n",
				function()
					require("FTerm").toggle()
				end,
			},
			{
				"<A-x>",
				mode = "t",
				function()
					require("FTerm").toggle()
				end,
			},
		},
	},
	{
		enabled = false,
		"folke/zen-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			window = {
				backdrop = 0.95,
				width = 0.80,
			},
			plugins = {
				twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
				gitsigns = { enabled = false }, -- disables git signs
				kitty = {
					enabled = true,
					font = "+4", -- font size increment
				},
			},
		},
		lazy = true,
		cmd = { "ZenMode" },
		keys = {
			{
				"<C-g>",
				function()
					require("zen-mode").toggle()
				end,
				desc = "Focus mode",
			},
		},
	},
	{
		"folke/twilight.nvim",
		enabled = false,
		opts = {
			dimming = {
				alpha = 0.25, -- amount of dimming
				-- we try to get the foreground from the highlight groups or fallback color
				-- color = { "Normal", "#ffffff" },
				-- term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
				inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
			},
			context = 15, -- amount of lines we will try to show around the current line
			treesitter = true, -- use treesitter when available for the filetype
			-- treesitter is used to automatically expand the visible text,
			-- but you can further control the types of nodes that should always be fully expanded
			expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
				"function",
				"method",
				"table",
				"if_statement",
			},
			exclude = {}, -- exclude these filetypes
		},
		lazy = true,
		cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
	},
}
