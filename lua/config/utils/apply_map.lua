return function(mappings)
	for mode, binds in pairs(mappings) do
		for key, data in pairs(binds) do
			vim.keymap.set(mode, key, data[1], { desc = data[2] })
		end
	end
end
