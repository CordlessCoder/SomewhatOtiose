return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		local util = require("lspconfig/util")
		local lazy_load = require("config.utils.lazy_load")
		local notify_inner = lazy_load("notify", function()
			return function(obj)
				print(vim.inspect(obj))
			end
		end)
		local notify = function(obj)
			notify_inner()(obj)
		end
		local on_attach = function(client, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
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
			vim.lsp.util.jump_to_location(result[1], vim.lsp.util._get_offset_encoding(0))
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
					lutil.jump_to_location(result[1])

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

		vim.lsp.handlers["textDocument/definition"] = goto_definition()

		-- LSP settings (for overriding per client)
		local handlers = {
			["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border("LspInfoBorder") }),
			["textDocument/signatureHelp"] = vim.lsp.with(
				vim.lsp.handlers.signature_help,
				{ border = border("LspSagaSignatureBorder") }
			),
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.offsetEncoding = { "utf-16" }

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
			"typst_lsp",
			"pylsp",
			"html",
			"cssls",
			"lua_ls",
			"emmet_ls",
			"bashls",
			"ts_ls",
			-- "ccls",
			"clangd",
			"jdtls",
			"taplo",
			"gopls",
			"solidity",
			"zls",
			"marksman",
			"crystalline",
			"kotlin_language_server",
			"vls",
			"phpactor",
			"asm_lsp",
			"wgsl_analyzer",
			"hls",
			"jsonls",
			-- "solidity_ls",
		}

		for _, lsp in ipairs(servers) do
			if lsp ~= "pylsp" and lsp ~= "solidity" and lsp ~= "asm_lsp" then
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

		require("lspconfig").omnisharp.setup({
			cmd = { "omnisharp" },

			settings = {
				FormattingOptions = {
					-- Enables support for reading code style, naming convention and analyzer
					-- settings from .editorconfig.
					EnableEditorConfigSupport = true,
					-- Specifies whether 'using' directives should be grouped and sorted during
					-- document formatting.
					OrganizeImports = nil,
				},
				MsBuild = {
					-- If true, MSBuild project system will only load projects for files that
					-- were opened in the editor. This setting is useful for big C# codebases
					-- and allows for faster initialization of code navigation features only
					-- for projects that are relevant to code that is being edited. With this
					-- setting enabled OmniSharp may load fewer projects and may thus display
					-- incomplete reference lists for symbols.
					LoadProjectsOnDemand = nil,
				},
				RoslynExtensionsOptions = {
					-- Enables support for roslyn analyzers, code fixes and rulesets.
					EnableAnalyzersSupport = true,
					-- Enables support for showing unimported types and unimported extension
					-- methods in completion lists. When committed, the appropriate using
					-- directive will be added at the top of the current file. This option can
					-- have a negative impact on initial completion responsiveness,
					-- particularly for the first few completion sessions after opening a
					-- solution.
					EnableImportCompletion = true,
					-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
					-- true
					AnalyzeOpenDocumentsOnly = nil,
				},
				Sdk = {
					-- Specifies whether to include preview versions of the .NET SDK when
					-- determining which version to use for project loading.
					IncludePrereleases = true,
				},
			},
		})
		lspconfig.asm_lsp.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,

			root_dir = function(filename, bufnr)
				local rev = string.reverse(filename)
				local from_end = string.find(rev, "/") or 0
				return string.sub(filename, 1, string.len(filename) - from_end)
			end,
		})
		-- lspconfig.lua_ls.setup({
		-- 	on_attach = on_attach,
		-- 	capabilities = capabilities,
		-- 	handlers = handlers,
		--
		-- 	settings = {
		-- 		Lua = {
		-- 			diagnostics = {
		-- 				globals = { "vim" },
		-- 			},
		-- 			workspace = {
		-- 				library = {
		-- 					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
		-- 					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
		-- 				},
		-- 				maxPreload = 100000,
		-- 				preloadFileSize = 10000,
		-- 			},
		-- 		},
		-- 	},
		-- })
		lspconfig.solidity.setup({
			root_dir = util.root_pattern(".git", "package.json", "LICENSE", "truffle-config.js"),
			handlers = handlers,
			capabilities = capabilities,
		})
		-- lspconfig.rust_analyzer.setup({
		-- 	handlers = handlers,
		-- 	on_attach = on_attach,
		-- 	capabilities = capabilities,
		--
		-- 	settings = {
		-- 		["rust_analyzer"] = {
		-- 			check = {
		-- 				allTargets = true,
		-- 				command = "clippy",
		-- 			},
		-- 			cargo = {
		-- 				features = "all",
		-- 			},
		-- 			semanticHighlighting = {
		-- 				punctuation = {
		-- 					enable = true,
		-- 				},
		-- 				--   operator = {
		-- 				--     specialization = {
		-- 				--       enable = true,
		-- 				--     },
		-- 				--   },
		-- 			},
		-- 			lru = {
		-- 				capacity = 256,
		-- 			},
		-- 			typing = {
		-- 				autoClosingAngleBrackets = {
		-- 					enable = true,
		-- 				},
		-- 			},
		-- 		},
		-- 	},
		-- })
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

		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false,
			underline = true,
			signs = true,
		})

		-- Show diagnostics under the cursor when holding position
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

		-- vim.cmd([[
		--     autocmd CursorHold * lua vim.diagnostic.open_float()
		--     autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()
		-- ]])
	end,
	lazy = true,
	cmd = { "LspInfo", "LspLog", "LspRestart", "LspStart", "LspStop" },
	ft = {
		"rust",
		"lua",
		"python",
		"c",
		"cpp",
		"c++",
		"javascript",
		"toml",
		"php",
		"bash",
		"kdl",
		"fish",
		"go",
		"c#",
		"vb",
		"cs",
		"json",
		"jsonc",
		"typst",
		"html",
	},
}
