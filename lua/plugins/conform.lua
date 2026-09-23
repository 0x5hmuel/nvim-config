return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	-- only opts, no config()
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "zuban", "black" },
			javascript = { "prettier", "eslint_d" },
			typescript = { "prettier", "eslint_d" },
			javascriptreact = { "eslint_d", "prettier" },
			typescriptreact = { "eslint_d", "prettier" },
			json = { "jq" },
			sh = { "shfmt" },
			markdown = { "prettier" },
			nix = { "nixfmt" },
		},
		format_on_save = {
			lsp_fallback = true,
			-- async = true,
			timeout_ms = 5000,
		},
		formatters = {
			black = {
				prepend_args = { "-l", "79" },
			},
		},
	},
}
