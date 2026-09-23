return {
	cmd = { "basedpyright-langserver" },

	filetypes = { "python" },
	config = function()
		vim.lsp.enable("basedpyright-langserver")
	end,
}
