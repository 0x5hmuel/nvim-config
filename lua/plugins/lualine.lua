return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function(_, opts)
		local trouble = require("trouble")

		-- define base layout first
		opts.sections = vim.tbl_deep_extend("force", opts.sections or {}, {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename", "filesize" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		})

		local symbols = trouble.statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = true,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			hl_group = "lualine_c_normal",
		})

		-- then inject Trouble's symbols
		table.insert(opts.sections.lualine_c, {
			symbols.get,
			cond = symbols.has,
		})

		-- visual options
		opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			icons_enabled = true,
			theme = "auto",
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
				refresh_time = 16, -- ~60fps
				events = {
					"WinEnter",
					"BufEnter",
					"BufWritePost",
					"SessionLoadPost",
					"FileChangedShellPost",
					"VimResized",
					"Filetype",
					"ModeChanged",
				},
			},
		})
	end,
}
