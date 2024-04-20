return function(depname, fallback)
	local dep = nil

	return function()
		if dep == nil then
			local success
			success, dep = pcall(require, depname)
			if not success then
				dep = fallback()
			end
		end
		return dep
	end
end
