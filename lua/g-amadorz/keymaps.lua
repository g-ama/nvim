-- My Grails
vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "yy", '"+y')
vim.keymap.set("n", "P", '"+p')
-- Move Lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Zen Mode
vim.keymap.set("n", "<leader>dz", ":ZenMode <CR>", { silent = true })

vim.keymap.set("x", "Y", '"+y', { silent = true })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- vim.keymap.set("n", "<leader>tt", ": split | term <CR>", { desc = "Split into terminal window" })

vim.keymap.set("n", "<leader>tt", ":vimgrep ", { desc = "vim grep" })

vim.keymap.set("n", "<leader>ty", ":TypstPreview", { desc = "TypstPreview" })

vim.keymap.set("n", "<C-l>", ":bnext <CR>", { desc = "Move to next buf" })

vim.keymap.set("n", "<C-h>", ":bprevious <CR>", { desc = "Move to prev buf" })

vim.keymap.set("n", "<leader>vg", function()
	vim.fn.feedkeys(
		":vimgrep // **/*" .. string.rep(vim.api.nvim_replace_termcodes("<Left>", true, false, true), 6),
		"n"
	)
end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
