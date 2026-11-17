return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"folke/trouble.nvim",
	},
	config = function()
		require("mason").setup({
			PATH = "prepend",
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Definition helpers
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

		-- Mason configuration
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"tailwindcss",
				"ruff",
				"eslint",
			},
		})

		-- Capabilities
		local function setup_lsp(server, opts)
			opts = opts or {}
			opts.capabilities = capabilities

			vim.lsp.config(server, opts)
			vim.lsp.enable(server)
		end

		-- Lua
		setup_lsp("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- Tailwind CSS
		setup_lsp("tailwindcss")

		-- Ruff
		setup_lsp("ruff")

		-- ESLint
		setup_lsp("eslint")

		-- TypeScript (installed globally using Bun)
		setup_lsp("ts_ls", {
			cmd = {
				"typescript-language-server",
				"--stdio",
			},
		})

		-- BasedPyright
		setup_lsp("basedpyright", {
			settings = {
				basedpyright = {
					python = {
						pythonPath = "./.venv/bin/python",
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

		-- Keymaps
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
			desc = "Go to definition",
		})

		vim.keymap.set("n", "gD", open_definition_in_trouble, {
			desc = "Open definitions in Trouble",
		})

		vim.keymap.set("n", "<leader>gd", preview_definition, {
			desc = "Preview definition in float",
		})

		vim.keymap.set("n", "<leader>sd", function()
			vim.diagnostic.open_float(nil, { scope = "line" })
		end, {
			desc = "Line diagnostics",
		})

		vim.keymap.set("n", "<leader>vs", function()
			open_definition_in_split("vsplit")
		end, {
			desc = "Definition in vertical split",
		})

		vim.keymap.set("n", "<leader>hs", function()
			open_definition_in_split("split")
		end, {
			desc = "Definition in horizontal split",
		})

		vim.keymap.set("n", "<leader>ts", function()
			open_definition_in_split("tabnew")
		end, {
			desc = "Definition in new tab",
		})
	end,
}
