return {
	filetypes = { "python" },
	cmd = { "ty", "server" },
	settings = {
		ty = {
			-- ty language server settings go here
		},
	},
	root_markers = {
		".git",
		"pyproject.toml",
		"ty.toml",
	},
}
