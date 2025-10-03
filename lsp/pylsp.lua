return {
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				jedi_completion = {
					fuzzy = true,
				},
				pyflakes = {
					enabled = false,
				},
				yapf = {
					enabled = false,
				},
				autopep8 = {
					enabled = false,
				},
				flake8 = {
					enabled = true,
					maxLineLength = 129,
					indentsize = 4,
				},
				pycodestyle = {
					-- ignore = { "W391" },
					enabled = false,
					maxLineLength = 129,
				},
			},
		},
	},
}
