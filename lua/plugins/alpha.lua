return {
	"goolord/alpha-nvim",
	lazy = vim.fn.argc(-1) ~= 0, -- don't load if opening a file from cmdline
	cmd = { "Alpha" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local ASCII_hl = "Normal"
		local SHORTCUT_hl = "CursorLineNr"
		local TEXT_hl = "Function"

		local function button(sc, txt, keybind)
			local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

			local opts = {
				position = "center",
				text = txt,
				shortcut = sc,
				cursor = 5,
				width = 36,
				align_shortcut = "right",
				hl = TEXT_hl,
			}

			if keybind then
				opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
				opts.hl_shortcut = SHORTCUT_hl
			end

			return {
				type = "button",
				val = txt,
				on_press = function()
					local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
					vim.api.nvim_feedkeys(key, "normal", false)
				end,
				opts = opts,
			}
		end

		local options = {}

		local ascii = {
			"   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
			"    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
			"          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
			"           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
			"          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
			"   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
			"  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
			" ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
			" ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
			"      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
			"       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
		}

		options.header = {
			type = "text",
			val = ascii,
			opts = {
				position = "center",
				hl = ASCII_hl,
			},
		}

		options.buttons = {
			type = "group",
			val = {
				button("f", "  Find File    ", ":Telescope find_files<CR>"),
				button("r", "󰷈  Recent File  ", ":Telescope oldfiles<CR>"),
				button("w", "󱀽  Word Sniper  ", ":Telescope live_grep<CR>"),
				button("m", "  Marks    ", ":Telescope marks<CR>"),
				button("t", "  Terminal     ", ":term <CR> i"),
				button("h", "  Rust Shell   ", "<cmd>:term irust <CR> :tabonly <CR> i"),
				-- button("SPC t h", "  Themes       ", ":Telescope themes<CR>"),
				button("s", "  Settings     ", ":e ~/.config/nvim/init.lua|:cd %:p:h <CR>"),
				button("u", "󰚰  Update Plugins", function()
					require("lazy").update()
				end),
				button("q", "󰅚  Exit         ", ":qa!<CR>"),
			},
			opts = {
				spacing = 1,
			},
		}

		-- dynamic header padding
		local fn = vim.fn
		local marginTopPercent = 0.1
		local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

		require("alpha").setup({
			layout = {
				{ type = "padding", val = headerPadding },
				options.header,
				{ type = "padding", val = 1 },
				options.buttons,
			},
			opts = {},
		})
	end,
}
