-- local LSP_EVENT = "VeryLazy"
local LSP_FILETYPES = {
	"rust",
	"lua",
	"python",
	"c",
	"cpp",
	"c++",
	"javascript",
	"toml",
	"php",
	"bash",
	"kdl",
	"fish",
	"go",
	"c#",
	"json",
	"jsonc",
}
return {
	"https://github.com/b0o/SchemaStore.nvim",
	{
		"rstacruz/vim-closer",
		lazy = true,
		event = "InsertEnter",
	},
	{
		"stevearc/aerial.nvim",
		lazy = true,
		cmd = {
			"AerialToggle",
			"AerialOpen",
			"AerialOpenAll",
			"AerialClose",
			"AerialCloseAll",
			"AerialNext",
			"AerialPrev",
			"AerialGo",
			"AerialInfo",
			"AerialNavToggle",
			"AerialNavOpen",
			"AerialNavClose",
		},
		config = function()
			require("aerial").setup({
				backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },

				keymaps = {
					["?"] = "actions.show_help",
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.jump",
					["<2-LeftMouse>"] = "actions.jump",
					["<C-v>"] = "actions.jump_vsplit",
					["<C-s>"] = "actions.jump_split",
					["p"] = "actions.scroll",
					["<C-j>"] = "actions.down_and_scroll",
					["<C-k>"] = "actions.up_and_scroll",
					["{"] = "actions.prev",
					["}"] = "actions.next",
					["[["] = "actions.prev_up",
					["]]"] = "actions.next_up",
					["q"] = "actions.close",
					["o"] = "actions.tree_toggle",
					["za"] = "actions.tree_toggle",
					["O"] = "actions.tree_toggle_recursive",
					["zA"] = "actions.tree_toggle_recursive",
					["l"] = "actions.tree_open",
					["zo"] = "actions.tree_open",
					["L"] = "actions.tree_open_recursive",
					["zO"] = "actions.tree_open_recursive",
					["h"] = "actions.tree_close",
					["zc"] = "actions.tree_close",
					["H"] = "actions.tree_close_recursive",
					["zC"] = "actions.tree_close_recursive",
					["zr"] = "actions.tree_increase_fold_level",
					["zR"] = "actions.tree_open_all",
					["zm"] = "actions.tree_decrease_fold_level",
					["zM"] = "actions.tree_close_all",
					["zx"] = "actions.tree_sync_folds",
					["zX"] = "actions.tree_sync_folds",
				},
				lazy_load = false,

				-- Disable aerial on files with this many lines
				disable_max_lines = 100000,

				-- Disable aerial on files this size or larger (in bytes)
				disable_max_size = 1024 * 1024 * 8,

				-- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
				-- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
				nerd_font = true,

				treesitter = {
					-- How long to wait (in ms) after a buffer change before updating
					update_delay = 50,
				},

				markdown = {
					-- How long to wait (in ms) after a buffer change before updating
					update_delay = 50,
				},

				asciidoc = {
					-- How long to wait (in ms) after a buffer change before updating
					update_delay = 50,
				},

				man = {
					-- How long to wait (in ms) after a buffer change before updating
					update_delay = 50,
				},
			})
			vim.keymap.set("n", "<leader>ao", function()
				require("aerial").open()
			end)
			vim.keymap.set("n", "<leader>at", function()
				require("telescope").load_extension("aerial")
				require("telescope").extensions.aerial.aerial()
			end)
			vim.keymap.set("n", "<leader>ac", function()
				require("aerial").close()
			end)
		end,
		keys = { "<leader>ao", "<leader>at", "<leader>ac" },
	},
	{
		"tiagovla/scope.nvim",
		lazy = false,
		config = function()
			require("scope").setup({})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()
			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<leader>hc", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<leader>hn", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<leader>he", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<leader>hi", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<leader>ho", function()
				harpoon:list():select(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-P>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-L>", function()
				harpoon:list():next()
			end)
		end,
		lazy = true,
		keys = {
			"<leader>ha",
			"<leader>hc",
			"<leader>hn>",
			"<leader>he>",
			"<leader>hi>",
			"<leader>ho>",
			"<C-P>",
			"<C-L>",
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		lazy = true,
		keys = {
			{ "<C-g>s", mode = "i" },
			{ "<C-g>S", mode = "i" },
			{ "ys", mode = "n" },
			{ "yss", mode = "n" },
			{ "yS", mode = "n" },
			{ "ySS", mode = "n" },
			{ "S", mode = "v" },
			{ "gS", mode = "v" },
			{ "ds", mode = "n" },
			{ "cs", mode = "n" },
			{ "cS", mode = "n" },
		},
		-- event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
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
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
		lazy = true,
		cmd = { "Neogit" },
	},
	{
		"axieax/urlview.nvim",
		lazy = true,
		cmd = "UrlView",
		keys = { { "[u", mode = "n" }, { "u]", mode = "n" }, "gx" },
		config = function()
			require("urlview").setup({ default_picker = "telescope" })
		end,
		dependencies = { "telescope.nvim" },
	},
	{
		"barrett-ruth/live-server.nvim",
		build = "yarn global add live-server",
		config = true,
		lazy = true,
		cmd = { "LiveServerStart", "LiveServerStop" },
	},
	-- { "nathom/filetype.nvim", lazy = false, priority = 100 },
	{ "ThePrimeagen/vim-be-good", lazy = true, cmd = { "VimBeGood" } },
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		lazy = true,
		ft = LSP_FILETYPES,
		config = function()
			require("todo-comments").setup({
				signs = true, -- show icons in the signs column
				sign_priority = 8, -- sign priority
				-- keywords recognized as todo comments
				keywords = {
					FIX = {
						icon = " ", -- icon used for the sign, and in search results
						color = "error", -- can be a hex color, or a named color (see below)
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
						-- signs = false, -- configure signs for some keywords individually
					},
					TODO = { icon = " ", color = "info" },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					SAFE = { icon = " ", color = "hint", alt = { "SAFETY", "safety", "safe", "Safety" } },
					TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				},
				-- gui_style = {
				-- 	fg = "NONE", -- The gui style to use for the fg highlight group.
				-- 	bg = "BOLD", -- The gui style to use for the bg highlight group.
				-- },
				merge_keywords = true, -- when true, custom keywords will be merged with the defaults
				-- highlighting of the line containing the todo comment
				-- * before: highlights before the keyword (typically comment characters)
				-- * keyword: highlights of the keyword
				-- * after: highlights after the keyword (todo text)
				highlight = {
					multiline = true, -- enable multine todo comments
					multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
					multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
					before = "", -- "fg" or "bg" or empty
					keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
					after = "fg", -- "fg" or "bg" or empty
					pattern = { [[#\s*<(KEYWORDS)\s*]], [[.*<(KEYWORDS)\s*:]] }, -- pattern or table of patterns, used for highlighting (vim regex)
					comments_only = true, -- uses treesitter to match keywords in comments only
					max_line_len = 400, -- ignore lines longer than this
					exclude = {}, -- list of file types to exclude highlighting
				},
				-- list of named colors where we try to extract the guifg from the
				-- list of highlight groups or use the hex color if hl not found as a fallback
				-- colors = {
				-- 	error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				-- 	warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				-- 	info = { "DiagnosticInfo", "#2563EB" },
				-- 	hint = { "DiagnosticHint", "#10B981" },
				-- 	default = { "Identifier", "#7C3AED" },
				-- 	test = { "Identifier", "#FF00FF" },
				-- },
				search = {
					command = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					-- regex that will be used to match keywords.
					-- don't replace the (KEYWORDS) placeholder
					pattern = [[\b(KEYWORDS)]], -- ripgrep regex
					-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
				},
			})
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
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = false,
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
					enabled = true,
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
					-- barbar = true,
					barbecue = false,
					alpha = true,
					cmp = true,
					gitsigns = true,
					telescope = true,
					notify = true,
					-- leap = true,
					lsp_trouble = true,
					treesitter = true,
					nvimtree = true,
					mason = true,
					neogit = true,
					dap = true,
					harpoon = true,
					noice = false,
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
		"folke/tokyonight.nvim",
		enabled = true,
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
			})
			vim.cmd.colorscheme("tokyonight-night")
			if vim.g.neovide then
				vim.api.nvim_set_hl(0, "Normal", { background = vim.g.terminal_color_0 })
			end
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		ft = LSP_FILETYPES,
		config = function()
			vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#E06C75", nocombine = true })
			vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#E5C07B", nocombine = true })
			vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = "#98C379", nocombine = true })
			vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = "#56B6C2", nocombine = true })
			vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = "#61AFEF", nocombine = true })
			vim.api.nvim_set_hl(0, "IndentBlanklineIndent6", { fg = "#C678DD", nocombine = true })
			require("ibl").setup({

				-- for example, context is off by default, use this to turn it on
				-- show_current_context = true,
				-- char = {
				-- 	"IndentBlanklineIndent1",
				-- 	"IndentBlanklineIndent2",
				-- 	"IndentBlanklineIndent3",
				-- 	"IndentBlanklineIndent4",
				-- 	"IndentBlanklineIndent5",
				-- 	"IndentBlanklineIndent6",
				-- },
			})
		end,
	},
	{
		"wakatime/vim-wakatime",
		lazy = true,
		event = "VeryLazy",
		cond = function()
			local f = io.open((os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") or "/root") .. "/.wakatime.cfg", "r")
			if f ~= nil then
				io.close(f)
				return true
			else
				return false
			end
		end,
	},
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
		"rcarriga/nvim-notify",
		lazy = true,
		cmd = { "Notifications" },
	},
	{
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
	},
	{
		"willothy/nvim-cokeline",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for v0.4.0+
			"nvim-tree/nvim-web-devicons", -- If you want devicons
			"stevearc/resession.nvim", -- Optional, for persistent history
		},
		config = function()
			local get_hex = require("cokeline.hlgroups").get_hl_attr
			local is_picking_focus = require("cokeline.mappings").is_picking_focus
			local is_picking_close = require("cokeline.mappings").is_picking_close
			local getdiagnostics = require("config.utils.getdiagnostics")

			require("cokeline").setup({
				sidebar = {
					filetype = { "NvimTree", "neo-tree", "undotree" },
					components = {
						{
							text = function(buf)
								return buf.filetype
							end,
							fg = vim.g.terminal_color_3,
							bg = function()
								return get_hex("NvimTreeNormal", "bg")
							end,
							bold = true,
						},
					},
				},

				default_hl = {
					fg = function(buffer)
						return buffer.is_focused and get_hex("ColorColumn", "bg") or get_hex("Normal", "fg")
					end,
					bg = function(buffer)
						return buffer.is_focused and get_hex("Normal", "fg") or get_hex("ColorColumn", "bg")
					end,
				},

				components = {
					{ text = " " },
					{
						text = function(buffer)
							return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. " "
								or buffer.devicon.icon
						end,
						fg = function(buffer)
							return (is_picking_focus() and vim.g.terminal_color_3)
								or (is_picking_close() and vim.g.terminal_color_1)
								or buffer.devicon.color
						end,
						italic = function()
							return (is_picking_focus() or is_picking_close())
						end,
						bold = function()
							return (is_picking_focus() or is_picking_close())
						end,
					},
					{
						text = function(buffer)
							return buffer.unique_prefix
						end,
						fg = get_hex("Comment", "fg"),
						italic = true,
					},
					{
						text = function(buffer)
							return buffer.filename .. " "
						end,
						underline = function(buffer)
							return buffer.is_hovered and not buffer.is_focused
						end,
						fg = function(buffer)
							local total = getdiagnostics(buffer.number, { min = "INFO", max = "ERROR" })
							if total == 0 then
								return buffer.is_focused and get_hex("ColorColumn", "bg") or get_hex("Normal", "fg")
							end
							if getdiagnostics(buffer.number, "ERROR") > 0 then
								return "ErrorMsg"
							end
							if getdiagnostics(buffer.number, "WARN") > 0 then
								return "WarningMsg"
							end
							return "Character"
						end,
					},

					{
						text = function(buffer)
							local harpoon = require("harpoon")
							for idx, value in ipairs(harpoon:list():display()) do
								if buffer.path:match(value:format("%s$")) then
									return idx .. " "
								end
							end
							return ""
						end,
						fg = "Directory",
					},
					{
						text = "",
						on_click = function(_, _, _, _, buffer)
							buffer:delete()
						end,
						fg = function(buffer)
							if buffer.is_modified then
								return "WarningMsg"
							end
							return nil
						end,
					},
					{
						text = " ",
					},
				},
			})
		end,
		lazy = false,
	},
	-- {
	-- 	enabled = true,
	-- 	"romgrk/barbar.nvim",
	-- 	dependencies = "nvim-tree/nvim-web-devicons",
	-- 	lazy = false,
	-- 	event = "BufEnter",
	-- 	config = function()
	-- 		require("plugins.configs.barbar")
	-- 	end,
	-- },
	{
		"numToStr/FTerm.nvim",
		lazy = true,
		config = function()
			vim.keymap.set("n", "<A-x>", function()
				require("FTerm").toggle()
			end)
			vim.keymap.set("t", "<A-x>", function()
				require("FTerm").toggle()
			end)
			require("FTerm").setup({
				blend = 20,
			})
		end,
		keys = { { "<A-x>", mode = "n" }, { "<A-x>", mode = "t" } },
	},
	{
		"nvim-neorg/neorg",
		config = function()
			require("plugins.configs.neorg")
		end,
		dependencies = { { "nvim-lua/plenary.nvim", { "vhyrro/luarocks.nvim", config = true } } },
		lazy = true,
		cmd = { "Neorg" },
		ft = "norg",
	},
	{
		"numToStr/Comment.nvim",
		lazy = true,
		cmd = {
			"CommentToggle",
		},
		keys = {
			{ "gcc", mode = "n" },
			{ "gco", mode = "n" },
			{ "gcO", mode = "n" },
			{ "gcA", mode = "n" },
			{ "gbc", mode = "n" },
			{ "gb", mode = "v" },
			{ "gc", mode = "v" },
		},
		config = function()
			require("Comment").setup()
		end,
	},

	{ "stevearc/dressing.nvim", event = "VeryLazy", lazy = true },

	-- {
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	dependencies = { "nvim-lspconfig" },
	-- 	config = function()
	-- 		require("lsp_lines").setup()
	-- 	end,
	-- 	lazy = true,
	-- },
	{ "folke/neodev.nvim", opts = {
		library = { plugins = { "nvim-dap-ui" }, types = true },
	}, lazy = true },
	{
		"mrcjkb/rustaceanvim",
		lazy = true,
		version = "^4",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
			{
				"lvimuser/lsp-inlayhints.nvim",
				cond = vim.version().minor < 10,
				opts = {},
			},
		},
		ft = { "rust" },
		config = function()
			if vim.version().minor >= 10 then
				vim.g.rustaceanvim = {
					-- Plugin configuration
					tools = {},
					-- LSP configuration
					server = {
						on_attach = function(client, bufnr)
							-- you can also put keymaps in here

							if vim.version().minor >= 10 then
								local success, _ = pcall(vim.lsp.inlay_hint.enable, true)
								if not success then
									vim.lsp.inlay_hint.enable(0, true)
								end
							end
						end,
						default_settings = {
							-- rust-analyzer language server configuration
							["rust-analyzer"] = {},
						},
					},
					-- DAP configuration
					dap = {},
				}
			else
				vim.g.rustaceanvim = {
					tools = {
						hover_actions = {
							auto_focus = true,
						},
					},
					server = {
						on_attach = function(client, bufnr)
							require("lsp-inlayhints").on_attach(client, bufnr)
						end,
					},
				}
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", opts = {}, dependencies = {
				{ "nvim-neotest/nvim-nio" },
			} },
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {
					enabled = true, -- enable this plugin (the default)
					enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
					highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
					highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
					show_stop_reason = true, -- show stop reason when stopped for exceptions
					commented = false, -- prefix virtual text with comment string
					only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
					all_references = false, -- show virtual text on all all references of the variable (not only definitions)
					clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
					--- A callback that determines how a variable is displayed or whether it should be omitted
					--- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
					--- @param buf number
					--- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
					--- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
					--- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
					--- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
					display_callback = function(variable, buf, stackframe, node, options)
						if options.virt_text_pos == "inline" then
							return " = " .. variable.value
						else
							return variable.name .. " = " .. variable.value
						end
					end,
					-- virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
					virt_text_pos = "eol",

					-- experimental features:
					all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
					virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
					virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
					-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
				},
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
		cmd = {
			"DapContinue",
			"DapLoadLaunchJSON",
			"DapRestartFrame",
			"DapSetLogLevel",
			"DapShowLog",
			"DapStepInto",
			"DapStepOut",
			"DapStepOver",
			"DapTerminate",
			"DapToggleBreakpoint",
			"DapToggleRepl",
			"DapVirtualTextDisable",
			"DapVirtualTextEnable",
			"DapVirtualTextForceRefresh",
			"DapVirtualTextToggle",
		},
		lazy = true,
	},
	{
		"monaqa/dial.nvim",
		keys = {
			{ "<C-a>", mode = "n" },
			{ "<C-x>", mode = "n" },
			{ "g<C-a>", mode = "n" },
			{ "g<C-x>", mode = "n" },
			{ "<C-a>", mode = "v" },
			{ "<C-x>", mode = "v" },
			{ "g<C-a>", mode = "v" },
			{ "g<C-x>", mode = "v" },
		},
		lazy = true,
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.hexcolor.new({
						case = "lower",
					}),
					augend.integer.alias.decimal_int,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
				},
				visual = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.alpha,
					augend.constant.alias.Alpha,
				},
			})
			vim.keymap.set("n", "<C-a>", function()
				require("dial.map").manipulate("increment", "normal")
			end)
			vim.keymap.set("n", "<C-x>", function()
				require("dial.map").manipulate("decrement", "normal")
			end)
			vim.keymap.set("n", "g<C-a>", function()
				require("dial.map").manipulate("increment", "gnormal")
			end)
			vim.keymap.set("n", "g<C-x>", function()
				require("dial.map").manipulate("decrement", "gnormal")
			end)
			vim.keymap.set("v", "<C-a>", function()
				require("dial.map").manipulate("increment", "visual")
			end)
			vim.keymap.set("v", "<C-x>", function()
				require("dial.map").manipulate("decrement", "visual")
			end)
			vim.keymap.set("v", "g<C-a>", function()
				require("dial.map").manipulate("increment", "gvisual")
			end)
			vim.keymap.set("v", "g<C-x>", function()
				require("dial.map").manipulate("decrement", "gvisual")
			end)
		end,
	},

	{
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
	},
	{
		"folke/twilight.nvim",
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

	{
		"williamboman/mason.nvim",
		config = function()
			require("plugins.configs.mason")
		end,
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonLog", "MasonUninstall", "MasonUninstallAll" },
		lazy = true,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lspconfig" },
		config = function()
			require("plugins.configs.null_ls").setup()
		end,
		lazy = true,
		ft = LSP_FILETYPES,
		cmd = { "NullLsLog", "NullLsInfo" },
		keys = { { "<leader>cf", mode = "n" } },
	},

	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.configs.alpha")
		end,
		lazy = false,
	},

	-- {
	-- 	"justinmk/vim-sneak",
	-- 	lazy = true,
	-- 	keys = { { "s", mode = "n" } },
	-- 	config = function()
	-- 		vim.cmd("let g:sneak#label = 1")
	-- 	end,
	-- },
	-- {
	-- 	"ggandor/leap.nvim",
	-- 	lazy = true,
	-- 	keys = { { "s", mode = "n" } },
	-- 	config = function()
	-- 		vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = vim.g.terminal_color_1 or "red" })
	-- 		vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "grey" })
	-- 		require("leap").add_default_mappings()
	-- 	end,
	-- },

	{
		"f-person/git-blame.nvim",
		lazy = true,
		opts = { enabled = "<leader>gb", desc = "Toggle git blame display" },
		config = function()
			vim.keymap.set("n", "<leader>gb", function()
				require("gitblame").toggle()

				local present, galaxyline = pcall(require, "galaxyline")
				if present then
					galaxyline.load_galaxyline()
				end
			end)

			vim.g.gitblame_display_virtual_text = 0
			vim.g.gitblame_enabled = false
			require("gitblame").setup({
				delay = 0,
			})
		end,
		cmd = {
			"GitBlameToggle",
			"GitBlameEnable",
			"GitBlameDisable",
			"GitBlameCopySHA",
			"GitBlameCopyCommitURL",
			"GitBlameOpenFileURL",
			"GitBlameCopyFileURL",
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- The tree file manager
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		config = function()
			require("plugins.configs.nvim-tree")

			-- Bufferline api on resize
			local nvim_tree_events = require("nvim-tree.events")
			local present, bufferline_api = pcall(require, "bufferline.api")
			if not present then
				return
			end

			local function get_tree_size()
				return require("nvim-tree.view").View.width
			end

			nvim_tree_events.subscribe("TreeOpen", function()
				bufferline_api.set_offset(get_tree_size() + 1)
			end)

			nvim_tree_events.subscribe("Resize", function()
				bufferline_api.set_offset(get_tree_size() + 1)
			end)

			nvim_tree_events.subscribe("TreeClose", function()
				bufferline_api.set_offset(0)
			end)
		end,
		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
		lazy = true,
	},
	{
		"glepnir/galaxyline.nvim",
		branch = "main",
		config = function()
			require("plugins.configs.galaxyline")
		end,
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"andweeb/presence.nvim",
		config = function()
			require("presence"):setup({
				neovim_image_text = "I am still in your walls.",
				buttons = {
					{ label = "Your codebase are belong to us.", url = "https://github.com/CordlessCoder/OxiiLink" },
					{ label = "Check package for pipe bomb.", url = "https://github.com/CordlessCoder" },
				},
				-- enable_line_number = true,
				-- line_number_text = "Line %s/%s",
			})
		end,
		event = "VeryLazy",
		lazy = true,
		enabled = false,
	},

	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({})
		end,
		ft = "toml",
		lazy = true,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		ft = LSP_FILETYPES,
		-- load cmp on InsertEnter
		event = "InsertEnter",
		config = function()
			require("plugins.configs.cmp")
		end,
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = {
			"plenary.nvim",
			"telescope-emoji.nvim",
			"debugloop/telescope-undo.nvim",
			"xiyaowong/telescope-emoji.nvim",
			"jvgrootveld/telescope-zoxide",
			"tiagovla/scope.nvim",
		},
		config = function()
			require("plugins.configs.telescope")
			local telescope = require("telescope")
			telescope.load_extension("undo")
			telescope.load_extension("emoji")
			telescope.load_extension("zoxide")
			telescope.load_extension("scope")
		end,
		cmd = { "Telescope" },
		-- event = "UIEnter",
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("neodev").setup({
				-- add any options here, or leave empty to use the default settings
			})
			require("plugins.configs.lspconfig")
		end,
		event = nil,
		lazy = true,
		cmd = { "LspInfo", "LspLog", "LspRestart", "LspStart", "LspStop" },
		ft = LSP_FILETYPES,
	},

	-- Lazy loading:
	-- Load on specific commands
	-- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

	-- Load on an autocommand event
	-- use {'andymass/vim-matchup', event = 'VimEnter'}

	-- Plugins can have post-install/update hooks
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
		run = "cd app && yarn install",
		cmd = "MarkdownPreview",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{ "https://gitlab.com/HiPhish/rainbow-delimiters.nvim", event = "VeryLazy", lazy = true },

	-- Post-install/update hook with neovim command
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		ft = LSP_FILETYPES,
		cmd = {
			"TSUpdateSync",
			"TSBufEnable",
			"TSBufDisable",
			"TSBufToggle",
			"TSConfigInfo",
			"TSDisable",
			"TSEditQuery",
			"TSEditQueryUserAfter",
			"TSEnable",
			"TSInstall",
			"TSInstallFromGrammar",
			"TSInstallInfo",
			"TSInstallSync",
			"TSModuleInfo",
			"TSToggle",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				indent = { enable = true },
				highlight = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
					colors = {
						"#B7C1EA",
						"#F7768E",
						"#97C566",
						"#D6A764",
						"#759BEC",
						"#B393EC",
						"#78C6F3",
						"#AAB2D5",
					},
				},
				ensure_installed = {
					"lua",
					"html",
					"css",
					"python",
					"markdown",
					"bash",
					"rust",
					"fish",
				},
			})
			-- vim.cmd.TSEnable("highlight")
		end,
		lazy = true,
	},
}
