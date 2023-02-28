local mappings = {
	i = {
		["<C-h>"] = { "<left>", "Move with HJKL in insert mode" },
		["<C-j>"] = { "<down>", "Move with HJKL in insert mode" },
		["<C-k>"] = { "<up>", "Move with HJKL in insert mode" },
		["<C-l>"] = { "<right>", "Move with HJKL in insert mode" },
	},

	v = {
		["<leader>p"] = { '"-dP', "paste without replacing buffer" },
		["<leader>e"] = {
			function()
				require("dapui").eval()
			end,
			"Evaluate selection",
		},
		["<Tab>"] = { ">", "   Indent selected lines" },
		["<S-Tab>"] = { "<", "   Unindent selected lines" },
		["<leader>ca"] = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Perform code action on selection" },
	},
	t = {
		["<A-x>"] = { "<Cmd>ToggleTerm direction=float<CR>", "Open floating terminal" },
		["<A-t>"] = { "<Cmd>ToggleTerm direction=vertical<CR>", "Open vertical terminal" },
		["<A-h>"] = { "<Cmd>ToggleTerm direction=horizontal<CR>", "Open horizontal terminal" },
	},
	n = {
		["<leader>e"] = { "<Cmd>NvimTreeFocus<CR>", "Focus NvimTree" },
		["<A-x>"] = { "<Cmd>ToggleTerm direction=float<CR>", "Open floating terminal" },
		["<A-t>"] = { "<Cmd>ToggleTerm direction=vertical<CR>", "Open vertical terminal" },
		["<A-h>"] = { "<Cmd>ToggleTerm direction=horizontal<CR>", "Open horizontal terminal" },
		["<A-b>"] = { "<Cmd>BufferPick<CR>", "Magic puffer-picking" },
		["<A-p>"] = { "<Cmd>BufferPin<CR>", "Pin/unpin buffer" },
		["<A-c>"] = { "<Cmd>BufferClose<CR>", "Close buffer" },
		["<leader>cbp"] = { "<Cmd>BufferCloseAllButPinned<CR>", "Close all buffers, only leaving the pinned" },
		["<leader>cbc"] = { "<Cmd>BufferCloseAllButCurrent<CR>", "Close all buffers, only leaving the current" },
		["<leader>cbl"] = { "<Cmd>BufferCloseBuffersLeft<CR>", "Close all buffers to the left" },
		["<leader>cbh"] = { "<Cmd>BufferCloseBuffersRight<CR>", "Close all buffers to the right" },
		["<A-1>"] = { "<Cmd>BufferGoto 1<CR>", "Go to the first buffer" },
		["<A-2>"] = { "<Cmd>BufferGoto 2<CR>", "Go to the second buffer" },
		["<A-3>"] = { "<Cmd>BufferGoto 3<CR>", "Go to the third buffer" },
		["<A-4>"] = { "<Cmd>BufferGoto 4<CR>", "Go to the fouth buffer" },
		["<A-5>"] = { "<Cmd>BufferGoto 5<CR>", "Go to the fifth buffer" },
		["<A-6>"] = { "<Cmd>BufferGoto 6<CR>", "Go to the sixth buffer" },
		["<A-7>"] = { "<Cmd>BufferGoto 7<CR>", "Go to the seventh buffer" },
		["<A-8>"] = { "<Cmd>BufferGoto 8<CR>", "Go to the eighth buffer" },
		["<A-9>"] = { "<Cmd>BufferGoto 9<CR>", "Go to the nineth buffer" },
		["<A-0>"] = { "<Cmd>BufferLast<CR>", "Go to last buffer" },
		["<A-,>"] = { "<Cmd>BufferMovePrevious<CR>", "Move buffer back" },
		["<A-.>"] = { "<Cmd>BufferMoveNext<CR>", "Move buffer back" },
		["<Tab>"] = { "<Cmd>BufferNext<CR>", "   Next Buffer" },
		["<S-Tab>"] = { "<Cmd>BufferPrevious<CR>", "   Prev Buffer" },
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
		["<leader>dc"] = {
			function()
				require("dap").continue()
			end,
			"DAP continue",
		},
		["<leader>db"] = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"DAP toggle breakpoint",
		},
		["<leader>do"] = {
			function()
				require("dap").step_over()
			end,
			"DAP step over",
		},
		["<leader>di"] = {
			function()
				require("dap").step_into()
			end,
			"DAP step in",
		},
		["<leader>dr"] = {
			function()
				require("dap").repl.open()
			end,
			"DAP step in",
		},
		["<leader>dt"] = {
			function()
				require("dapui").toggle()
			end,
			"DAP step in",
		},
		["<leader>gb"] = { "<cmd>GitBlameToggle<CR>", "Toggle git blame" },
		["<leader>a"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Perform code action" },
		["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Perform code action" },
		["<leader>n"] = { "<cmd>NvimTreeToggle <CR>", "   toggle nvimtree" },
		["<C-n>"] = { "<cmd>execute 'normal <Plug>(VM-Find-Under)' <CR>", "   toggle nvimtree" },
		["<leader>f"] = {
			function()
				vim.lsp.buf.format({ async = true })
			end,
			"   lsp formatting",
		},
		["<C-s>"] = { "<cmd> w <CR>", "   Save file" },
		["<C-S>"] = { "<cmd> wa <CR>", "   Save all files" },
		["<C-g>"] = { "<cmd> TZFocus <CR>", "Focus mode" },
		-- ["<C-t>"] = { "<cmd> tabedit <CR>", "New tab" },
		["<leader>tn"] = { "<cmd> tabn <CR>", "next tab" },
		["<leader>tf"] = { "<cmd> TZFocus <CR>", "Focus mode" },
		["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "Focus mode, ataraxis" },
		["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "Focus mode, minimal" },
		["<leader>cc"] = { "<cmd> ColorizerToggle <CR>", "   Toggle colorizer" },
		["<C-h>"] = { "<C-w>h", "Focus window to the left" },
		["<C-j>"] = { "<C-w>j", "Focus window downwards" },
		["<C-k>"] = { "<C-w>k", "Focus window upwards" },
		["<C-l>"] = { "<C-w>l", "Focus window to the right" },
		["<C-->"] = {
			function()
				local cur_font = vim.opt.guifont:get()[1]
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
			"Reset font size (to 14)",
		},
		["gz"] = {
			"<cmd> UrlView <CR>",
			"Open URL list in Telescope",
		},
		["gx"] = {
			function()
				local line = vim.fn.getline(".")
				if line ~= "" then
					local command = string.format(
						'echo "%s" | grep -Po "(http|https)://[A-z-#/]+[^ >,;()]*" | xargs -I "{}" xdg-open "{}" 2> /dev/null',
						line
					)
					os.execute(command)
				else
					vim.cmd('echo "Empty line"')
				end
			end,
			"Open URL",
		},
	},
}
local util = require("config.utils.mapping")
util.apply_map(mappings)
