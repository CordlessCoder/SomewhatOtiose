return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
	cmd = {
		"TSUpdateSync",
		"TSBufEnable",
		"TSBufDisable",
		"TSBufToggle",
		"TSConfigInfo",
		"TSDisable",
		"TSEditQuery",
		"TSEditQueryUserAfter",
		"TSEnable",
		"TSInstall",
		"TSInstallFromGrammar",
		"TSInstallInfo",
		"TSInstallSync",
		"TSModuleInfo",
		"TSToggle",
		"TSUninstall",
		"TSUpdate",
		"TSUpdateSync",
	},
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
			colors = {
				"#B7C1EA",
				"#F7768E",
				"#97C566",
				"#D6A764",
				"#759BEC",
				"#B393EC",
				"#78C6F3",
				"#AAB2D5",
			},
		},
		ensure_installed = {
			"lua",
			"html",
			"css",
			"python",
			"markdown",
			"bash",
			"rust",
			"fish",
			"c",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
		textobjects = {
			move = {
				enable = true,
				goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
				goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.inner",
				},
				goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
			},
		},
	},
}
