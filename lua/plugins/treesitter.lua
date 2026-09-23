return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "windwp/nvim-ts-autotag" },
	opts = {
		ensure_installed = { "c", "python", "javascript", "typescript", "svelte", "css" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>", -- start selection (enter)
				node_incremental = "<CR>", -- expand (press enter again)
				node_decremental = "<BS>", -- shrink (backspace)
				scope_incremental = "<TAB>", -- expand to scope (optional)
			},
		},
	},
}
