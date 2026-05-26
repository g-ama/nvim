return function(conditions)
	local git = {
		condition = conditions.is_git_repo,

		init = function(self)
			self.status_dict = vim.b.gitsigns_status_dict
			self.has_changes = self.status_dict.added ~= 0
				or self.status_dict.removed ~= 0
				or self.status_dict.changed ~= 0
		end,

		-- hl = { fg = "orange" },
		-- hl = { fg = "white" },

		{ -- git branch name
			provider = function(self)
				return " " .. self.status_dict.head
			end,
			hl = { bold = false },
		},
		-- You could handle delimiters, icons and counts similar to Diagnostics
		{
			condition = function(self)
				return self.has_changes
			end,
			provider = "(",
			hl = { fg = "grey" },
		},
		{
			provider = function(self)
				local count = self.status_dict.added or 0
				return count > 0 and ("+" .. count)
			end,
			hl = { fg = "grey" },
		},
		{
			provider = function(self)
				local count = self.status_dict.removed or 0
				return count > 0 and ("-" .. count)
			end,
			hl = { fg = "grey" },
		},
		{
			provider = function(self)
				local count = self.status_dict.changed or 0
				return count > 0 and ("~" .. count)
			end,
			hl = { fg = "grey" },
		},
		{
			condition = function(self)
				return self.has_changes
			end,
			provider = ")",
			hl = { fg = "grey" },
		},
		{
			provider = " ",
		},
	}
	return git
end
