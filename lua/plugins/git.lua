return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
		lazy = true,
		cmd = { "Neogit" },
		keys = {
			{
				"<leader>og",
				function()
					require("neogit").open({ kind = "vsplit" })
				end,
				desc = "Open NeoGit",
			},
		},
	},
	{
		"f-person/git-blame.nvim",
		lazy = true,
		opts = { enabled = "<leader>gb", desc = "Toggle git blame display" },
		config = function()
			vim.keymap.set("n", "<leader>gb", function()
				require("gitblame").toggle()

				local present, galaxyline = pcall(require, "galaxyline")
				if present then
					galaxyline.load_galaxyline()
				end
			end)

			vim.g.gitblame_display_virtual_text = 0
			vim.g.gitblame_enabled = false
			require("gitblame").setup({
				delay = 0,
			})
		end,
		cmd = {
			"GitBlameToggle",
			"GitBlameEnable",
			"GitBlameDisable",
			"GitBlameCopySHA",
			"GitBlameCopyCommitURL",
			"GitBlameOpenFileURL",
			"GitBlameCopyFileURL",
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
}
