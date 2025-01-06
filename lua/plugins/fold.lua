return {
	"kevinhwang91/nvim-ufo",
	event = "VeryLazy",
	dependencies = { "kevinhwang91/promise-async" },
	lazy = false,
	init = function()
		vim.o.foldcolumn = "0" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
	end,
	config = function()
		require("ufo").setup()
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
	-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
	-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
}
