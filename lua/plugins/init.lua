local LSP_EVENT = "VeryLazy"
local LSP_FILETYPES = { "rust", "lua", "python", "c", "c++", "javascript", "toml" }
return {

	-- { "github/copilot.vim", lazy = true, event = "VeryLazy" },
	-- -- the colorscheme should be available when starting Neovim
	-- { "unblevable/quick-scope", lazy = true, event = LSP_EVENT },
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
		-- dependencies = { "telescope.nvim" },
	},
	{
		"barrett-ruth/live-server.nvim",
		build = "yarn global add live-server",
		config = true,
		lazy = true,
		cmd = { "LiveServerStart", "LiveServerStop" },
	},
	{
		"fedepujol/move.nvim",
		lazy = true,
		cmd = { "MoveLine", "MoveBlock", "MoveHChar", "MoveHBlock", "MoveWord" },
		keys = { "<A-h>", "<A-j>", "<A-k>", "<A-l>", "<A-down>", "<A-up>", "<A-right>", "<A-left>" },
		config = function()
			local move_vert = require("move.core.vert")
			local move_hor = require("move.core.horiz")

			local MoveLine = move_vert.moveLine
			local MoveBlock = move_vert.moveBlock
			local MoveHChar = move_hor.horzChar
			local MoveHBlock = move_hor.horzBlock
			local MoveWord = move_hor.horzWord

			local opts = { noremap = true, silent = true }
			-- Normal-mode commands
			vim.keymap.set("n", "<A-j>", function()
				MoveLine(1, false)
			end, opts)
			vim.keymap.set("n", "<A-down>", function()
				MoveLine(1, false)
			end, opts)
			vim.keymap.set("n", "<A-up>", function()
				MoveLine(-1, false)
			end, opts)
			vim.keymap.set("n", "<A-k>", function()
				MoveLine(-1, false)
			end, opts)
			vim.keymap.set("n", "<A-left>", function()
				MoveHChar(-1)
			end, opts)
			vim.keymap.set("n", "<A-h>", function()
				MoveHChar(-1)
			end, opts)
			vim.keymap.set("n", "<A-right>", function()
				MoveHChar(1)
			end, opts)
			vim.keymap.set("n", "<A-l>", function()
				MoveHChar(1)
			end, opts)
			vim.keymap.set("n", "<leader>wf", function()
				MoveWord(1)
			end, opts)
			vim.keymap.set("n", "<leader>wb", function()
				MoveWord(-1)
			end, opts)
			-- Visual-mode commands
			vim.keymap.set("v", "<A-j>", function()
				MoveBlock(1)
			end, opts)
			vim.keymap.set("v", "<A-k>", function()
				MoveBlock(-1)
			end, opts)

			vim.keymap.set("v", "<A-l>", function()
				MoveHBlock(1)
			end, opts)
			vim.keymap.set("v", "<A-h>", function()
				MoveHBlock(-1)
			end, opts)
		end,
	},
	-- { "nathom/filetype.nvim", lazy = false, priority = 100 },
	{ "ThePrimeagen/vim-be-good", lazy = true, cmd = { "VimBeGood" } },
	{
		"folke/trouble.nvim",
		lazy = true,
		event = "VeryLazy",
		config = true,
		cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
	},
	{
		"folke/todo-comments.nvim",
		lazy = true,
		event = "VeryLazy",
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
					SAFE = { icon = " ", color = "hint", alt = { "SAFETY", "safety", "safe" } },
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
					pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
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
					pattern = [[\b(KEYWORDS):]], -- ripgrep regex
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
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					-- light = "wave",
				},
			})
			vim.cmd.colorscheme("kanagawa")
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
				transparent_background = false,
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
					barbar = true,
					barbecue = false,
					alpha = true,
					cmp = true,
					gitsigns = true,
					telescope = true,
					notify = true,
					leap = true,
					lsp_trouble = true,
					treesitter = true,
					treesitter_context = true,
					nvimtree = true,
					noice = true,
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
		end,
	},

	{
		"metalelf0/jellybeans-nvim",
		enabled = false,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("jellybeans-nvim")
		end,
		dependencies = { "rktjmp/lush.nvim" },
	},
	{
		"folke/tokyonight.nvim",
		enabled = true,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			require("tokyonight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				-- transparent = true, -- Enable this to disable setting the background color
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
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { "qf", "help", "NvimTree", "nvim_tree", "nvimtree", "tree" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.4, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
				on_colors = function(colors)
					-- local function dump(o)
					-- 	if type(o) == "table" then
					-- 		local s = "{ "
					-- 		for k, v in pairs(o) do
					-- 			if type(k) ~= "number" then
					-- 				k = '"' .. k .. '"'
					-- 			end
					-- 			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
					-- 		end
					-- 		return s .. "} "
					-- 	else
					-- 		return tostring(o)
					-- 	end
					-- end
					-- require("notify")(dump(colors))

					-- { ["bg_popup"] = #16161e,["blue7"] = #394b70,["green"] = #9ece6a,["error"] = #db4b4b,["bg_float"] = #16161e,["red"] = #f7768e,["fg_sidebar"] = #a9b1d6,["bg_highlight"] = #292e42,["bg_dark"] = #16161e,["gitSigns"] = { ["change"] = #536c9e,["delete"] = #b2555b,["add"] = #266d6a,} ,["dark3"] = #545c7e,["git"] = { ["change"] = #6183bb,["ignore"] = #545c7e,["delete"] = #914c54,["add"] = #449dab,} ,["dark5"] = #737aa2,["magenta2"] = #ff007c,["bg_sidebar"] = #16161e,["blue2"] = #0db9d7,["fg_gutter"] = #3b4261,["info"] = #0db9d7,["blue1"] = #2ac3de,["blue5"] = #89ddff,["fg"] = #c0caf5,["hint"] = #1abc9c,["diff"] = { ["change"] = #1f2231,["text"] = #394b70,["delete"] = #37222c,["add"] = #20303b,} ,["fg_float"] = #c0caf5,["bg"] = #1a1b26,["orange"] = #ff9e64,["comment"] = #565f89,["bg_statusline"] = #16161e,["blue0"] = #3d59a1,["border"] = #15161e,["green1"] = #73daca,["purple"] = #9d7cd8,["blue6"] = #b4f9f8,["border_highlight"] = #27a1b9,["black"] = #15161e,["warning"] = #e0af68,["fg_dark"] = #a9b1d6,["red1"] = #db4b4b,["cyan"] = #7dcfff,["none"] = NONE,["bg_search"] = #3d59a1,["magenta"] = #bb9af7,["bg_visual"] = #283457,["green2"] = #41a6b5,["blue"] = #7aa2f7,["teal"] = #1abc9c,["terminal_black"] = #414868,["yellow"] = #e0af68,}
					--
					-- comments = "#4d5768", -- #4d5768
					colors.bg = "#12131c"
					colors.green = "#78dba9"
					colors.green1 = "#94f7c5"
					-- colors.hint = "#78dba9"
					colors.fg_gutter = "#242637"
					colors.teal = "#73C0C9"
					-- colors.magenta = "#c68aee"
					-- contrast = "#101119",
					-- statusline_bg = "#1b1d2a",
					-- lighter = "#242637",
					-- foreground = "#A5B7D5",
					-- cursorline = "#2c2f44",
					-- comments = "#343750",
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
					-- 	lavender = "#a9acdb",
					-- 	accent = "#78dba9",
				end,
			})
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	{
		"windwp/nvim-autopairs",
		enabled = false,
		lazy = true,
		event = "BufEnter",
		config = function()
			require("nvim-autopairs").setup()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = LSP_EVENT,
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
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		config = true,
		event = LSP_EVENT,
		ft = LSP_FILETYPES,
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
		enabled = true,
		lazy = true,
		event = "VeryLazy",
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
			"rcarriga/nvim-notify",
		},
		cond = vim.g.multigrid ~= 1,
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
		"romgrk/barbar.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		lazy = true,
		event = "BufEnter",
		config = function()
			require("plugins.configs.barbar")
		end,
	},
	{
		"numToStr/FTerm.nvim",
		config = function()
			vim.keymap.set("n", "<A-x>", function()
				require("FTerm").toggle()
			end)
			vim.keymap.set("t", "<A-x>", function()
				vim.require("FTerm").toggle()
			end)
			vim.keymap.set("t", "<A-x>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		enabled = false,
		lazy = true,
		cmd = {
			"ToggleTerm",
			"ToggleTermToggleAll",
			"TermExec",
			"ToggleTermSendCurrentLine",
			"ToggleTermSendVisualLines",
			"ToggleTermSendVisualSelection",
			"ToggleTermSetName",
		},
		keys = { "<A-v>" },
		config = function()
			require("plugins.configs.toggleterm")
		end,
	},

	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		config = function()
			require("plugins.configs.neorg")
		end,
		dependencies = { { "nvim-lua/plenary.nvim" } },
		lazy = true,
		cmd = { "Neorg" },
		ft = "norg",
	},
	{
		"numToStr/Comment.nvim",
		lazy = true,
		event = "InsertEnter",
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

	-- {
	-- "dstein64/vim-startuptime",
	-- -- lazy-load on a command
	-- cmd = "StartupTime",
	-- },

	-- you can use the VeryLazy event for things that can
	-- load later and are not important for the initial UI
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
								vim.lsp.inlay_hint.enable(0, true)
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
			{ "rcarriga/nvim-dap-ui", opts = {} },
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
			-- dap.adapters.python = {
			-- 	type = "executable",
			-- 	command = os.getenv("HOME") .. "/.virtualenvs/tools/bin/python",
			-- 	args = { "-m", "debugpy.adapter" },
			-- }
		end,
		lazy = true,
	},
	{
		"monaqa/dial.nvim",
		-- lazy-load on keys
		-- mode is `n` by default. For more advanced options, check the section on key mappings
		keys = { "<C-a>", "<C-x>" },
		lazy = true,
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
		event = LSP_EVENT,
		ft = LSP_FILETYPES,
		lazy = true,
		cmd = { "NullLsLog", "NullLsInfo" },
		module = true,
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
	{
		"ggandor/leap.nvim",
		lazy = true,
		keys = { { "s", mode = "n" } },
		config = function()
			vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = vim.g.terminal_color_1 or "red" })
			vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "grey" })
			require("leap").add_default_mappings()
		end,
	},

	{ "f-person/git-blame.nvim", lazy = true, event = "VeryLazy", opts = { enabled = false } },

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
		-- your statusline
		config = function()
			require("plugins.configs.galaxyline")
		end,
		-- some optional icons
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
	},

	-- { "rstacruz/vim-closer", lazy = true, event = "BufEnter" },
	-- { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
	-- { "hrsh7th/cmp-buffer", event = "InsertEnter" },
	-- { "hrsh7th/cmp-path", event = "InsertEnter" },
	-- { "hrsh7th/cmp-cmdline", event = "InsertEnter" },
	-- { "L3MON4D3/LuaSnip", event = "InsertEnter" },

	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
		ft = "toml",
		-- event = "InsertEnter",
		lazy = true,
	},
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		config = function()
			require("plugins.configs.cmp")
		end,
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"rstacruz/vim-closer",
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
		},
		config = function()
			require("plugins.configs.telescope")
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
		cmd = { "LspInfo", "LspLog", "LspRestart", "LspStart", "LspStop" },
		lazy = true,
		event = LSP_EVENT,
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
		event = LSP_EVENT,
		ft = LSP_FILETYPES,
		dependencies = { "nvim-treesitter-context" },
		config = function()
			require("nvim-treesitter.configs").setup({
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

	-- you can use a custom url to fetch a plugin
	-- { url = "git@github.com:folke/noice.nvim.git" },
}
