vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Check for multigrid
vim.g.multigrid = 0
local uis = vim.api.nvim_list_uis()
for _, ui in ipairs(uis) do
	if ui["ext_multigrid"] then
		vim.g.multigrid = 1
	end
end

require("options")
require("lazy").setup("plugins", {
	defaults = {
		lazy = true,
	},
	-- concurrency = 8, ---@type number limit the maximum amount of concurrent tasks
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = false,
		notify = false, -- get a notification when changes are found
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			-- reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
			---@type string[]
			paths = {
				-- "~/many_a_color",
			}, -- add any custom paths here that you want to includes in the rtp
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				"gzip",
				"tohtml",
				"zipPlugin",
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
})
require("config")
