return function(utils)
	local name_block = {
		-- let's first set up some attributes needed by this component and it's children
		init = function(self)
			self.filename = vim.api.nvim_buf_get_name(0)
		end,
	}
	-- We can now define some children separately and add them later

	local icon = {
		init = function(self)
			local filename = self.filename
			local extension = vim.fn.fnamemodify(filename, ":e")
			self.icon, self.icon_color =
				require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
		end,
		provider = function(self)
			return self.icon and (self.icon .. " ")
		end,
		hl = function(self)
			return { fg = self.icon_color }
		end,
	}

	local name = {
		init = function(self)
			self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
			if self.lfilename == "" then
				self.lfilename = "[No Name]"
			end
		end,
		hl = { fg = "white" },

		{
			flexible = 6,
			{
				provider = function(self)
					return self.lfilename
				end,
			},
			{
				provider = function(self)
					return vim.fn.pathshorten(self.lfilename)
				end,
			},
		},
	}

	local flags = {
		{
			provider = function()
				if vim.bo.modified then
					return " [+]"
				end
			end,
			-- provider = function() if vim.bo.modified then return "  " end end,
			-- hl = { fg = "orange" }
		},
		{
			provider = function()
				if (not vim.bo.modifiable) or vim.bo.readonly then
					return "[-]"
				end
			end,
			-- provider = function() if (not vim.bo.modifiable) or vim.bo.readonly then return "  " end end,
			hl = { fg = "red" },
		},
	}

	-- Now, let's say that we want the filename color to change if the buffer is
	-- modified. Of course, we could do that directly using the FileName.hl field,
	-- but we'll see how easy it is to alter existing components using a "modifier"
	-- component

	local name_modifier = {
		hl = function()
			if vim.bo.modified then
				-- use `force` because we need to override the child's hl foreground
				-- return { fg = "orange", bold = false, force=true }
				return { fg = "white", force = true }
			end
		end,
	}

	-- let's add the children to our FileNameBlock component
	name_block = utils.insert(
		name_block,
		icon,
		utils.insert(name_modifier, name), -- a new table where FileName is a child of FileNameModifier
		unpack(flags), -- A small optimisation, since their parent does nothing
		{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
	)

	local type = {
		provider = function()
			return string.upper(vim.bo.filetype)
		end,
		hl = { fg = utils.get_highlight("Type").fg, bold = true },
	}

	local size = {
		provider = function()
			-- stackoverflow, compute human readable file size
			local suffix = { "b", "k", "M", "G", "T", "P", "E" }
			local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
			fsize = (fsize < 0 and 0) or fsize
			if fsize < 1024 then
				return fsize .. suffix[1]
			end
			local i = math.floor((math.log(fsize) / math.log(1024)))
			return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
		end,
	}

	local last_modified = {
		-- did you know? Vim is full of functions!
		provider = function()
			local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
			return (ftime > 0) and os.date("%c", ftime)
		end,
	}

	local ruler = {
		-- %l = current line number
		-- %L = number of lines in the buffer
		-- %c = column number
		-- %P = percentage through file of displayed window
		-- provider = "%10(%2cc %P %3Ll%)",
		provider = "%5(%l:%c%)",
	}

	local meta = {
		{
			provider = "%Ll ",
		},
		size,
	}

	return {
		name_block = name_block,
		type = type,
		size = size,
		last_modified = last_modified,
		ruler = ruler,
		meta = meta,
	}
end
