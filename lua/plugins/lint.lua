return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			-- markdown = { "vale" },
			bash = { "shellcheck" },
			sh = { "shellcheck" },
			fish = { "fish" },
			python = { "ruff", "mypy" },
			go = { "golangcilint" },
			c = { "clangtidy" },
			cpp = { "clangtidy" },
		}
	end,
	init = function()
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()
			end,
		})
	end,
	lazy = true,
	ft = { "go", "python", "c", "c++", "fish", "bash" },
}
