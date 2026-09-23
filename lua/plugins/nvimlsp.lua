return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"folke/trouble.nvim",
	},
	config = function()
		require("mason").setup()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- 🧩 Definition helpers
		local function preview_definition()
			vim.lsp.buf_request(0, "textDocument/definition", vim.lsp.util.make_position_params(), function(_, result)
				if not result or vim.tbl_isempty(result) then
					vim.notify("No definition found", vim.log.levels.WARN)
					return
				end
				vim.lsp.util.preview_location(result[1])
			end)
		end

		local function open_definition_in_split(split_cmd)
			vim.cmd(split_cmd)
			vim.lsp.buf.definition()
		end

		local function open_definition_in_trouble()
			local ok, trouble = pcall(require, "trouble")
			if not ok then
				vim.notify("Trouble.nvim not installed", vim.log.levels.ERROR)
				return
			end
			trouble.open("lsp_definitions")
		end

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "tailwindcss", "ruff", "eslint" },
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = { diagnostics = { globals = { "vim" } } },
						},
					})
				end,
			},
		})
		require("lspconfig").basedpyright.setup({
			settings = {
				basedpyright = {
					python = {
						pythonPath = ".venv/bin/",
					},
					analysis = {
						typeCheckingMode = "recommended",
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
						reportUnknownMemberType = false,
						useTypingExtensions = true,
						inlayHints = {
							callArgumentNames = true,
							callArgumentNamesMatching = true,
						},
					},
				},
			},
		})

		-- 🧭 Keymaps
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
		vim.keymap.set("n", "gD", open_definition_in_trouble, { desc = "Open definitions in Trouble" })
		vim.keymap.set("n", "<leader>gd", preview_definition, { desc = "Preview definition in float" })
		vim.keymap.set("n", "<leader>sd", function()
			vim.diagnostic.open_float(nil, { scope = "line" })
		end, {})
		vim.keymap.set("n", "<leader>vs", function()
			open_definition_in_split("vsplit")
		end, { desc = "Definition in vertical split" })
		vim.keymap.set("n", "<leader>hs", function()
			open_definition_in_split("split")
		end, { desc = "Definition in horizontal split" })
		vim.keymap.set("n", "<leader>ts", function()
			open_definition_in_split("tabnew")
		end, { desc = "Definition in new tab" })
	end,
}
