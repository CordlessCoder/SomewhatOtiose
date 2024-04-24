local isloaded = require("config.utils.isloaded")
local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = { "LuaTree", "vista", "dbui", "NvimTree" }
local g = vim.g

local gethl = function(name)
	local present, highlight = pcall(vim.api.nvim_get_hl, 0, { name = name })
	-- require("notify").notify(string.format("%s: %s", name, vim.inspect(highlight)))
	if present then
		return highlight
	else
		return nil
	end
end

local tohex = function(color)
	return string.format("#%x", color)
end

-- Extracting highlight colors from the current colorscheme
local decay_present, decay = pcall(require, "decay.core")
local tokyo_present, tokyo = pcall(require, "tokyonight.colors")
local colors
if decay_present then
	-- For the decay colorscheme
	decay = decay.get_colors(vim.g.decay_style)
	-- { ["lavender"] = #a9acdb,["comments"] = #343750,["sky"] = #a2dee9,["@overrides"] = function: 0x7f2386794b10,["cursorline"] = #2c2f44,["black"] = #2c2f44,["teal"] = #8dccb7,["blue"] = #8CACEF,["red"] = #CA7E9E,["green"] = #8FC8A8,["brightwhite"] = #DDDFE4,["foreground"] = #A5B7D5,["pink"] = #f9c9cb,["brightred"] = #E3879C,["orange"] = #FFC19F,["lighter"] = #242637,["cursor"] = #A5B7D5,["brightgreen"] = #A1D4BB,["accent"] = #a9acdb,["statusline_bg"] = #1b1d2a,["yellow"] = #EFD9B0,["contrast"] = #101119,["magenta"] = #C7A5E5,["brightcyan"] = #A3D2E7,["brightblack"] = #3b3f5b,["background"] = #12131c,["white"] = #C1C4CB,["brightmagenta"] = #CC9EEF,["brightblue"] = #94B4EF,["brightyellow"] = #F6E4B6,["cyan"] = #91CEDF,}

	-- { ["color5"] = #C7A5E5,["black"] = #2c2f44,["color7"] = #2c2f44,["color8"] = #a9acdb,["color6"] = #a2dee9,["fg"] = #A5B7D5,["bg"] = #1b1d2a,["gray"] = #3b3f5b,["lgray"] = #343750,["color1"] = #CA7E9E,["color2"] = #8FC8A8,["color3"] = #FFC19F,["color4"] = #8CACEF,}

	colors = {
		bg = decay.background,
		inverted_fg = decay.background,
		fg = decay.foreground,
		black = decay.black,
		gray = decay.brightblack,
		lgray = decay.white,
		color1 = decay.red,
		color2 = decay.green,
		color3 = decay.orange,
		color4 = decay.blue,
		color5 = decay.magenta,
		color6 = decay.sky,
		color7 = decay.cursorline,
		color8 = decay.lavender,
	}
	-- require("notify")(dump(colors))
elseif tokyo_present then
	tokyo = tokyo.setup()
	-- { ["none"] = NONE,["green"] = #78dba9,["bg"] = #12131c,["gitSigns"] = { ["add"] = #266d6a,["delete"] = #b2555b,["change"] = #536c9e,} ,["cyan"] = #7dcfff,["magenta"] = #bb9af7,["blue"] = #7aa2f7,["git"] = { ["add"] = #449dab,["change"] = #6183bb,["delete"] = #914c54,["ignore"] = #545c7e,} ,["bg_statusline"] = #16161e,["bg_highlight"] = #292e42,["green2"] = #41a6b5,["info"] = #0db9d7,["purple"] = #9d7cd8,["blue6"] = #b4f9f8,["magenta2"] = #ff007c,["bg_search"] = #3d59a1,["terminal_black"] = #414868,["bg_visual"] = #283457,["black"] = #15161e,["bg_popup"] = #16161e,["border_highlight"] = #27a1b9,["bg_float"] = #16161e,["blue0"] = #3d59a1,["hint"] = #1abc9c,["warning"] = #e0af68,["error"] = #db4b4b,["teal"] = #73C0C9,["red1"] = #db4b4b,["orange"] = #ff9e64,["bg_sidebar"] = #16161e,["border"] = #15161e,["diff"] = { ["add"] = #20303b,["change"] = #1f2231,["delete"] = #37222c,["text"] = #394b70,} ,["comment"] = #565f89,["fg_float"] = #c0caf5,["yellow"] = #e0af68,["fg_sidebar"] = #a9b1d6,["blue7"] = #394b70,["bg_dark"] = #16161e,["red"] = #f7768e,["dark3"] = #545c7e,["fg_dark"] = #a9b1d6,["dark5"] = #737aa2,["fg"] = #c0caf5,["blue1"] = #2ac3de,["blue5"] = #89ddff,["fg_gutter"] = #242637,["blue2"] = #0db9d7,["green1"] = #94f7c5,}
	colors = {
		bg = tokyo.bg,
		inverted_fg = (tokyo.bg == "NONE" and tokyo.black) or tokyo.bg,
		fg = tokyo.fg,
		black = tokyo.black,
		gray = tokyo.bg_highlight,
		lgray = tokyo.fg_dark,
		color1 = tokyo.red,
		color2 = tokyo.green,
		color3 = tokyo.orange,
		color4 = tokyo.blue,
		color5 = tokyo.magenta,
		color6 = tokyo.info,
		color7 = tokyo.comment,
		color8 = tokyo.dark5,
	}
else
	local hl = gethl("Normal") or {}
	local fgcolor = tohex(hl.fg or 0xffffff)
	local bgcolor
	hl = gethl("CursorColumn") or {}
	local gray = tohex(hl.bg or 0x666666)
	hl = gethl("NonText") or {}
	local lgray = tohex(hl.fg or 0x888888)
	hl = gethl("Directory") or {}
	local blue = tohex(hl.fg or 0x2222ff)
	hl = gethl("String") or {}
	local green = tohex(hl.fg or 0x22ff22)
	hl = gethl("ErrorMsg") or {}
	local red
	if hl.fg ~= nil then
		red = tohex(hl.fg)
	elseif hl.bg then
		red = tohex(hl.bg)
	else
		red = gethl("Error").bg or gethl("DiffDelete").bg
	end
	red = red or 0xFF2222
	hl = gethl("Statement") or {}
	local purple = tohex(hl.fg)
	hl = gethl("Constant") or {}
	local orange = tohex(hl.fg)
	hl = gethl("Special") or {}
	local cyan = tohex(hl.fg)

	local color7 = tohex(gethl("LspReferenceText").bg or gethl("Question").fg)
	hl = gethl("Comment") or {}
	local color8 = tohex(hl.fg)
	local inverted_fg
	if hl.bg ~= nil then
		bgcolor = tohex(hl.bg) or {}
		inverted_fg = bgcolor
	else
		bgcolor = "NONE"
		inverted_fg = g.terminal_color_0 or tohex(tonumber(string.sub(gray, 2), 16) / 2)
	end

	colors = {
		bg = bgcolor,
		fg = fgcolor,
		inverted_fg = inverted_fg,
		black = g.terminal_color_0 or bgcolor,
		gray = gray,
		lgray = lgray,
		color1 = red,
		color2 = green,
		color3 = orange,
		color4 = blue,
		color5 = purple,
		color6 = cyan,
		color7 = color7,
		color8 = color8,
	}
end

local buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

local bg_buffer = function()
	if buffer_not_empty() then
		return colors.bg
	end
	return colors.lgray
end

gls.left[#gls.left + 1] = {
	FirstElement = {
		provider = function()
			return "🮈"
		end,
		highlight = { colors.color4, colors.bg },
	},
}
gls.left[#gls.left + 1] = {
	ViMode = {
		provider = function()
			local alias =
				{ n = "NORMAL", i = "INSERT", c = "COMMAND", v = "VISUAL", V = "VISUAL LINE", [""] = "VISUAL BLOCK" }
			return alias[vim.fn.mode()]
		end,
		separator = "",
		separator_highlight = {
			colors.color4,
			function()
				if buffer_not_empty() then
					return colors.bg
				end
				return colors.color4
			end,
		},
		highlight = { colors.inverted_fg, colors.color4, "bold" },
	},
}
gls.left[#gls.left + 1] = {
	FileIcon = {
		provider = "FileTypeName",
		condition = buffer_not_empty,
		highlight = { colors.purple, bg_buffer },
		separator = "|",
		separator_highlight = { colors.color4, colors.bg },
		-- separator = "▋",
		-- separator_highlight = {
		-- 	bg_buffer,
		-- 	colors.bg,
		-- },
	},
}

gls.left[#gls.left + 1] = {
	FileName = {
		provider = { "FileName", "FileSize" },
		condition = buffer_not_empty,
		separator = "▍",
		separator_highlight = { colors.bg, colors.lgray },

		highlight = { colors.fg, colors.bg },
	},
}

gls.left[#gls.left + 1] = {
	GitIcon = {
		provider = function()
			return "󰊢 "
		end,
		condition = buffer_not_empty,
		highlight = { colors.fg, colors.lgray },
		separator = "",
		separator_highlight = {
			colors.lgray,
			colors.fg,
		},
	},
}

gls.left[#gls.left + 1] = {
	GitBranch = {
		provider = "GitBranch",
		condition = buffer_not_empty, -- TODO: Hide when not in repo
		highlight = { colors.inverted_fg, colors.fg },
	},
}

local checkwidth = function()
	local squeeze_width = vim.fn.winwidth(0) / 2
	return squeeze_width > 40 and buffer_not_empty()
end

local curbg = colors.bg
gls.left[#gls.left + 1] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = checkwidth,
		icon = " ",
		highlight = { colors.color4, curbg },
	},
}
gls.left[#gls.left + 1] = {
	DiffModified = {
		provider = "DiffModified",
		condition = checkwidth,
		icon = " ",
		highlight = { colors.color2, curbg },
	},
}
gls.left[#gls.left + 1] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = checkwidth,
		icon = " ",
		highlight = { colors.color1, curbg },
	},
}
gls.left[#gls.left + 1] = {
	LeftEnd = {
		condition = buffer_not_empty,
		provider = function()
			return "▋"
		end,
		-- separator = "▋",
		-- separator_highlight = { colors.fg, colors.bg },
		highlight = { colors.fg, colors.bg },
	},
}
gls.left[#gls.left + 1] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { colors.color1, colors.bg },
	},
}
gls.left[#gls.left + 1] = {
	Space = {
		provider = function()
			return " "
		end,
	},
}
gls.left[#gls.left + 1] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { colors.color2, colors.bg },
	},
}
local git_blame = function()
	if isloaded("git-blame.nvim") then
		return require("gitblame")
	end
	return {
		is_blame_text_available = function()
			return false
		end,
	}
