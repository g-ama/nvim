return {
	"rebelot/heirline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		local status_ok, heirline = pcall(require, "heirline")
		if not status_ok then
			return
		end

		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")

		local function setup_colors()
			return {
				bright_bg = utils.get_highlight("Folded").bg,
				red = utils.get_highlight("DiagnosticError").fg,
				gray = utils.get_highlight("NonText").fg,
				lightblack = utils.get_highlight("Cursorline").bg,
				string = utils.get_highlight("String").fg,
				orange = utils.get_highlight("Keyword").fg,
				purple = utils.get_highlight("Constant").fg,
				blue = utils.get_highlight("Function").fg,
				white = utils.get_highlight("StatusLine").fg,
				black = utils.get_highlight("Statusline").bg,

				diag_warn = utils.get_highlight("DiagnosticWarn").fg,
				diag_error = utils.get_highlight("DiagnosticError").fg,
				diag_hint = utils.get_highlight("DiagnosticHint").fg,
				diag_info = utils.get_highlight("DiagnosticInfo").fg,
				git_del = utils.get_highlight("diffDelete").fg,
				git_add = utils.get_highlight("diffAdd").fg,
				git_change = utils.get_highlight("diffChange").fg,
			}
		end

		heirline.load_colors(setup_colors())

		local mode = require("g-amadorz.plugins.heirline.mode")
		local file = require("g-amadorz.plugins.heirline.file")(utils)
		local git = require("g-amadorz.plugins.heirline.git")(conditions)
		local lsp = require("g-amadorz.plugins.heirline.lsp")(conditions)

		local align = { provider = "%=" }
		local space = { provider = " " }

		file.meta = utils.surround({ "(", ")" }, nil, file.meta)

		git = { flexible = 3, git, { provider = "" } }
		lsp.server_name = { flexible = 4, lsp.server_name, { provider = "" } }
		file.meta = { flexible = 5, file.meta, { provider = "" } }
		file.ruler = { flexible = 7, file.ruler, { provider = "" } }
		mode = { flexible = 8, mode, { provider = "" } }

		local default_statusline = {
			condition = function()
				return conditions.is_active()
			end,

			mode,
			space,
			file.name_block,
			space,
			space,
			lsp.diagnostics,
			lsp.server_name --[[ lsp.navic, (waiting for winbar) ]],
			align,
			file.ruler,
			space,
			space,
			git,
			file.meta,
			space,
		}

		local inactive_statusline = {
			condition = function()
				return not conditions.is_active()
			end,

			mode,
			space,
			file.name_block,
			space,
			space,
			lsp.diagnostics,
			lsp.server_name --[[ lsp.navic, (waiting for winbar) ]],
			align,
			file.ruler,
			space,
			space,
			git,
			file.meta,
			space,
		}

		local file_explorer_statusline = {
			condition = function()
				return conditions.buffer_matches({
					filetype = { "NvimTree", "neo%-tree" },
				})
			end,

			hl = utils.get_highlight("Normal").bg,
			{ provider = " Files %=" },
		}

		local empty_statusline = {
			condition = function()
				return conditions.buffer_matches({
					buftype = { "nofile" },
				})
			end,
			{ provider = "" },
		}

		local terminal_statusline = {
			condition = function()
				return conditions.buffer_matches({
					buftype = { "terminal" },
				})
			end,
			{ provider = "" },
		}

		local statuslines

		if vim.opt.laststatus == 3 then
			statuslines = {
				hl = "StatusLine",
				fallthrough = false,
				default_statusline,
			}
		else
			statuslines = {
				hl = function()
					if conditions.is_active() then
						return "StatusLine"
					else
						return "StatusLineNC"
					end
				end,

				fallthrough = false,

				file_explorer_statusline,
				terminal_statusline,
				empty_statusline,
				default_statusline,
				inactive_statusline,
			}
		end

		heirline.setup({ statusline = statuslines })

		local group = vim.api.nvim_create_augroup("Heirline", { clear = true })
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				require("heirline").reset_highlights()
				require("heirline").load_colors(setup_colors())
			end,
			group = group,
		})
	end,
}
