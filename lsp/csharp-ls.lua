return {
	cmd = { "csharp-ls" },
	filetypes = { "csharp", "cs" },
    root_dir = vim.fs.root(
      0, 
      function(name, path)
        return name:match('%.sln$') ~= nil
      end
    )
}
