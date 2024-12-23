local formatters_by_ft = {
	lua = { "stylua" },
	rust = { "rustfmt", "leptosfmt" },
	python = { "black" },
	go = { "gofmt", "goimports-reviser" },
	markdown = { "mdsf" },
	javascript = { "prettier" },
	typescript = { "prettier" },
	svelte = { "prettier" },
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
					prepend_args = function(self, ctx)
						if
							vim.fn.filereadable(ctx.dirname .. "/.clang-format") == 1
							or vim.fn.filereadable(ctx.dirname .. "/_clang-format") == 1
						then
							return {
								"-style=file",
							}
						end
						return {
							"-style={Language: Cpp, BasedOnStyle: LLVM, IndentWidth: 4, MaxEmptyLinesToKeep: 2, ColumnLimit: 200, PenaltyBreakAssignment: 2, PenaltyReturnTypeOnItsOwnLine: 200, PointerAlignment: Left}",
						}
					end,
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
