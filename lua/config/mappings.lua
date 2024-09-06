local lazy_load = require("config.utils.lazy_load")

local notify = lazy_load("notify", function()
	return vim.print
end)

local mappings = {
	i = {
		["<C-h>"] = { "<left>", "Move with HJKL in insert mode" },
		["<C-j>"] = { "<down>", "Move with HJKL in insert mode" },
		["<C-k>"] = { "<up>", "Move with HJKL in insert mode" },
		["<C-l>"] = { "<right>", "Move with HJKL in insert mode" },
	},

	v = {
		["<leader>p"] = { '"-dP', "paste without replacing buffer" },
		["<Tab>"] = { ">", "󰉶   Indent selected lines" },
		["<S-Tab>"] = { "<", "󰉵   Unindent selected lines" },
		["<leader>ca"] = {
			function()
				local success = pcall(vim.lsp.buf.range_code_action)
				if not success then
					notify()("No code action available")
				end
			end,
			"Perform code action on selection",
		},
	},
	n = {
		["<leader>cb"] = {
			function()
				vim.api.nvim_buf_delete(0, {
					force = false,
					unload = false,
				})
			end,
			"Close current buffer",
		},
		["<leader>h"] = {
			function()
				if vim.version().minor < 10 then
					require("lsp-inlayhints").toggle()
					return
				end
				local hint = vim.lsp.inlay_hint
				local enabled = hint.is_enabled({ bufnr = 0 })

				local success, _ = pcall(vim.lsp.inlay_hint.enable, not enabled, {})
				if not success then
					vim.lsp.inlay_hint.enable(0, not enabled)
				end
			end,
			"Toggle inlayhints",
		},
		["<leader>``"] = {
			function()
				local function map(mode, lhs, rhs, opts)
					local options = { noremap = true, silent = true }
					if opts then
						options = vim.tbl_extend("force", options, opts)
					end
					vim.api.nvim_set_keymap(mode, lhs, rhs, options)
					vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
				end

				if vim.g.colemak then
					vim.g.colemak = false
					map("", "m", "m", {})
					map("", "h", "h", {})
					map("", "n", "n", {})
					map("", "e", "e", {})
					map("", "i", "i", {})
					map("", "j", "j", {})
					map("", "l", "l", {})
					map("", "k", "k", {})
					map("", "K", "K", {})
					-- map("i", "<C-h>", "<left>", { noremap = false })
					-- map("i", "<C-j>", "<down>", { noremap = false })
					-- map("i", "<C-k>", "<up>", { noremap = false })
					-- map("i", "<C-l>", "<right>", { noremap = false })
				else
					vim.g.colemak = true
					map("", "m", "h", {})
					map("", "h", "m", {})
					map("", "n", "j", {})
					map("", "j", "e", {})
					map("", "e", "k", {})
					map("", "i", "l", {})
					map("", "l", "i", {})
					map("", "k", "n", {})
					map("", "K", "N", {})
					-- map("i", "<C-m>", "<left>", { noremap = false })
					-- map("i", "<C-n>", "<down>", { noremap = false })
					-- map("i", "<C-e>", "<up>", { noremap = false })
					-- map("i", "<C-i>", "<right>", { noremap = false })
				end
				notify()(string.format("Colemak binds: %s", vim.g.colemak))
			end,
			"Toggle Colemak-DH bindings",
		},
		["<leader>st"] = {
			function()
				vim.o.spell = not vim.o.spell
				print("spell: " .. tostring(vim.o.spell))
			end,
			"Toggle vim spell",
		},
		["cr"] = {
			function()
				vim.lsp.buf.rename()
			end,
			"LSP rename",
		},
		["<Tab>"] = {
			function()
				local present, cokeline = pcall(require, "cokeline.mappings")
				if present then
					cokeline.by_step("focus", 1)
				else
					vim.cmd.bnext()
				end
			end,
			"󰉶   Next Buffer",
		},
		["<S-Tab>"] = {
			function()
				local present, cokeline = pcall(require, "cokeline.mappings")
				if present then
					cokeline.by_step("focus", -1)
				else
					vim.cmd.bnext()
				end
			end,
			"󰉵   Prev Buffer",
		},
		["<C-t>"] = {
			function()
				vim.cmd.tabnext()
			end,
			"󰉶   Next tab",
		},
		["<C-T>"] = {
			function()
				vim.cmd.tabprevious()
			end,
			"󰉵   Prev tab",
		},
		["<c-space>"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"Hover docs",
		},
		["<leader>p"] = { '"-dP', "paste without replacing buffer" },
		["<C-space>"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"Hover action",
		},
		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"Hover action",
		},
		["<leader>ca"] = { vim.lsp.buf.code_action, "Perform code action" },
		["<C-s>"] = { "<cmd> w <CR>", "󰆓   Save file" },
		["<C-S>"] = { "<cmd> wa <CR>", "󰆔   Save all files" },
		-- ["<C-t>"] = { "<cmd> tabedit <CR>", "New tab" },
		["<A-n>"] = { "<cmd> tabn <CR>", "next tab" },
		["<C-left>"] = { "<C-w>h", "Focus window to the left" },
		["<C-h>"] = { "<C-w>h", "Focus window to the left" },
		["<C-down>"] = { "<C-w>j", "Focus window downwards" },
		["<C-j>"] = { "<C-w>j", "Focus window downwards" },
		["<C-up>"] = { "<C-w>k", "Focus window upwards" },
		["<C-k>"] = { "<C-w>k", "Focus window upwards" },
		["<C-right>"] = { "<C-w>l", "Focus window to the right" },
		["<C-l>"] = { "<C-w>l", "Focus window to the right" },
		["<C-->"] = {
			function()
				local cur_font = vim.opt.guifont.get()[1]
				local fontsize = 14
				local t = {}
				for size in string.gmatch(cur_font, "([^" .. ":" .. "]+)") do
					fontsize = tonumber(string.sub(size, 2))
					table.insert(t, size)
				end
				fontsize = fontsize - 1
				vim.opt.guifont = t[1] .. ":h" .. fontsize
			end,
			"Decrease font size",
		},
		["<C-+>"] = {
			function()
				local cur_font = vim.opt.guifont:get()[1]
				local fontsize = 15
				local t = {}
				for size in string.gmatch(cur_font, "([^" .. ":" .. "]+)") do
					fontsize = tonumber(string.sub(size, 2))
					table.insert(t, size)
				end
				fontsize = fontsize + 1
				vim.opt.guifont = t[1] .. ":h" .. fontsize
			end,
			"Increase font size",
		},
		["<C-=>"] = {
			function()
				local cur_font = vim.opt.guifont:get()[1]
				local fontsize = 15
				local t = {}
				for size in string.gmatch(cur_font, "([^" .. ":" .. "]+)") do
					fontsize = tonumber(string.sub(size, 2))
					table.insert(t, size)
				end
				fontsize = fontsize + 1
				vim.opt.guifont = t[1] .. ":h" .. fontsize
			end,
			"Increase font size",
		},
		["<C-0>"] = {
			function()
				local cur_font = vim.opt.guifont:get()[1]
				local t = {}
				for size in string.gmatch(cur_font, "([^" .. ":" .. "]+)") do
					table.insert(t, size)
				end
				vim.opt.guifont = t[1] .. ":h" .. 15
			end,
			"Reset font size (to 15)",
		},
	},
	[""] = {
		["gh"] = {
			"0",
			"Go to line start",
		},
		["ge"] = {
			"$",
			"Go to line end",
		},
	},
}

local apply_map = require("config.utils.apply_map")
apply_map(mappings)
