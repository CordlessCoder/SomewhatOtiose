local lazy_load = require("config.utils.lazy_load")
local notify_inner = lazy_load("notify", function()
	return function(obj)
		print(vim.inspect(obj))
	end
end)
local notify = function(obj)
	notify_inner()(obj)
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

		if vim.islist(result) then
			lutil.show_document(result[1], nil, { focus = true })

			if result > 1 then
				lutil.set_qflist(lutil.locations_to_items(result, vim.lsp.util._get_offset_encoding(0)))
				api.nvim_command("copen")
				api.nvim_command("wincmd p")
			end
		else
			lutil.jump_to_location(result)
		end
	end

	return handler
end

local function preview_location_callback(_, result)
	if result == nil or vim.tbl_isempty(result) then
		return nil
	end
	vim.lsp.util.preview_location(result[1], {})
end

local function goto_location_callback(_, result)
	if result == nil or vim.tbl_isempty(result) then
		return nil
	end
	vim.lsp.util.show_document(result[1], vim.lsp.util._get_offset_encoding(0), { focus = true })
end

function PeekDefinition()
	local params = vim.lsp.util.make_position_params()
	return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
end

function GotoDefinition()
	GotoRequest("textDocument/definition")
end

function GotoDeclaration()
	GotoRequest("textDocument/declaration")
end

function GotoRequest(request)
	local params = vim.lsp.util.make_position_params()
	return vim.lsp.buf_request(0, request, params, goto_location_callback)
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

vim.lsp.handlers["textDocument/definition"] = goto_definition()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	underline = true,
	signs = true,
})

vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = function()
		for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.api.nvim_win_get_config(winid).zindex then
				return
			end
		end

		vim.diagnostic.open_float({
			scope = "cursor",
			focusable = false,
			close_events = {
				"CursorMoved",
				"CursorMovedI",
				"BufHidden",
				"InsertCharPre",
				"WinLeave",
			},
		})
	end,
	group = "lsp_diagnostics_hold",
})

local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	client.server_capabilities.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<C-space>", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>ce", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gD", GotoDeclaration, bufopts)
	vim.keymap.set("n", "gd", GotoDefinition, bufopts)
	vim.keymap.set("n", "<leader>d", PeekDefinition, bufopts)
	vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		notify(vim.lsp.buf.list_workspace_folders())
	end, bufopts)

	-- util.load_mappings("lspconfig", { buffer = bufnr })

	-- if client.server_capabilities.signatureHelpProvider then
	-- require("nvchad_ui.signature").setup(client)
	-- end
end

vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
			completion = {
				completionItem = {
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
				},
			},
		},
	},
	handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border("LspInfoBorder") }),
		["textDocument/signatureHelp"] = vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{ border = border("LspSagaSignatureBorder") }
		),
	},
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
	end,
	root_markers = { ".git" },
})
vim.lsp.config("emmet", {
	capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
})
vim.lsp.config("html", {
	capabilities = { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
})
vim.lsp.enable("ts")
vim.lsp.enable("clangd")
vim.lsp.enable("lua")
vim.lsp.enable("omnisharp")
vim.lsp.enable("tinymist")
vim.lsp.enable("asm")
vim.lsp.enable("solidity")
vim.lsp.enable("pylsp")
vim.lsp.enable("jdtls")
