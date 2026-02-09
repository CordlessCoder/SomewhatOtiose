return {
	"kevinhwang91/nvim-ufo",
	event = "BufEnter",
	dependencies = { "kevinhwang91/promise-async" },
	lazy = true,
	init = function()
		vim.o.foldcolumn = "0" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,

	config = function()
		local function get_license_folds(bufnr)
			local license_folds = {}
			local line_count = vim.api.nvim_buf_line_count(bufnr)
			local is_in_license = false
			local license_start = 0

			for i = 0, line_count - 1 do
				local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]
				if not is_in_license and line:match("^%s*" .. vim.o.commentstring .. "*LICENSE NOTICE START") then
					is_in_license = true
					license_start = i
				elseif
					is_in_license
					and (
						line:match("^%s*" .. vim.o.commentstring .. "*LICENSE NOTICE END")
						or not line:match("^%s*" .. vim.o.commentstring:sub(1, 1) .. "*")
					)
				then
					is_in_license = false
					table.insert(license_folds, { startLine = license_start, endLine = i, kind = "marker" })
				end
			end

			if is_in_license then
				table.insert(license_folds, { startLine = license_start, endLine = line_count - 1, kind = "marker" })
			end

			return license_folds
		end

		local function treesitter_and_license_folding(bufnr)
			local license_folds = get_license_folds(bufnr)
			local treesitter_folds = require("ufo").getFolds(bufnr, "treesitter")
			for _, fold in ipairs(license_folds) do
				table.insert(treesitter_folds, fold)
			end
			return treesitter_folds
		end

		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				-- return ftMap[filetype] or {'treesitter', 'indent'}
				return treesitter_and_license_folding
			end,
			close_fold_kinds_for_ft = { rust = { "marker" } },
		})
	end,
	keys = {
		{
			mode = "n",
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
		},
		{
			mode = "n",
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
		},
	},
}
