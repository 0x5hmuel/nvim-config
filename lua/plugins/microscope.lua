return {
	"Cpoing/microscope.nvim",
	cmd = "MicroscopePeek",
	keys = {
		{ "<leader>r", ":MicroscopePeek<CR>", desc = "Peek definition" },
	},
	init = function()
		vim.opt.number = true
		vim.opt.relativenumber = true
	end,
	config = function()
		require("microscope")
	end,
}
