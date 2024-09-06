local opt = vim.opt
local g = vim.g

-- opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

vim.o.spell = false
vim.o.spelllang = "en_us,en_gb,en_ca"

local tab_widths = {
	haskell = 2,
	html = 2,
	css = 2,
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(ev)
		vim.bo.expandtab = true

		local w = tab_widths[ev.match] or 4
		vim.bo.tabstop = w
		vim.bo.softtabstop = w
		vim.bo.shiftwidth = w
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
