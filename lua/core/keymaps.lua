vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>M", vim.cmd.Mason, { desc = "Launch Mason" })
vim.keymap.set("n", "<leader>|", function()
	vim.cmd("vsplit")
end, { desc = "Vertical split windows" })
vim.keymap.set("n", "<leader>-", function()
	vim.cmd("split")
end, { desc = "Horizontal split windows" })

-- Yank and paste

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Delete to system clipboard
vim.keymap.set({ "n", "v" }, "d", '"+d', { desc = "Delete to system clipboard" })
vim.keymap.set({ "n", "v" }, "D", '"+D', { desc = "Delete to system clipboard" })
vim.keymap.set("n", "dd", '"+dd', { desc = "Delete line to system clipboard" })

-- Paste from system clipboard
vim.keymap.set({ "n", "v" }, "p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "P", '"+P', { desc = "Paste before from system clipboard" })
vim.keymap.set("n", "x", '"+x', { desc = "Delete char to system clipboard" })
-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set({ "n", "v" }, "<leader>pe", "$p", { desc = "Paste at end of line" })
-- vim.keymap.set("n", "$p", "<leader>pe", { desc = "Paste at end of line" })
-- window resize
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set({ "n", "v" }, "bd", vim.cmd.bdelete, { desc = "Close current open buffer" })
vim.keymap.set({ "n", "v" }, "<leader> nh", function()
	vim.cmd("noh")
end)

-- text actions
vim.keymap.set("n", "<leader>D", "A<Esc>+bdw", {
	desc = "Jump to end of line, delete word backwards and copy to clipboard",
})
vim.keymap.set("n", "<leader>d", '<cmd>normal! A<Esc>"+bdw<cr>', {
	desc = "Jump to end of line, delete word backwards ",
})

vim.keymap.set("n", "<leader>rt", function()
	vim.cmd("restart")
end)

-- shortcut to open the config directory

vim.keymap.set("n", "<leader>OC", function()
	local nvim_path = vim.fn.expand("~/.config/nvim")
	vim.cmd("Oil " .. nvim_path)
end, { desc = "Open configuration directory" })

vim.keymap.set("n", "<leader>aT", function()
	vim.cmd("TodoTelescope")
end, { desc = "show all todos in your project" })

-- window management
vim.keymap.set("n", "<leader>NT", function()
	vim.cmd("tabnew")
end, { desc = "Open new tab" })

vim.keymap.set("n", "<leader>fw", function()
	vim.cmd("MicroscopePeek")
end, { desc = "Open in floating window" })

vim.keymap.set("n", "<leader>bd", function()
	vim.cmd("BDelete this")
end, { desc = "Close buffer" })

vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all buffers except current" })

-- chainsaw
--
vim.keymap.set("n", "<leader>cp", function()
	vim.cmd("Chainsaw variableLog")
end, { desc = "Open chainsaw variable log" })
