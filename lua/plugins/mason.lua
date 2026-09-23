return {
	"mason-org/mason.nvim",
	dependencies = { "mason-org/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
	opts = {
		ensure_installed = {
			"stylua",
			"fmt",
			-- "pyright",
			"prettier",
		},
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "eslint" },
		})

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			float = true,
			-- virtual_lines = true,
			underline = true,
		})
	end,
}
