return {
	{
		"folke/tokyonight.nvim",
		enabled = false,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			require("tokyonight").setup({
				style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				transparent = true, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = true },
					functions = { bold = true },
					variables = {},
					types = { bold = true },
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "transparent", -- style for sidebars, see below
					floats = "transparent", -- style for floating windows
				},
				sidebars = { "qf", "help", "NvimTree", "nvim_tree", "nvimtree", "tree" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.4, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
				on_colors = function(colors)
					colors.bg = "#12131c"
					colors.green = "#78dba9"
					colors.green1 = "#94f7c5"
					colors.fg_gutter = "#242637"
					colors.teal = "#73C0C9"
				end,
				on_highlights = function(highlights, colors) end,
			})
			vim.cmd.colorscheme("tokyonight-night")
			if vim.g.neovide then
				vim.api.nvim_set_hl(0, "Normal", { background = vim.g.terminal_color_0 })
			end
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true,
				show_end_of_buffer = true, -- show the '~' characters after the end of buffers
				term_colors = true,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = { "italic" },
					types = { "bold" },
					operators = {},
				},
				-- color_overrides = {},
				-- custom_highlights = function(colors)
				-- 	return {
				-- 		Comment = { fg = colors.flamingo },
				-- 		TabLineSel = { bg = colors.pink },
				-- 		CmpBorder = { fg = colors.surface2 },
				-- 		Pmenu = { bg = colors.none },
				-- 	}
				-- end,
				integrations = {
					barbecue = false,
					alpha = true,
					cmp = true,
					gitsigns = true,
					telescope = { enabled = true },
					notify = true,
					lsp_trouble = true,
					treesitter = true,
					treesitter_context = true,
					nvimtree = true,
					mason = true,
					neogit = true,
					dap = true,
					harpoon = true,
					noice = false,
					markdown = true,
					aerial = true,
					dap_ui = true,
					indent_blankline = true,
					nvim_surround = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
			vim.cmd.colorscheme("catppuccin")
			vim.api.nvim_set_hl(0, "@lsp.typemod.variable.mutable", { italic = true })
			if vim.g.neovide then
				vim.api.nvim_set_hl(0, "Normal", { background = vim.g.terminal_color_0 })
			end
		end,
	},
	{
		"decaycs/decay.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("decay").setup({
				style = "cosmic",
				italics = {
					code = true,
					comments = true,
				},
				nvim_tree = {
					contrast = true, -- or false to disable tree contrast
				},
				cmp = {
					block_kind = true,
				},
				palette_overrides = {
					-- comments = "#4d5768", -- #4d5768
					-- background = "#101419",
					-- 	contrast = "#0e1217",
					-- statusline_bg = "#13171c",
					-- 	lighter = "#1a1e23",
					-- 	foreground = "#b6beca",
					-- 	cursorline = "#242931",
					-- 	comments = "#4d5768",
					-- 	cursor = "#b6beca",
					-- 	black = "#242931",
					-- 	red = "#e05f65",
					-- 	orange = "#E89777",
					-- 	yellow = "#f1cf8a",
					-- 	pink = "#f6c9d4",
					-- 	green = "#78dba9",
					-- 	blue = "#70a5eb",
					-- 	teal = "#73C0C9",
					-- 	magenta = "#c68aee",
					-- 	cyan = "#74bee9",
					-- 	sky = "#91c7e7",
					-- 	brightblack = "#485263",
					-- 	brightred = "#e5646a",
					-- 	brightgreen = "#94f7c5",
					-- 	brightyellow = "#f6d48f",
					-- 	brightblue = "#75aaf0",
					-- 	brightmagenta = "#cb8ff3",
					-- 	brightcyan = "#79c3ee",
					-- 	brightwhite = "#e3e6eb",
					-- 	lavender = "#a9acdb", -- TODO: Create own lavender for dark decay
					-- 	accent = "#78dba9",
				},
			})
			if vim.g.neovide then
				vim.api.nvim_set_hl(0, "Normal", { background = vim.g.terminal_color_0 })
			end
		end,
	},
}