end
-- gls.mid[#gls.mid + 1] = {
-- 	BufList = {
-- 		provider = function()
-- 			local bufs = vim.api.nvim_list_bufs()
-- 			local line = table.concat(bufs, " ")
-- 			return line
-- 		end,
-- 		-- condition = function()
-- 		-- 	return git_blame().is_blame_text_available()
-- 		-- end,
-- 	},
-- }
gls.right[#gls.right + 1] = {
	GitBlame = {
		provider = function()
			local present

			return git_blame().get_current_blame_text()
		end,
		condition = function()
			return git_blame().is_blame_text_available()
		end,
	},
}
gls.right[#gls.right + 1] = {
	FileFormat = {
		provider = "FileFormat",
		-- separator = "▋",
		-- separator_highlight = {
		-- 	colors.bg,
		-- 	colors.gray,
		-- },
		highlight = { colors.purple, colors.bg, "bold" },
	},
}
gls.right[#gls.right + 1] = {
	LineInfo = {
		provider = "LineColumn",
		separator = " | ",
		separator_highlight = { colors.color6, colors.bg },
		highlight = { colors.grey, colors.bg },
	},
}
gls.right[#gls.right + 1] = {
	PerCent = {
		provider = "LinePercent",
		separator = "",
		separator_highlight = { colors.color4, colors.bg },
		highlight = { colors.inverted_fg, colors.color4, "bold" },
	},
}
gls.right[#gls.right + 1] = {
	ScrollBar = {
		provider = "ScrollBar",
		highlight = { colors.color4, colors.bg },
	},
}

