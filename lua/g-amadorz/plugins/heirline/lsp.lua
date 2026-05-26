return function(conditions)
	local server_name = {
		condition = conditions.lsp_attached,
		-- update = {'LspAttach', 'LspDetach'},

		provider = function()
			local names = {}
			for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
				table.insert(names, server.name)
			end
			return "[" .. table.concat(names, " ") .. "] "
		end,
		-- hl = { fg = "", bold = false },
	}

	-- local navic = {
	--     condition = require("nvim-navic").is_available,
	--     provider = require("nvim-navic").get_location,
	-- }

	local diagnostics = {

		condition = conditions.has_diagnostics,

		static = {
			-- error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text:gsub("%s+", ""),
			-- warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text:gsub("%s+", ""),
			-- info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text:gsub("%s+", ""),
			-- hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text:gsub("%s+", ""),
		},

		init = function(self)
			self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
			self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
			self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
			self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		end,

		-- update = { "LspRequest", "BufEnter" },
		{
			provider = "●",
		},
		{
			provider = "[",
		},
		{
			provider = function(self)
				if self.errors > 0 then
					return " " .. self.errors
				end
			end,
			hl = { fg = "diag_error" },
		},
		{
			provider = function(self)
				if self.warnings > 0 then
					return " " .. self.warnings
				end
			end,
			hl = { fg = "diag_warn" },
		},
		{
			provider = function(self)
				if self.info > 0 then
					return " " .. self.info
				end
			end,
			hl = { fg = "diag_info" },
		},
		{
			provider = function(self)
				if self.hints > 0 then
					return " " .. self.hints
				end
			end,
			hl = { fg = "diag_hint" },
		},
		{
			provider = " ]",
		},
	}

	return {
		server_name = server_name,
		-- navic = navic,
		diagnostics = diagnostics,
	}
end
