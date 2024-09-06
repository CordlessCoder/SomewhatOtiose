return {
	{
		"willothy/nvim-cokeline",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for v0.4.0+
			"nvim-tree/nvim-web-devicons", -- If you want devicons
			"stevearc/resession.nvim", -- Optional, for persistent history
			{
				"tiagovla/scope.nvim",
				lazy = true,
				opts = {},
			},
		},
		init = function()
			-- set an empty tabline until cokeline loads
			vim.o.tabline = " "
		end,
		config = function()
			local get_hex = require("cokeline.hlgroups").get_hl_attr
			local is_picking_focus = require("cokeline.mappings").is_picking_focus
			local is_picking_close = require("cokeline.mappings").is_picking_close
			-- local getdiagnostics = require("config.utils.getdiagnostics")

			require("cokeline").setup({
				sidebar = {
					filetype = { "NvimTree", "neo-tree", "undotree" },
					components = {
						{
							text = function(buf)
								return buf.filetype
							end,
							bg = function()
								return get_hex("NvimTreeNormal", "bg")
							end,
							bold = true,
						},
					},
				},

				default_hl = {
					fg = function(buffer)
						return (not (is_picking_focus() or is_picking_close()) and buffer.is_focused)
								and get_hex("ColorColumn", "bg")
							or get_hex("Normal", "fg")
					end,
					bg = function(buffer)
						return (not (is_picking_focus() or is_picking_close()) and buffer.is_focused)
								and get_hex("Normal", "fg")
							or get_hex("ColorColumn", "bg")
					end,
				},

				components = {
					{ text = " " },
					{
						text = function(buffer)
							return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. " "
								or buffer.devicon.icon
						end,
						fg = function(buffer)
							return (is_picking_focus() and vim.g.terminal_color_3)
								or (is_picking_close() and vim.g.terminal_color_1)
								or buffer.devicon.color
						end,
						italic = function()
							return (is_picking_focus() or is_picking_close())
						end,
						bold = function()
							return (is_picking_focus() or is_picking_close())
						end,
					},
					{
						text = function(buffer)
							return buffer.unique_prefix
						end,
						fg = get_hex("Comment", "fg"),
						italic = true,
					},
					{
						text = function(buffer)
							return buffer.filename .. " "
						end,
						underline = function(buffer)
							return buffer.is_hovered and not buffer.is_focused
						end,
						-- fg = function(buffer)
						-- 	local total = getdiagnostics(buffer.number, { min = "INFO", max = "ERROR" })
						-- 	if total == 0 then
						-- 		return buffer.is_focused and get_hex("ColorColumn", "bg") or get_hex("Normal", "fg")
						-- 	end
						-- 	if getdiagnostics(buffer.number, "ERROR") > 0 then
						-- 		return "ErrorMsg"
						-- 	end
						-- 	if getdiagnostics(buffer.number, "WARN") > 0 then
						-- 		return "WarningMsg"
						-- 	end
						-- 	return "Character"
						-- end,
					},
					{
						text = function(buffer)
							local harpoon = require("harpoon")
							for idx, value in ipairs(harpoon:list():display()) do
								if buffer.path:match(value:format("%s$")) then
									return idx .. " "
								end
							end
							return ""
						end,
						fg = "Directory",
					},
					{
						text = "",
						on_click = function(_, _, _, _, buffer)
							buffer:delete()
						end,
						fg = function(buffer)
							if buffer.is_modified then
								return "WarningMsg"
							end
							return nil
						end,
					},
					{
						text = " ",
					},
				},
			})
		end,
		lazy = vim.fn.argc(-1) == 0, -- lazy load only if we're looking at alpha-nvim on startup
		event = "VeryLazy",
	},
}
