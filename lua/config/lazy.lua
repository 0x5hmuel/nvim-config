-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "base16-everforest-dark-hard" } },
	-- automatically check for plugin updates
	checker = { enabled = true, notify = false },
})
--
--
--
-- rkeymap for the lazyvim plugin manager
vim.keymap.set("n", "<leader>L", function()
	vim.cmd("Lazy")
end)
vim.keymap.set("n", "<leader>Lu", function()
	vim.cmd("Lazy update")
end, { desc = "Run update for plugins with LPM" })
vim.keymap.set("n", "<leader>Ls", function()
	vim.cmd("Lazy sync")
end, { desc = "Run sync for plugins with LPM" })

require("alpha")
require("oil").setup()
require("plugins.kulala")
vim.cmd("colorscheme everforest")
-- vim.cmd("colorscheme nordfox")

vim.cmd("set number relativenumber")
require("kulala")
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--
require("sidekick")
require("mini")

require("ts-error-translator").setup({
	-- Auto-attach to LSP servers for TypeScript diagnostics (default: true)
	auto_attach = true,

	-- LSP server names to translate diagnostics for (default shown below)
	servers = {
		"astro",
		"svelte",
		"ts_ls",
		"ts_ls",
		"typescript-tools",
		"volar",
		"vtsls",
	},
})
require("bufferline").setup()
require("spectre").setup()
vim.opt.termguicolors = true

-- Create an autocmd so your italic overrides always win against colorschemes

-- Helper function to inject italics while preserving theme colors
local function make_italic(group_name)
	-- Get the existing highlight details (true gets RGB values instead of terminal IDs)
	local hl = vim.api.nvim_get_hl(0, { name = group_name, link = false })

	-- Force italic to true while retaining the existing foreground (fg) and background (bg)
	hl.italic = true

	-- Re-apply the modified highlight group
	vim.api.nvim_set_hl(0, group_name, hl)
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Apply to standard groups
		make_italic("Comment")
		make_italic("Keyword")
		make_italic("Conditional")
		-- make_italic("Statement")
		make_italic("Type")
		make_italic("Identifier")
		make_italic("PythonAttribute")
		make_italic("Exception")
		make_italic("Function")

		-- Apply to Treesitter syntax groups
		make_italic("@function")
		make_italic("@function.method")
		make_italic("@attribute")
		make_italic("@annotation")

		-- make_italic("@keyword") -- Covers keywords like 'class', 'struct', etc.
		-- make_italic("@keyword.type") -- Covers type keywords (e.g., 'int', 'class' in some languages)
		-- make_italic("@type") -- Covers the class name/type itself (e.g., 'class MyClass')
		make_italic("@variable") -- Covers variable names
		make_italic("@variable.parameter") -- Optional: italicize function parameters too
	end,
})

-- Trigger once immediately to handle startup configurations
vim.cmd("doautocmd ColorScheme")
local builtin = require("telescope.builtin")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
require("stickybuf").setup()

buffer_searcher = function()
	builtin.buffers({
		sort_mru = true,
		ignore_current_buffer = true,
		show_all_buffers = false,
		attach_mappings = function(prompt_bufnr, map)
			local refresh_buffer_searcher = function()
				actions.close(prompt_bufnr)
				vim.schedule(buffer_searcher)
			end

			local delete_buf = function()
				local selection = action_state.get_selected_entry()
				vim.api.nvim_buf_delete(selection.bufnr, { force = true })
				refresh_buffer_searcher()
			end

			local delete_multiple_buf = function()
				local picker = action_state.get_current_picker(prompt_bufnr)
				local selection = picker:get_multi_selection()
				for _, entry in ipairs(selection) do
					vim.api.nvim_buf_delete(entry.bufnr, { force = true })
				end
				refresh_buffer_searcher()
			end

			map("n", "dd", delete_buf)
			map("n", "<C-d>", delete_multiple_buf)
			map("i", "<C-d>", delete_multiple_buf)

			return true
		end,
	})
end
-- vim.keymap.set("n", "<leader>fb", buffer_searcher, {})
vim.diagnostic.config({
	update_in_insert = false,
})
