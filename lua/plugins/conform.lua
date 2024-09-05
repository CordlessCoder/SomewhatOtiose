local formatters_by_ft = {
	lua = { "stylua" },
	rust = { "rustfmt", "leptosfmt" },
	python = { "black" },
	go = { "gofmt" },
	markdown = { "mdsf" },
	javascript = { "prettier" },
	bash = { "shfmt" },
	c = { "clang_format" },
	cpp = { "clang_format" },
	toml = { "taplo" },
	html = { "prettier" },
	css = { "prettier" },
}
local filetypes = {}
for ft, _ in pairs(formatters_by_ft) do
	filetypes[#filetypes + 1] = ft
end

return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
			formatters = {
				clang_format = {
					prepend_args = {
						"-style={BasedOnStyle: LLVM, IndentWidth: 4, ColumnLimit: 120, AlignConsecutiveAssignments: Consecutive, AlignConsecutiveDeclarations: Consecutive, AlignConsecutiveMacros: Consecutive, AlignEscapedNewlines: Left, AlignOperands: AlignAfterOperator}",
					},
				},
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
	keys = {
		{
			mode = "n",
			"<leader>cf",
			function()
				require("conform").format()
			end,
		},
	},
	event = "BufWritePre",
	lazy = true,
	ft = filetypes,
	cmd = { "ConformInfo" },
}