-- gls.short_line_left[1] = {
-- 	FirstElement = {
-- 		provider = function()
-- 			return "▋"
-- 		end,
-- 		highlight = { colors.black, colors.color4 },
-- 	},
-- }
-- gls.short_line_left[2] = {
-- 	BufferType = {
-- 		provider = "FileTypeName",
-- 		separator = "▋",
--
-- 		separator_highlight = {
-- 			colors.color4,
-- 			colors.bg,
-- 		},
-- 		highlight = { colors.fg, colors.color4, "bold" },
-- 	},
-- }
--
-- gls.short_line_right[1] = {
-- 	BufferIcon = {
-- 		provider = "BufferIcon",
-- 		separator = "▋",
-- 		separator_highlight = { colors.bg, colors.bg },
-- 		highlight = { colors.inverted_fg, colors.bg },
-- 	},
-- }
gls.short_line_left[1] = {
	FirstElement = {
		provider = function()
			return "🮈"
		end,
		highlight = { colors.color4, colors.bg },
	},
}
gls.short_line_left[2] = {
	ViModeShort = {
		provider = function()
			local alias = { n = "N", i = "I", c = "C", v = "V", V = "VL", [""] = "VB" }
			return alias[vim.fn.mode()]
		end,
		highlight = { colors.inverted_fg, colors.color4, "bold" },

		separator = "",
		separator_highlight = {
			colors.color4,
			colors.bg,
		},
	},
}

gls.short_line_left[4] = {
	FileName = {
		provider = { "FileName", "FileSize" },
		condition = buffer_not_empty,
		-- separator = "▍",
		-- separator_highlight = { colors.bg, colors.lgray },

		highlight = { colors.fg, colors.bg },
	},
}

gls.short_line_left[5] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = checkwidth,
		icon = " ",
		highlight = { colors.color4, curbg },
	},
}
gls.short_line_left[6] = {
	DiffModified = {
		provider = "DiffModified",
		condition = checkwidth,
		icon = " ",
		highlight = { colors.color2, curbg },
	},
}
gls.short_line_left[7] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = checkwidth,
		icon = " ",
		highlight = { colors.color1, curbg },
	},
}
gls.short_line_left[9] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { colors.color1, colors.bg },
	},
}
gls.short_line_left[10] = {
	Space = {
		provider = function()
			return " "
		end,
	},
}
gls.short_line_left[11] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { colors.color2, colors.bg },
	},
}
gls.short_line_right[1] = {
	LineInfo = {
		provider = "LineColumn",
		separator = " | ",
		separator_highlight = { colors.color6, colors.bg },
		highlight = { colors.grey, colors.bg },
	},
}
