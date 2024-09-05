return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.tabline = ""
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			vim.o.laststatus = 3

			return {
				options = {
					theme = "auto",
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
				},
				-- sections = {
				-- 	lualine_a = { "mode" },
				-- 	lualine_b = { "branch" },
				--
				-- 	lualine_c = {
				-- 		LazyVim.lualine.root_dir(),
				-- 		{
				-- 			"diagnostics",
				-- 			symbols = {
				-- 				error = icons.diagnostics.Error,
				-- 				warn = icons.diagnostics.Warn,
				-- 				info = icons.diagnostics.Info,
				-- 				hint = icons.diagnostics.Hint,
				-- 			},
				-- 		},
				-- 		{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				-- 		{ LazyVim.lualine.pretty_path() },
				-- 	},
				-- 	lualine_x = {
				--         -- stylua: ignore
				--         {
				--           function() return require("noice").api.status.command.get() end,
				--           cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
				--           color = function() return LazyVim.ui.fg("Statement") end,
				--         },
				--         -- stylua: ignore
				--         {
				--           function() return require("noice").api.status.mode.get() end,
				--           cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
				--           color = function() return LazyVim.ui.fg("Constant") end,
				--         },
				--         -- stylua: ignore
				--         {
				--           function() return "  " .. require("dap").status() end,
				--           cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
				--           color = function() return LazyVim.ui.fg("Debug") end,
				--         },
				--         -- stylua: ignore
				--         {
				--           require("lazy.status").updates,
				--           cond = require("lazy.status").has_updates,
				--           color = function() return LazyVim.ui.fg("Special") end,
				--         },
				-- 		{
				-- 			"diff",
				-- 			symbols = {
				-- 				added = icons.git.added,
				-- 				modified = icons.git.modified,
				-- 				removed = icons.git.removed,
				-- 			},
				-- 			source = function()
				-- 				local gitsigns = vim.b.gitsigns_status_dict
				-- 				if gitsigns then
				-- 					return {
				-- 						added = gitsigns.added,
				-- 						modified = gitsigns.changed,
				-- 						removed = gitsigns.removed,
				-- 					}
				-- 				end
				-- 			end,
				-- 		},
				-- 	},
				-- 	lualine_y = {
				-- 		{ "progress", separator = " ", padding = { left = 1, right = 0 } },
				-- 		{ "location", padding = { left = 0, right = 1 } },
				-- 	},
				-- 	lualine_z = {
				-- 		function()
				-- 			return " " .. os.date("%R")
				-- 		end,
				-- 	},
				-- },
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},
}
