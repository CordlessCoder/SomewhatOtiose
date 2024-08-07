local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {

	b.formatting.trim_whitespace,
	b.formatting.prettier,
	b.diagnostics.actionlint,
	b.formatting.tidy,
	b.formatting.pg_format,

	-- Markdown
	b.formatting.mdformat,

	-- Lua
	b.formatting.stylua,
	-- b.diagnostics.luacheck.with { extra_args = { "--new-globals", "vim", "--cache" } },

	-- Shells
	b.formatting.shfmt,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
	b.diagnostics.fish,
	b.formatting.fish_indent,

	-- Python
	b.formatting.black.with({ extra_args = { "--line-length", "129" } }),
	-- b.diagnostics.flake8.with { extra_args = { "--max-line-length", "129" } },
	b.diagnostics.mypy,

	-- Rust
	b.formatting.rustfmt.with({ extra_args = { "--edition=2021" } }),

	-- Kotlin
	b.formatting.ktlint,
	b.diagnostics.ktlint,

	-- C/C++/C#/Java/Cuda
	b.formatting.clang_format.with({
		extra_args = {
			"-style={BasedOnStyle: LLVM, IndentWidth: 4, ColumnLimit: 120, AlignConsecutiveAssignments: Consecutive, AlignConsecutiveDeclarations: Consecutive, AlignConsecutiveMacros: Consecutive, AlignEscapedNewlines: Left, AlignOperands: AlignAfterOperator}",
		},
	}),

	-- Go
	-- b.formatting.goimports_reviser,
	b.formatting.gofmt,
    b.diagnostics.golangci_lint,

	-- PHP :disgust:
	b.formatting.phpcbf,
	b.diagnostics.phpcs,
}

local M = {}

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
M.setup = function()
	null_ls.setup({
		debug = true,
		sources = sources,

		-- format on save
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							-- apply whatever logic you want (in this example, we'll only use null-ls)
							client.name == "null-ls",
							bufnr = bufnr,
						})
					end,
				})
			end
		end,
	})
	vim.keymap.set("n", "<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, { noremap = true, silent = true })
end

return M
