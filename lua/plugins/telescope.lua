return {
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
			local ts = require("telescope")
			ts.setup({
				defaults = {
					border = true,
					borderchars = {
						preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
						prompt = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
						results = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
					},
					layout_config = {
						-- height = {
						-- 	0.8,
						-- 	max = 40,
						-- 	min = 15,
						-- },
						preview_cutoff = 80,
						-- preview_width = {
						-- 	0.6,
						-- 	max = 80,
						-- 	min = 20,
						-- },
						-- width = {
						-- 	0.9,
						-- 	max = 80,
						-- 	min = 30,
						-- },
					},
					-- layout_strategy = "center",
					results_title = false,
					-- sorting_strategy = "ascending",
					-- theme = "dropdown",
				},
				pickers = {
					current_buffer_tags = { fname_width = 100 },
					jumplist = { fname_width = 100 },
					loclist = { fname_width = 100 },
					lsp_definitions = { fname_width = 100 },
					lsp_document_symbols = { fname_width = 100 },
					lsp_dynamic_workspace_symbols = { fname_width = 100 },
					lsp_implementations = { fname_width = 100 },
					lsp_incoming_calls = { fname_width = 100 },
					lsp_outgoing_calls = { fname_width = 100 },
					lsp_references = { fname_width = 100 },
					lsp_type_definitions = { fname_width = 100 },
					lsp_workspace_symbols = { fname_width = 100 },
					quickfix = { fname_width = 100 },
					tags = { fname_width = 100 },
				},
				extensions = {
					emoji = {
						action = function(emoji)
							vim.api.nvim_put({ emoji.value }, "c", false, true)
						end,
					},
				},
			})
			ts.load_extension("undo")
			ts.load_extension("emoji")
			ts.load_extension("zoxide")
			ts.load_extension("scope")
		end,
		cmd = { "Telescope" },
		-- event = "UIEnter",
		keys = {
			{
				"<leader>tz",
				function()
					require("telescope").extensions.zoxide.list()
				end,
				desc = "Fuzzy find paths in zoxide",
			},
			{
				"<leader>tn",
				function()
					require("telescope").extensions.notify.notify()
				end,
				desc = "Show notifications",
			},
			{
				"<leader>te",
				function()
					require("telescope").extensions.emoji.emoji()
				end,
				desc = "Show emoji picker",
			},
			{
				"<leader>tu",
				function()
					require("telescope").extensions.undo.undo()
				end,
				desc = "Show undo history",
			},
			{
				"<leader>sR",
				function()
					local function is_git_repo()
						vim.fn.system("git rev-parse --is-inside-work-tree")

						return vim.v.shell_error == 0
					end

					local function get_git_root()
						local dot_git_path = vim.fn.finddir(".git", ".;")
						return vim.fn.fnamemodify(dot_git_path, ":h")
					end

					local opts = {}

					if is_git_repo() then
						opts = {
							cwd = get_git_root(),
						}
					end
					require("telescope.builtin").live_grep(opts)
				end,
				desc = "Fuzzy find from project's git root",
			},
			{
				"<leader>tr",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "Fuzzy find recently opened files",
			},
			{
				"<leader>tg",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Fuzzy search git files",
			},
			{
				"<leader>tl",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Fuzzy find using live grep",
			},
			{
				"<leader>td",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				desc = "Fuzzy find workspace symbols",
			},
			{
				"<leader>tb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Fuzzy find buffers",
			},
			{
				"<leader>f",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Fuzzy find files",
			},
			{
				"<leader>tp",
				function()
					require("telescope.builtin").find_files({ cwd = ".." })
				end,
				desc = "Fuzzy find files in parent directory",
			},
			{
				"gd",
				function()
					require("telescope.builtin").lsp_definitions()
				end,
				desc = "Go to definition",
			},
			{
				"gi",
				function()
					require("telescope.builtin").lsp_implementations()
				end,
				desc = "Go to implementations",
			},
			{
				"gr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "Go to definition",
			},
			{
				"gt",
				function()
					require("telescope.builtin").type_definitions()
				end,
				desc = "Go to definition",
			},
		},
	},
}
