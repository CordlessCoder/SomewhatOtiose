return {
	cmd = { "taplo", "lsp", "stdio" },
	filetypes = { "toml" },
	root_dir = function(filename, cb)
		-- local rev = string.reverse(filename)
		-- local from_end = string.find(rev, "/") or 0
		-- return string.sub(filename, 1, string.len(filename) - from_end)
		cb(vim.fn.getcwd())
	end,
}
