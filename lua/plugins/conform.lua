local formatters_by_ft = {
	lua = { "stylua" },
	rust = { "rustfmt" },
	python = { "ruff_format" },
	go = { "gofmt", "goimports-reviser" },
	markdown = { "mdsf" },
	javascript = { "prettier" },
	typescript = { "prettier" },
	svelte = { "prettier" },
	bash = { "shfmt" },
	c = { "clang_format" },
	cpp = { "clang_format" },
	html = { "prettier" },
	css = { "prettier" },
	-- sql = { "pg_format" },
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
					prepend_args = function(_, ctx)
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
			format_on_save = function(bufnr)
				if not vim.g.autoformat then
					return
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
		})
	end,
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format()
			end,
			desc = "Format buffer",
		},
	},
	event = "BufWritePre",
	lazy = true,
	cmd = { "ConformInfo" },
}
