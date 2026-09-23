return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = function(_, opts)
		opts.keywords = opts.keywords or {}
		opts.keywords.HMMM = {
			icon = "🤔",
			color = "#FFFFF3",
			alt = {
				"HUH",
				"THINK",
			},
		}
		return opts
	end,
}
