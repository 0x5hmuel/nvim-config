return {
	"nvim-telescope/telescope.nvim",
	-- tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim", "apdot/doodle" },
	lazy = false,
	opts = {
		defaults = {
			layout_strategy = "vertical",
		},
	},

	keys = {
		{
			"<leader>cc",
			function()
				require("telescope.builtin").colorscheme()
			end,
			desc = "Telescope colorscheme",
		},
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Telescope find files",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Telescope live grep",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Telescope buffers",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Telescope help tags",
		},
		{
			"<leader>fr",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "Telescope recent files ",
		},
		{
			"<leader>sg",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "Telescope grep string",
		},
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			extensions = {
				doodle = {},
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
		})
		-- load extension
		telescope.load_extension("doodle")
		local keymap = vim.keymap.set
		keymap("n", "<space>dd", function()
			telescope.extensions.doodle.find_notes()
		end, { desc = "Doodle Find Notes" })

		keymap("n", "<space>ff", function()
			telescope.extensions.doodle.find_files()
		end, { desc = "Doodle Find Files" })

		keymap("n", "<space>dy", function()
			telescope.extensions.doodle.find_templates()
		end, { desc = "Doodle Find Templates" })
	end,
}
