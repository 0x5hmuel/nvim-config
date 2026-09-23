return {
	"stevearc/oil.nvim",
	priority = 1000,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- "barrettruth/nonicons.nvim",
	},
	keys = {
		{
			"<BS>",
			mode = { "n", "v" },
			"<CMD>Oil<CR>",
			desc = "Open oil at the current file",
		},
	},
}
