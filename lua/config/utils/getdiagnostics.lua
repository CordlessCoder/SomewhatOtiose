local lsp = vim.lsp
local diagnostic = vim.diagnostic

--- Get current diagnostics.
---
---@param bufnr integer? Buffer number to get diagnostics from. Use 0 for
---                      current buffer or nil for all buffers.
---@param severity vim.diagnostic.SeverityFilter
---@return number
return function(bufnr, severity)
	if next(lsp.get_clients({ bufnr = bufnr })) == nil then
		return 0
	end
	local clients = lsp.get_clients({ bufnr = bufnr })

	if clients then
		return #diagnostic.get(bufnr, { severity = severity })
	end
	return 0
end
