return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter").setup({
			-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
			install_dir = vim.fn.stdpath("data") .. "/site",
			require("nvim-treesitter").install({ "rust", "c", "cpp", "python", "zig" }):wait(300000),

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "go" },
				callback = function()
					vim.treesitter.start()
				end,
			}),

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "rust" },
				callback = function()
					vim.treesitter.start()
				end,
			}),

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "python" },
				callback = function()
					vim.treesitter.start()
				end,
			}),

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "c" },
				callback = function()
					vim.treesitter.start()
				end,
			}),

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "cpp" },
				callback = function()
					vim.treesitter.start()
				end,
			}),
		})
	end,
}
