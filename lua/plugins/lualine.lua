return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function(_, opts)
		local trouble = require("trouble")

		-- Nerd Font icons via codepoints (safe to copy/paste)
		local icon = {
			bolt = "\u{f0e7}",
			bug = "\u{f188}",
			robot = "\u{f06a9}",
			add = "\u{f067}",
			mod = "\u{f040}",
			del = "\u{f068}",
			err = "\u{f057}",
			warn = "\u{f06a}",
			info = "\u{f05a}",
			hint = "\u{f0eb}",
		}

		local c = {
			green = "#a6e3a1",
			red = "#f38ba8",
			yellow = "#f9e2af",
			blue = "#89b4fa",
			dark = "#1e1e2e",
		}

		-- badge highlights: colored box with dark icon
		local function set_hl()
			local function badge(name, bg)
				vim.api.nvim_set_hl(0, name, { fg = c.dark, bg = bg })
			end
			badge("LlBadgeAdd", c.green)
			badge("LlBadgeMod", c.green)
			badge("LlBadgeDel", c.red)
			vim.api.nvim_set_hl(0, "LlDiagError", { fg = c.red })
			vim.api.nvim_set_hl(0, "LlDiagWarn", { fg = c.yellow })
			vim.api.nvim_set_hl(0, "LlDiagInfo", { fg = c.blue })
			vim.api.nvim_set_hl(0, "LlDiagHint", { fg = c.blue })
			vim.api.nvim_set_hl(0, "LlText", { fg = "NONE", bg = "NONE" })
		end
		set_hl()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })

		-- transparent theme, only the mode text is colored
		local function mode_colors(fg)
			return { a = { fg = fg, bg = "NONE", gui = "bold" }, b = { bg = "NONE" }, c = { bg = "NONE" } }
		end
		local transparent = {
			normal = mode_colors("#cdd6f4"),
			insert = mode_colors(c.green),
			visual = mode_colors("#cba6f7"),
			replace = mode_colors(c.red),
			command = mode_colors(c.yellow),
			inactive = mode_colors("#6c7086"),
		}

		local function lsp_clients()
			local names = {}
			for _, cl in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
				if cl.name ~= "copilot" then
					table.insert(names, cl.name)
				end
			end
			if #names == 0 then
				return ""
			end
			return icon.bolt .. " " .. table.concat(names, ", ")
		end

		-- hook your runner into this: vim.g.statusline_task = "run this file" (or nil)
		local function task()
			local t = vim.g.statusline_task
			if not t or t == "" then
				return ""
			end
			return icon.bug .. " running: " .. t
		end

		local function copilot()
			if #vim.lsp.get_clients({ bufnr = 0, name = "copilot" }) == 0 then
				return ""
			end
			return icon.robot .. " on"
		end

		local function diff()
			local d = vim.b.gitsigns_status_dict
			if not d then
				return ""
			end
			local function part(group, ic, n)
				return string.format("%%#%s# %s %%*%%#LlText# %d  ", group, ic, n)
			end
			local out = ""
			if (d.added or 0) > 0 then out = out .. part("LlBadgeAdd", icon.add, d.added) end
			if (d.changed or 0) > 0 then out = out .. part("LlBadgeMod", icon.mod, d.changed) end
			if (d.removed or 0) > 0 then out = out .. part("LlBadgeDel", icon.del, d.removed) end
			return out
		end

		local function diagnostics()
			local counts = vim.diagnostic.count(0)
			local S = vim.diagnostic.severity
			local items = {
				{ S.ERROR, "LlDiagError", icon.err },
				{ S.WARN,  "LlDiagWarn",  icon.warn },
				{ S.INFO,  "LlDiagInfo",  icon.info },
				{ S.HINT,  "LlDiagHint",  icon.hint },
			}
			local out = ""
			for _, it in ipairs(items) do
				local n = counts[it[1]]
				if n and n > 0 then
					out = out .. string.format("%%#%s#%s %%*%%#LlText#%d  ", it[2], it[3], n)
				end
			end
			return out
		end

		local symbols = trouble.statusline({
			mode = "lsp_document_symbols",
			groups = {},
			title = false,
			filter = { range = true },
			format = "{kind_icon}{symbol.name:Normal}",
			hl_group = "lualine_c_normal",
		})

		opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
			theme = transparent,
			icons_enabled = true,
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
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

		opts.sections = {
			lualine_a = { { "mode", padding = { left = 1, right = 2 } } },
			lualine_b = {
				{ "filename", path = 0, padding = { left = 0, right = 2 }, symbols = { modified = " ●" } },
			},
			lualine_c = {
				{ lsp_clients, padding = { left = 0, right = 2 } },
				{ task,        padding = { left = 0, right = 2 } },
				{ copilot,     padding = { left = 0, right = 2 } },
				{ symbols.get, cond = symbols.has },
			},
			lualine_x = { { diff, padding = 0 }, { diagnostics, padding = 0 } },
			lualine_y = {},
			lualine_z = {},
		}

		opts.inactive_sections = {
			lualine_c = { "filename" },
		}
	end,
}
