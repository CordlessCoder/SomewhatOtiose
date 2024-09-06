return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()
		end,
		lazy = true,
		keys = {
			{
				"<leader>ha",
				function()
					require("harpoon"):list():add()
				end,
			},
			{
				"<leader>hc",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
			},
			{
				"<leader>hn",
				function()
					require("harpoon"):list():select(1)
				end,
			},
			{
				"<leader>he",
				function()
					require("harpoon"):list():select(2)
				end,
			},
			{
				"<leader>hi",
				function()
					require("harpoon"):list():select(3)
				end,
			},
			{
				"<leader>ho",
				function()
					require("harpoon"):list():select(4)
				end,
			},
			{
				-- Toggle previous & next buffers stored within require("harpoon") list
				"<C-P>",
				function()
					require("harpoon"):list():prev()
				end,
			},
			{
				"<C-L>",
				function()
					require("harpoon"):list():next()
				end,
			},
		},
	},
	{ "ThePrimeagen/vim-be-good", lazy = true, cmd = { "VimBeGood" } },
}
