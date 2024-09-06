return {
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
	end,
	keys = {
		{
			"<leader>ao",
			function()
				require("aerial").open()
			end,
			desc = "Open aerial",
		},
		{
			"<leader>at",
			function()
				require("aerial").toggle()
			end,
			desc = "Toggle aerial",
		},
		{
			"<leader>ta",
			function()
				require("telescope").load_extension("aerial")
				require("telescope").extensions.aerial.aerial()
			end,
			desc = "Telescope search aerial",
		},
		{
			"<leader>ac",
			function()
				require("aerial").close()
			end,
			desc = "Close aerial",
		},
	},
}
