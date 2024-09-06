return {
	{
		"mrcjkb/rustaceanvim",
		lazy = true,
		version = "^4",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
			{
				lazy = true,
				"lvimuser/lsp-inlayhints.nvim",
				cond = vim.version().minor < 10,
				opts = {},
			},
		},
		ft = { "rust" },
		config = function()
			if vim.version().minor >= 10 then
				vim.g.rustaceanvim = {
					-- Plugin configuration
					tools = {},
					-- LSP configuration
					server = {
						on_attach = function(client, bufnr)
							if vim.version().minor >= 10 then
								local success, _ = pcall(vim.lsp.inlay_hint.enable, true)
								if not success then
									vim.lsp.inlay_hint.enable(0, true)
								end
							end
						end,
						default_settings = {
							-- rust-analyzer language server configuration
							["rust-analyzer"] = {},
						},
					},
					-- DAP configuration
					dap = {},
				}
			else
				vim.g.rustaceanvim = {
					tools = {
						hover_actions = {
							auto_focus = true,
						},
					},
					server = {
						on_attach = function(client, bufnr)
							require("lsp-inlayhints").on_attach(client, bufnr)
						end,
					},
				}
			end
		end,
	},
	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		ft = "toml",
		lazy = true,
	},
}
