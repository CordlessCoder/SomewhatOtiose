return function(depname)
	return require("lazy.core.config").plugins[depname]._.loaded
end
