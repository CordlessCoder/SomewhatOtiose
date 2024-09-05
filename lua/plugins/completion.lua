return {
	"hrsh7th/nvim-cmp",
	lazy = true,
	-- load cmp on InsertEnter
	event = "InsertEnter",
	config = function()
		local cmp = require("cmp")

		vim.o.completeopt = "menu,menuone,noselect"

		local function border(hl_name)
			return {
				{ "╭", hl_name },
				{ "─", hl_name },
				{ "╮", hl_name },
				{ "│", hl_name },
				{ "╯", hl_name },
				{ "─", hl_name },
				{ "╰", hl_name },
				{ "│", hl_name },
			}
		end

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip" },
				{ name = "crates" },
				{ name = "neorg" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "lazydev", group_lidex = 0 },
			},
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			window = {
				completion = {
					scrollbar = false,
					border = border("CmpBorder"),
				},
			},
			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
							""
						)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").jumpable(-1) then
						vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			},
		})

		-- local cmp_window = require("cmp.utils.window")
		--
		-- cmp_window.info_ = cmp_window.info
		-- cmp_window.info = function(self)
		-- 	local info = self:info_()
		-- 	info.scrollable = false
		-- 	return info
		-- end
		--
		-- local options = {
		-- 	window = {
		-- 		completion = {
		-- 			border = border("CmpBorder"),
		-- 			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
		-- 		},
		-- 		documentation = {
		-- 			border = border("CmpDocBorder"),
		-- 		},
		-- 	},
		-- 	snippet = {
		-- 		expand = function(args)
		-- 			require("luasnip").lsp_expand(args.body)
		-- 		end,
		-- 	},
		-- }
		--
		-- cmp.setup(options)
	end,
	-- these dependencies will only be loaded when cmp loads
	-- dependencies are always lazy-loaded unless specified otherwise
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
	},
}
