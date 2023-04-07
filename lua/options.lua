local opt = vim.opt
local g = vim.g

-- opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- -- Colorscheme
-- vim.cmd.colorscheme("habamax")
--
-- g.terminal_color_0 = "#1c1c1c"
-- g.terminal_color_1 = "#d75f5f"
-- g.terminal_color_2 = "#87af87"
-- g.terminal_color_3 = "#afaf87"
-- g.terminal_color_4 = "#5f87af"
-- g.terminal_color_5 = "#af87af"
-- g.terminal_color_6 = "#5f8787"
-- g.terminal_color_7 = "#9e9e9e"
-- g.terminal_color_8 = "#767676"
-- g.terminal_color_9 = "#d7875f"
-- g.terminal_color_10 = "#afd7af"
-- g.terminal_color_11 = "#d7d787"
-- g.terminal_color_12 = "#87afd7"
-- g.terminal_color_13 = "#d7afd7"
-- g.terminal_color_14 = "#87afaf"
-- g.terminal_color_15 = "#bcbcbc"

-- Indenting
opt.expandtab = true
opt.smartindent = true

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

local default_providers = {
	"node",
	"perl",
	"python3",
	"ruby",
}

for _, provider in ipairs(default_providers) do
	g["loaded_" .. provider .. "_provider"] = 0
end
