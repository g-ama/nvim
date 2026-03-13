return {
	-- {
	-- 	"echasnovski/mini.pick",
	-- 	version = "*",
	-- 	config = function()
	-- 		local pick = require("mini.pick")
	-- 		pick.setup({
	-- 			delay = {
	-- 				async = 10,
	-- 				busy = 50,
	-- 			},
	-- 		})
	-- 		vim.keymap.set("n", "<leader>ff", pick.builtin.files, { desc = "Find files" })
	-- 		vim.keymap.set("n", "<leader>fd", pick.builtin.grep_live, { desc = "Live grep" })
	-- 		vim.keymap.set("n", "<leader>fb", pick.builtin.buffers, { desc = "Find buffers" })
	-- 		vim.keymap.set("n", "<leader>f/", function()
	-- 			pick.builtin.grep({ pattern = vim.fn.input("Grep: ") })
	-- 		end, { desc = "Grep pattern" })
	-- 	end,
	-- },
	{
		"echasnovski/mini.bracketed",
		version = "*",
		config = function()
			require("mini.bracketed").setup({
				-- Configuration for different bracket types
				buffer = { suffix = "b", options = {} },
				comment = { suffix = "c", options = {} },
				conflict = { suffix = "x", options = {} },
				diagnostic = { suffix = "d", options = {} },
				file = { suffix = "f", options = {} },
				indent = { suffix = "i", options = {} },
				jump = { suffix = "j", options = {} },
				location = { suffix = "l", options = {} },
				oldfile = { suffix = "o", options = {} },
				quickfix = { suffix = "q", options = {} },
				treesitter = { suffix = "t", options = {} },
				undo = { suffix = "u", options = {} },
				window = { suffix = "w", options = {} },
				yank = { suffix = "y", options = {} },
			})
			-- Usage: [b/]b (buffer), [c/]c (comment), [d/]d (diagnostic), etc.
		end,
	},

	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	},
	{
		"nvim-mini/mini.icons",
		version = "*",
		config = function()
			require("mini.icons").setup()
		end,
	},
	{
		"echasnovski/mini.files",
		version = "*",
		config = function()
			local files = require("mini.files")
			files.setup({
				-- Optional configuration
				windows = {
					preview = true,
					width_focus = 100,
					width_preview = 100,
				},
			})

			-- Don't call the function with (), just pass the function reference
			vim.keymap.set("n", "<leader>pv", function()
				files.open()
			end, { desc = "Open file explorer" })

			-- Or open at current file's directory
			vim.keymap.set("n", "<leader>cd", function()
				files.open(vim.api.nvim_buf_get_name(0))
			end, { desc = "Open file explorer at current file" })
		end,
	},

	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup({
				-- Module mappings
				mappings = {
					add = "sa", -- Add surrounding in Normal and Visual modes
					delete = "sd", -- Delete surrounding
					find = "sf", -- Find surrounding (to the right)
					find_left = "sF", -- Find surrounding (to the left)
					highlight = "sh", -- Highlight surrounding
					replace = "sr", -- Replace surrounding
					update_n_lines = "sn", -- Update `n_lines`
				},

				-- Number of lines within which surrounding is searched
				n_lines = 20,

				-- Duration (in ms) of highlight when calling `highlight`
				highlight_duration = 500,

				-- Pattern to match function name in function call
				funname_pattern = "[%w_%.]+",

				-- Whether to respect selection type:
				-- - Place surroundings on separate lines in linewise mode.
				-- - Place surroundings on each line in blockwise mode.
				respect_selection_type = true,
			})
		end,
	},
}
