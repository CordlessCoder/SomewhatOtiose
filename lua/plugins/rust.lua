return {
	{
		"mrcjkb/rustaceanvim",
		lazy = true,
		version = "^7",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
		},
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				-- Plugin configuration
				tools = {},
				-- LSP configuration
				server = {
					on_attach = function(client, bufnr)
						local success, _ = pcall(vim.lsp.inlay_hint.enable, true)
						if not success then
							vim.lsp.inlay_hint.enable(0, true)
						end
					end,
					default_settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							cargo = {
								features = "all",
							},
						},
					},
				},
				-- DAP configuration
				dap = {},
			}
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
