local telescope = require("telescope")

telescope.setup({
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
})
telescope.load_extension("undo")
telescope.load_extension("emoji")
telescope.load_extension("zoxide")
