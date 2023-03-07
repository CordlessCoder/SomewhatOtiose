return {

	-- { "github/copilot.vim", lazy = true, event = "VeryLazy" },
	-- -- the colorscheme should be available when starting Neovim
	{ "ThePrimeagen/vim-be-good", lazy = true, cmd = { "VimBeGood" } },
	{
		"folke/tokyonight.nvim",
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
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
			})
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	{
		"windwp/nvim-autopairs",
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
		"wakatime/vim-wakatime",
		lazy = true,
		event = "BufEnter",
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
	},
	{
		"norcalli/nvim-colorizer.lua",
		lazy = true,
		event = "BufEnter",
		config = function()
			require("colorizer").setup()
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
		"akinsho/toggleterm.nvim",
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

	{
		"simrat39/rust-tools.nvim",
		enable = true,
		-- after = "nvim-lspconfig",
		config = function()
			require("plugins.configs.rust-tools")
		end,
		event = "BufEnter",
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
		"Pocco81/TrueZen.nvim",
		cmd = {
			"TZAtaraxis",
			"TZMinimalist",
			"TZFocus",
			"TZNarrow",
		},
		config = function()
			require("plugins.configs.truezen")
		end,
		lazy = true,
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
			require("plugins.configs.null-ls").setup()
		end,
		event = "BufEnter",
		lazy = true,
	},

	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins.configs.alpha")
		end,
		lazy = false,
	},

	{ "justinmk/vim-sneak", lazy = true, keys = { { "s", mode = "n" } } },
	{ "f-person/git-blame.nvim", lazy = true, event = "VeryLazy" },

	-- The tree file manager
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		config = function()
			require("plugins.configs.nvim-tree")
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
		lazy = false,
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
		event = "InsertEnter",
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
		tag = "0.1.1",
		-- or                            , branch = '0.1.x',
		dependencies = { "plenary.nvim" },
		init = function()
			require("plugins.configs.telescope")
		end,
		cmd = { "Telescope" },
		lazy = true,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
		end,
		cmd = { "LspInfo", "LspRestart", "LspStart" },
		lazy = false,
	},

	-- Lazy loading:
	-- Load on specific commands
	-- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

	-- Load on an autocommand event
	-- use {'andymass/vim-matchup', event = 'VimEnter'}

	-- Plugins can have post-install/update hooks
	-- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

	{ "p00f/nvim-ts-rainbow", event = "VeryLazy", lazy = true },

	-- Post-install/update hook with neovim command
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufEnter",
		config = function()
			require("nvim-treesitter").setup({
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
			vim.cmd([[TSEnable highlight]])
		end,
		lazy = true,
	},

	-- you can use a custom url to fetch a plugin
	-- { url = "git@github.com:folke/noice.nvim.git" },
}
