return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
	},

	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				preview = { treesitter = true },
				color_devicons = true,
				sorting_strategy = "ascending",
				borderchars = {
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
				},
				path_displays = { "smart" },
				layout_config = {
					height = 100,
					width = 400,
					prompt_position = "top",
					preview_cutoff = 40,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		telescope.load_extension("ui-select")
		telescope.load_extension("fzf")

		-- Transparent Background Highlight Groups
		local hl = vim.api.nvim_set_hl
		hl(0, "TelescopeNormal", { bg = "none" })
		hl(0, "TelescopeBorder", { bg = "none" })
		hl(0, "TelescopePromptNormal", { bg = "none" })
		hl(0, "TelescopePromptBorder", { bg = "none" })
		hl(0, "TelescopeResultsNormal", { bg = "none" })
		hl(0, "TelescopeResultsBorder", { bg = "none" })
		hl(0, "TelescopePreviewNormal", { bg = "none" })
		hl(0, "TelescopePreviewBorder", { bg = "none" })

		-- Keymaps
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Telescope recent files" })
		vim.keymap.set("n", "<leader>fc", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end, { desc = "Telescope grep word under cursor" })

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				local hl = vim.api.nvim_set_hl
				hl(0, "TelescopeNormal", { bg = "none" })
				hl(0, "TelescopeBorder", { bg = "none" })
				-- ... (rest of the highlight groups)
			end,
		})
	end,
}
