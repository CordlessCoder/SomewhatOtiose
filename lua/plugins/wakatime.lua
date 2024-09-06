return {
	"wakatime/vim-wakatime",
	lazy = true,
	event = "VeryLazy",
	cond = function()
		local f = io.open((os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") or "/root") .. "/.wakatime.cfg", "r")
		return f and (io.close(f))
	end,
}
