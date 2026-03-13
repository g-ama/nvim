vim.opt.mouse = ""
vim.opt.tabstop = 4
-- vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor"
vim.opt.cursorcolumn = false
vim.opt.cursorline = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.ignorecase = true
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.foldopen = "mark,percent,quickfix,search,tag,undo"
vim.opt.sidescrolloff = 50
vim.cmd.colorscheme("moonfly")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.expandtab = true
	end,
})

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
	strategy = {
		[""] = "rainbow-delimiters.strategy.global",
		vim = "rainbow-delimiters.strategy.local",
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	priority = {
		[""] = 210,
		lua = 210,
		c = 210,
		cpp = 210,
		rust = 210,
		typst = 210,
		go = 210,
	},
	highlight = {
		"RainbowDelimiterRed",
		"RainbowDelimiterYellow",
		"RainbowDelimiterBlue",
		"RainbowDelimiterOrange",
		"RainbowDelimiterGreen",
		"RainbowDelimiterViolet",
		"RainbowDelimiterCyan",
	},
}

-- Code Forces Template
vim.keymap.set("n", "<leader>cf", function()
	local template = {
		'#include "iostream"',
		"#include <vector>",
		"using ll = long long;",
		"using namespace std;",
		"void solve() {}",
		"int main() {",
		"  int t;",
		"  cin >> t;",
		"  while (t--) {",
		"    solve();",
		"  }",
		"}",
	}

	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, template)

	-- Move cursor to inside the solve() function
	vim.api.nvim_win_set_cursor(0, { row + 2, 14 })
end, { desc = "Insert C++ competitive programming template" })
