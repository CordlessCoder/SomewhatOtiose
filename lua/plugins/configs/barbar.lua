-- Set barbar's options
require("bufferline").setup({
	-- Enable/disable animations
	animation = true,

	-- Enable/disable current/total tabpages indicator (top right corner)
	tabpages = true,

	-- Enable/disable close button
	-- closable = true,

	clickable = true,

	-- Excludes buffers from the tabline
	-- exclude_ft = { "javascript" },
	-- exclude_name = { "package.json" },

	-- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
	-- hide = { extensions = false, inactive = true },

	-- Disable highlighting file icons in inactive buffers
	highlight_inactive_file_icons = true,

	-- Enable highlighting visible buffers
	highlight_visible = true,

	-- Enable/disable icons
	-- if set to 'numbers', will show buffer index in the tabline
	-- if set to 'both', will show buffer index and icons in the tabline
	-- icons = {},

	-- icon_separator_active = "▎",
	-- icon_separator_inactive = "▎",
	-- icon_close_tab = "",
	-- icon_close_tab_modified = "●",
	-- icon_pinned = "車",
	--
	-- New buffer letters are assigned in this order. This order is
	-- optimal for the qwerty keyboard layout but might need adjustement
	-- for other layouts.
	letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
})
