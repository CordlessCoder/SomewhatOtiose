local rt = require("rust-tools")
rt.setup({
	server = {
		on_attach = function(_, bufnr)
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
			-- Open Cargo.toml
			vim.keymap.set("n", "<Leader>ct", rt.open_cargo_toml.open_cargo_toml, { buffer = bufnr })
			-- Move item down
			vim.keymap.set("n", "<Leader>md", function()
				rt.move_item.move_item(false)
			end, { buffer = bufnr, desc = "Move Rust item down" })
			-- Move item up
			vim.keymap.set("n", "<Leader>mu", function()
				rt.move_item.move_item(true)
			end, { buffer = bufnr, desc = "Move Rust item up" })
		end,
		["rust-analyzer"] = {
			checkOnSave = {
				command = "cargo clippy --all",
			},
		},
	},
})
