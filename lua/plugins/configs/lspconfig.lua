local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<C-space>", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>ce", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)

	-- util.load_mappings("lspconfig", { buffer = bufnr })

	-- if client.server_capabilities.signatureHelpProvider then
	-- require("nvchad_ui.signature").setup(client)
	-- end
end

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

local function goto_definition(split_cmd)
	local lutil = vim.lsp.util
	local log = require("vim.lsp.log")
	local api = vim.api

	-- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
	local handler = function(_, result, ctx)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, "No location found")
			return nil
		end

		if split_cmd then
			vim.cmd(split_cmd)
		end

		if vim.tbl_islist(result) then
			lutil.jump_to_location(result[1])

			if #result > 1 then
				lutil.set_qflist(lutil.locations_to_items(result))
				api.nvim_command("copen")
				api.nvim_command("wincmd p")
			end
		else
			lutil.jump_to_location(result)
		end
	end

	return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition("split")

-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border("LspInfoBorder") }),
	["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = border("LspSagaSignatureBorder") }
	),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

local servers = {
	"pylsp",
	"rust_analyzer",
	"html",
	"cssls",
	"lua_ls",
	"emmet_ls",
	"bashls",
	"tsserver",
	"ccls",
	"clangd",
	"jdtls",
	"taplo",
	"gopls",
	"solidity",
	"zls",
	"marksman",
	"csharp_ls",
	"crystalline",
	"kotlin_language_server",
	"vls",
	-- "solidity_ls",
}

for _, lsp in ipairs(servers) do
	if --[[ lsp ~= "sumneko_lua" and ]]
		lsp ~= "pylsp"
		and lsp ~= "rust_analyzer"
		and lsp ~= "solidity"
		and lsp ~= "lua_ls"
	then
		lspconfig[lsp].setup({
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				if lsp == "emmet_ls" or lsp == "html" then
					capabilities.textDocument.completion.completionItem.snippetSupport = true
				end
			end,
			capabilities = capabilities,
			handlers = handlers,
		})
	end
end
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	handlers = handlers,

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})
lspconfig.solidity.setup({
	root_dir = util.root_pattern(".git", "package.json", "LICENSE", "truffle-config.js"),
	handlers = handlers,
	capabilities = capabilities,
})
lspconfig.rust_analyzer.setup({
	handlers = handlers,
	on_attach = on_attach,
	capabilities = capabilities,

	settings = {
		["rust_analyzer"] = {
			semanticHighlighting = {
				punctuation = {
					enable = true,
				},
				--   operator = {
				--     specialization = {
				--       enable = true,
				--     },
				--   },
			},
			lru = {
				capacity = 256,
			},
			typing = {
				autoClosingAngleBrackets = {
					enable = true,
				},
			},
		},
	},
})
lspconfig.pylsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	handlers = handlers,

	settings = {
		pylsp = {
			plugins = {
				jedi_completion = {
					fuzzy = true,
				},
				pyflakes = {
					enabled = false,
				},
				yapf = {
					enabled = false,
				},
				autopep8 = {
					enabled = false,
				},
				flake8 = {
					enabled = true,
					maxLineLength = 129,
					indentsize = 4,
				},
				pycodestyle = {
					-- ignore = { "W391" },
					enabled = false,
					maxLineLength = 129,
				},
			},
		},
	},
})
