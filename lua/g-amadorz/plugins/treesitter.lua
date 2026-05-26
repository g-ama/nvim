return {
	"nvim-treesitter/nvim-treesitter",
	-- The new docs strictly state: "This plugin does not support lazy-loading."
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- 1. Setup the plugin (can be left empty for defaults)
		require("nvim-treesitter").setup()

		-- 2. The old `ensure_installed` array is gone.
		-- You now use the `.install()` function to list what you need.
		require("nvim-treesitter").install({
			"c",
			"lua",
			"vim",
			"vimdoc",
			"cpp",
			"rust",
			"go",
			"python",
		})
	end,
}
