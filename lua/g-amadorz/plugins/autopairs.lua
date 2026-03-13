return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		disable_filetype = { "TelescopePrompt", "vim" },
	},
	config = function(_, opts)
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds") -- Import conditions

		npairs.setup(opts)

		-- 1. Base rule: Type $ to get $$
		local dollar_rule = Rule("$", "$", { "typst", "tex", "latex", "plaintex" }):with_pair(function(opts)
			local line = opts.line
			local col = opts.col
			local before = line:sub(1, col - 1)
			local count = select(2, before:gsub("%$", ""))
			return count % 2 == 0
		end)

		-- 2. Space Expansion rule: Type <Space> inside $$ to get $  $
		local space_rule = Rule(" ", " ", { "typst", "tex", "latex", "plaintex" })
			:with_pair(function(opts)
				-- Only trigger if the cursor is exactly between two $ signs
				local pair = opts.line:sub(opts.col - 1, opts.col)
				return pair == "$$"
			end)
			:with_move(cond.none())
			:with_cr(cond.none())
			:with_del(function(opts)
				-- If you backspace inside $  $, it smoothly deletes both spaces
				local col = vim.api.nvim_win_get_cursor(0)[2]
				local context = opts.line:sub(col - 1, col + 2)
				return context == "$  $"
			end)

		npairs.add_rules({ dollar_rule, space_rule })
	end,
}
