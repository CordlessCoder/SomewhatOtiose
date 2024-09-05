return {
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
}
