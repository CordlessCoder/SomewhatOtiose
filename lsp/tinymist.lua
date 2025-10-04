return {
	filetypes = { "typst" },
	settings = {
		exportPdf = "onType",
	},
	cmd = { "tinymist" },
	root_dir = function(filename, on_dir)
		local dir = vim.fn.getcwd()
		on_dir(dir)
	end,
}
