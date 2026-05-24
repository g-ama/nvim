return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			-- use the night style
			style = "moon",
			-- disable italic for functions (fixed true -> false)
			styles = {
				functions = { italic = true },
				keywords = { italic = true },
			},
			transparent = true,
		},
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
	{ "datsfilipe/vesper.nvim" },
}
