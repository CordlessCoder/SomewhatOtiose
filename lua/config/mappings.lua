local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local present, notify = pcall(require, "notify")
if not present then
	notify = vim.print
end
local function live_grep_from_project_git_root()
	local function is_git_repo()
		vim.fn.system("git rev-parse --is-inside-work-tree")

		return vim.v.shell_error == 0
	end

	local function get_git_root()
		local dot_git_path = vim.fn.finddir(".git", ".;")
		return vim.fn.fnamemodify(dot_git_path, ":h")
	end

	local opts = {}

	if is_git_repo() then
		opts = {
			cwd = get_git_root(),
		}
	end
	telescope_builtin.live_grep(opts)
end
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
	vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
end

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
		["<Tab>"] = { ">", "󰉶   Indent selected lines" },
		["<S-Tab>"] = { "<", "󰉵   Unindent selected lines" },
		["<leader>ca"] = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Perform code action on selection" },
	},
	t = {},
	n = {
		["<leader>h"] = {
			function()
				if vim.version().minor < 10 then
					require("lsp-inlayhints").toggle()
					return
				end
				local hint = vim.lsp.inlay_hint
				local enabled = hint.is_enabled(0)
				hint.enable(0, not enabled)
			end,
			"Toggle inlayhints",
		},
		["<leader>ng"] = {
			function()
				local neogit = require("neogit")
				neogit.open({ kind = "vsplit" })
			end,
			"Open NeoGit",
		},
		["<leader>``"] = {
			function()
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
				notify(string.format("Colemak binds: %s", vim.g.colemak))
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
		["<leader>sbg"] = {
			live_grep_from_project_git_root,
			"Fuzzy find from project's git root",
		},
		["<leader>sr"] = {
			function()
				telescope_builtin.oldfiles()
			end,
			"Fuzzy find recently opened files",
		},
		["<leader>sg"] = {
			function()
				telescope_builtin.git_files()
			end,
			"Fuzzy search git files",
		},
		["<leader>se"] = {
			function()
				telescope_builtin.live_grep()
			end,
			"Fuzzy find using live grep",
		},
		["<leader>b"] = {
			function()
				telescope_builtin.buffers()
			end,
			"Fuzzy find buffers",
		},
		["<leader>sf"] = {
			function()
				telescope_builtin.find_files()
			end,
			"Fuzzy find files",
		},
		["<leader>f"] = {
			function()
				telescope_builtin.find_files()
			end,
			"Fuzzy find files",
		},
		["<leader>pf"] = {
			function()
				telescope_builtin.find_files({ cwd = ".." })
			end,
			"Fuzzy find files in parent directory",
		},
		["cr"] = {
			function()
				vim.lsp.buf.rename()
			end,
			"LSP rename",
		},
		-- ["gD"] = {
		-- 	function()
		-- 		vim.lsp.buf.declaration()
		-- 	end,
		-- 	"Go to declaration",
		-- },
		["<leader>tn"] = {
			function()
				telescope.extensions.notify.notify()
			end,
			"Show notifications",
		},
		["<leader>te"] = {
			function()
				telescope.extensions.emoji.emoji()
			end,
			"Show emoji picker",
		},
		["<leader>tu"] = {
			function()
				telescope.extensions.undo.undo()
			end,
			"Show undo history",
		},
		["gd"] = {
			function()
				telescope_builtin.lsp_definitions()
			end,
			"Go to definition",
		},
		["gi"] = {
			function()
				telescope_builtin.lsp_implementations()
			end,
			"Go to implementations",
		},
		["gr"] = {
			function()
				telescope_builtin.lsp_references()
			end,
			"Go to definition",
		},
		["gt"] = {
			function()
				telescope_builtin.type_definitions()
			end,
			"Go to definition",
		},
		["<leader>tt"] = { "<Cmd>TroubleToggle<CR>", "Toggle the Trouble panel" },
		["<leader>tw"] = { "<Cmd>Trouble workspace_diagnostics<CR>", "Show workspace diagnostics in Trouble" },
		["<leader>td"] = { "<Cmd>Trouble document_diagnostics<CR>", "Show document diagnostics in Trouble" },
		["<leader>tq"] = { "<Cmd>TodoQuickFix<CR>", "Show todos in Trouble" },
		["<leader>e"] = { "<Cmd>NvimTreeFocus<CR>", "Focus NvimTree" },
		["<leader>std"] = { "<Cmd>Trouble lsp_definitions<CR>", "Show LSP definitions in a Trouble panel" },
		["<leader>sti"] = { "<Cmd>Trouble lsp_implementations<CR>", "Show LSP implementations in a Trouble panel" },
		["<leader>str"] = { "<Cmd>Trouble lsp_references<CR>", "Show LSP references in a Trouble panel" },
		["<leader>stt"] = { "<Cmd>Trouble lsp_type_defitions<CR>", "Show LSP type defitions in a Trouble panel" },
		-- ["<A-x>"] = { "<Cmd>ToggleTerm direction=float<CR>", "Open floating terminal" },
		-- ["<A-t>"] = { "<Cmd>ToggleTerm direction=vertical<CR>", "Open vertical terminal" },
		-- ["<A-y>"] = { "<Cmd>ToggleTerm direction=horizontal<CR>", "Open horizontal terminal" },
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
		["<A-4>"] = { "<Cmd>BufferGoto 4<CR>", "Go to the fourth buffer" },
		["<A-5>"] = { "<Cmd>BufferGoto 5<CR>", "Go to the fifth buffer" },
		["<A-6>"] = { "<Cmd>BufferGoto 6<CR>", "Go to the sixth buffer" },
		["<A-7>"] = { "<Cmd>BufferGoto 7<CR>", "Go to the seventh buffer" },
		["<A-8>"] = { "<Cmd>BufferGoto 8<CR>", "Go to the eighth buffer" },
		["<A-9>"] = { "<Cmd>BufferGoto 9<CR>", "Go to the ninth buffer" },
		["<A-0>"] = { "<Cmd>BufferLast<CR>", "Go to last buffer" },
		["<A-,>"] = { "<Cmd>BufferMovePrevious<CR>", "Move buffer back" },
		["<A-.>"] = { "<Cmd>BufferMoveNext<CR>", "Move buffer back" },
		["<Tab>"] = { "<Cmd>BufferNext<CR>", "󰉶   Next Buffer" },
		["<S-Tab>"] = { "<Cmd>BufferPrevious<CR>", "󰉵   Prev Buffer" },
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
				require("dap").repl.toggle()
			end,
			"DAP repl",
		},
		["<leader>dt"] = {
			function()
				require("dapui").toggle()
			end,
			"DAPui toggle",
		},
		["<leader>a"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Perform code action" },
		["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Perform code action" },
		["<leader>n"] = { "<cmd>NvimTreeToggle <CR>", "   toggle nvimtree" },
		["<C-n>"] = { "<cmd>execute 'normal <Plug>(VM-Find-Under)' <CR>", "   toggle nvimtree" },
		["<C-s>"] = { "<cmd> w <CR>", "󰆓   Save file" },
		["<C-S>"] = { "<cmd> wa <CR>", "󰆔   Save all files" },
		["<C-g>"] = {
			function()
				require("zen-mode").toggle()
			end,
			"Focus mode",
		},
		-- ["<C-t>"] = { "<cmd> tabedit <CR>", "New tab" },
		["<A-n>"] = { "<cmd> tabn <CR>", "next tab" },
		["<leader>cc"] = { "<cmd> ColorizerToggle <CR>", "󰌁   Toggle colorizer" },
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
			"Reset font size (to 14)",
		},
		-- ["gz"] = {
		-- 	"<cmd> UrlView <CR>",
		-- 	"Open URL list in Telescope",
		-- },
		-- ["gx"] = {
		-- 	function()
		-- 		local line = vim.fn.getline(".")
		-- 		if line ~= "" then
		-- 			local command = string.format(
		-- 				'echo "%s" | grep -Po "(http|https)://[A-z-#/]+[^ >,;()]*" | xargs -I "{}" xdg-open "{}" 2> /dev/null',
		-- 				line
		-- 			)
		-- 			os.execute(command)
		-- 		else
		-- 			vim.cmd('echo "Empty line"')
		-- 		end
		-- 	end,
		-- 	"Open URL",
		-- },
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
local util = require("config.utils.mapping")
util.apply_map(mappings)
