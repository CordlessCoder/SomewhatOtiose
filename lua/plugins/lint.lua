return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			-- markdown = { "vale" },
			bash = { "shellcheck" },
			sh = { "shellcheck" },
			fish = { "fish" },
			python = { "ruff" },
			go = { "golangcilint" },
			c = { "clangtidy" },
			cpp = { "clangtidy" },
		}
	end,
	init = function()
		function _G.copy(obj, seen)
			if type(obj) ~= "table" then
				return obj
			end
			if seen and seen[obj] then
				return seen[obj]
			end
			local s = seen or {}
			local res = {}
			s[obj] = res
			for k, v in next, obj do
				res[copy(k, s)] = copy(v, s)
			end
			return setmetatable(res, getmetatable(obj))
		end
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()
			end,
		})
		-- Helper functions for active/inactive linter management
		local function get_all_linters_by_ft(linters_tbl_key)
			return require("lint")[linters_tbl_key] or {}
		end

		local function get_linters_for_ft(linters_tbl_key)
			local linters_tbl = get_all_linters_by_ft(linters_tbl_key)
			return linters_tbl[vim.bo.filetype] or {}
		end

		local function set_linters_for_ft(linters_tbl_key, linters)
			local linters_tbl = get_all_linters_by_ft(linters_tbl_key)
			linters_tbl[vim.bo.filetype] = linters
			require("lint")[linters_tbl_key] = linters_tbl
		end

		-- Getters
		local function get_active_linters_for_ft()
			return get_linters_for_ft("linters_by_ft")
		end

		local function get_inactive_linters_for_ft()
			return get_linters_for_ft("inactive_linters_by_ft")
		end

		-- Setters
		local function set_active_linters_for_ft(linters)
			return set_linters_for_ft("linters_by_ft", linters)
		end

		local function set_inactive_linters_for_ft(linters)
			return set_linters_for_ft("inactive_linters_by_ft", linters)
		end

		-- Enable/Disable Linters
		local function enable_linter_for_ft(linter)
			local active_linters = get_active_linters_for_ft()
			if not vim.tbl_contains(active_linters, linter) then
				table.insert(active_linters, linter)
				set_active_linters_for_ft(active_linters)
			end
			local inactive_linters = get_inactive_linters_for_ft()
			for i, v in ipairs(inactive_linters) do
				if v == linter then
					table.remove(inactive_linters, i)
					set_inactive_linters_for_ft(inactive_linters)
					break
				end
			end
		end

		local function disable_linter_for_ft(linter)
			local inactive_linters = get_inactive_linters_for_ft()
			if not vim.tbl_contains(inactive_linters, linter) then
				table.insert(inactive_linters, linter)
				set_inactive_linters_for_ft(inactive_linters)
			end
			local active_linters = get_active_linters_for_ft()
			for i, v in ipairs(active_linters) do
				if v == linter then
					table.remove(active_linters, i)
					set_active_linters_for_ft(active_linters)
					break
				end
			end
		end

		local function stop_linters(linter)
			local linters_to_stop = linter
			if #linters_to_stop == 0 then
				linters_to_stop = copy(get_active_linters_for_ft())
			end

			for _, l in ipairs(linters_to_stop) do
				disable_linter_for_ft(l)
			end

			vim.cmd("LintInfo")
			vim.diagnostic.reset(nil, vim.api.nvim_get_current_buf())
			require("lint").try_lint()
		end

		local function start_linters(linter)
			local linters_to_start = linter
			if #linters_to_start == 0 then
				linters_to_start = copy(get_inactive_linters_for_ft())
			end

			for _, l in ipairs(linters_to_start) do
				enable_linter_for_ft(l)
			end

			vim.cmd("LintInfo")
			require("lint").try_lint()
		end

		vim.api.nvim_create_user_command("LintInfo", function()
			local configured_linters = get_active_linters_for_ft()
			local inactive_linters = get_inactive_linters_for_ft()

			if #configured_linters > 0 then
				vim.notify("Configured Linters: " .. table.concat(configured_linters, ", "))
			end

			if #inactive_linters > 0 then
				vim.notify("Inactive Linters: " .. table.concat(inactive_linters, ", "))
			end
		end, {})

		vim.api.nvim_create_user_command("LintStop", function(info)
			stop_linters(info.args)
		end, {
			desc = "Manually stops the active linter(s) on current buffer or session",
			nargs = "*",
			complete = get_active_linters_for_ft,
		})

		vim.api.nvim_create_user_command("LintStart", function(info)
			start_linters(info.args)
		end, {
			desc = "Manually start the linter(s) on current buffer or session",
			nargs = "*",
			complete = get_inactive_linters_for_ft,
		})
	end,
	lazy = true,
	ft = { "go", "python", "c", "c++", "fish", "bash" },
}
