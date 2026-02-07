return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		disable_filetype = { "TelescopePrompt", "vim" },
	},
	config = function(_, opts)
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		npairs.setup(opts)

		-- Add custom rule for $$ in Typst and LaTeX files
		npairs.add_rules({
			Rule("$", "$", { "typst", "tex", "latex", "plaintex" }):with_pair(function(opts)
				-- Check if we're already inside a $$ pair
				local line = opts.line
				local col = opts.col
				-- Count $ before cursor
				local before = line:sub(1, col - 1)
				local count = select(2, before:gsub("%$", ""))
				-- Only pair if we have an even number of $ before cursor
				return count % 2 == 0
			end),
		})
	end,
}
