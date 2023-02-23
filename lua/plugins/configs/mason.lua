local present, mason = pcall(require, "mason")

if not present then
	return
end

local options = {

	PATH = "skip",

	ui = {
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ﮊ",
		},

		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},

	max_concurrent_installers = 10,
}
local ensure_installed = {
	-- Rust
	"rust-analyzer",
	"rustfmt",

	-- Python
	"python-lsp-server",

	-- lua stuff
	"lua-language-server",
	"stylua",

	-- web dev
	"css-lsp",
	"html-lsp",

	-- shell
	"shfmt",
	"shellcheck",

	-- TOML
	"taplo",

	-- C/C++/C# etc.
	"clangd",
	"clang-format",
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
	vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
end, {})

mason.setup(options)
