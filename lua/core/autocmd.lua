-- Trouble.nvim boolean ID bug fix (CORRECTED)
-- vim.api.nvim_create_autocmd("VimEnter", {
--
-- 	callback = function()
-- 		local ok, trouble = pcall(require, "trouble")
-- 		if ok and trouble then
-- 			-- Patch the tree.build function directly
-- 			local original_build = trouble.tree.build
-- 			trouble.tree.build = function(self, ...)
-- 				local args = { ... }
-- 				-- Patch the group function inside build
-- 				local original_group = self.group
-- 				self.group = function(self2, id, ...)
-- 					local safe_id = type(id) == "boolean" and (id and "true" or "false") or tostring(id)
-- 					return original_group(self2, safe_id, ...)
-- 				end
-- 				local result = original_build(self, ...)
-- 				-- Restore original group
-- 				self.group = original_group
-- 				return result
-- 			end
-- 		end
-- 	end,

-- })
--
vim.api.nvim_create_autocmd("LspAttach", {

	group = vim.api.nvim_create_augroup("UserLspConfi", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gf", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)

		vim.keymap.set({ "n", "x" }, "<leader>ca", function()
			require("tiny-code-action").code_action()
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
