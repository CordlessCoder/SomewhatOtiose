return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
	},
	config = function()
		local function on_attach(bufnr)
			local api = require("nvim-tree.api")
			local kset = vim.keymap.set

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Default mappings. Feel free to modify or remove as you wish.
			--
			-- BEGIN_DEFAULT_ON_ATTACH
			kset("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
			kset("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
			kset("n", "<C-k>", api.node.show_info_popup, opts("Info"))
			kset("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
			kset("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
			kset("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
			kset("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
			kset("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
			kset("n", "<CR>", api.node.open.edit, opts("Open"))
			kset("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
			kset("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
			kset("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
			kset("n", ".", api.node.run.cmd, opts("Run Command"))
			kset("n", "-", api.tree.change_root_to_parent, opts("Up"))
			kset("n", "a", api.fs.create, opts("Create"))
			kset("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
			kset("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
			kset("n", "c", api.fs.copy.node, opts("Copy"))
			kset("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
			kset("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
			kset("n", "]c", api.node.navigate.git.next, opts("Next Git"))
			kset("n", "d", api.fs.remove, opts("Delete"))
			kset("n", "D", api.fs.trash, opts("Trash"))
			kset("n", "E", api.tree.expand_all, opts("Expand All"))
			kset("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
			kset("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
			kset("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
			kset("n", "F", api.live_filter.clear, opts("Clean Filter"))
			kset("n", "f", api.live_filter.start, opts("Filter"))
			kset("n", "g?", api.tree.toggle_help, opts("Help"))
			kset("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
			kset("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
			kset("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
			kset("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
			kset("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
			kset("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
			kset("n", "o", api.node.open.edit, opts("Open"))
			kset("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
			kset("n", "p", api.fs.paste, opts("Paste"))
			kset("n", "P", api.node.navigate.parent, opts("Parent Directory"))
			kset("n", "q", api.tree.close, opts("Close"))
			kset("n", "r", api.fs.rename, opts("Rename"))
			kset("n", "R", api.tree.reload, opts("Refresh"))
			kset("n", "s", api.node.run.system, opts("Run System"))
			kset("n", "S", api.tree.search_node, opts("Search"))
			kset("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
			kset("n", "W", api.tree.collapse_all, opts("Collapse"))
			kset("n", "x", api.fs.cut, opts("Cut"))
			kset("n", "y", api.fs.copy.filename, opts("Copy Name"))
			kset("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
			kset("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
			kset("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
			-- END_DEFAULT_ON_ATTACH

			-- Mappings migrated from view.mappings.list
			--
			-- You will need to insert "your code goes here" for any mappings with a custom action_cb
			kset("n", "u", api.tree.change_root_to_parent, opts("Up"))
		end
		--
		-- OR setup with some options
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			on_attach = on_attach,
			-- view = {
			-- 	width = 30,
			-- 	mappings = {
			-- 		list = {
			-- 			{ key = "u", action = "dir_up" },
			-- 		},
			-- 	},
			-- },
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		})
	end,
	-- cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse", "NvimTreeOpen", "NvimTreeClose" },
	lazy = false,
	keys = {
		{
			"<leader>n",
			function()
				require("nvim-tree.api").tree.toggle()
			end,
			desc = "Toggle nvim-tree",
		},
	},
}
