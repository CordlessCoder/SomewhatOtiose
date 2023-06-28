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

local tab_widths = {
	haskell = 2,
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "kdl",
	callback = function(ev)
		vim.opt_local.commentstring = "//%s"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(ev)
		vim.cmd.LspStart()
		local present, _ = pcall(require, "colorizer")
		if present then
			vim.cmd.ColorizerAttachToBuffer()
		end
		vim.bo.tabstop = 4
		vim.bo.softtabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = true

		for ft, w in pairs(tab_widths) do
			if ft == ev.match then
				vim.bo.tabstop = w
				vim.bo.softtabstop = w
				vim.bo.shiftwidth = w
			end
		end
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "Makefile",
	callback = function()
		vim.bo.expandtab = false
	end,
})
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
