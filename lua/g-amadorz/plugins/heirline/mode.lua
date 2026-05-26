return {
	-- get vim current mode, this information will be required by the provider
	-- and the highlight functions, so we compute it only once per component
	-- evaluation and store it as a component attribute
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()

		-- execute this only once, this is required if you want the ViMode
		-- component to be updated on operator pending mode
		if not self.once then
			vim.api.nvim_create_autocmd("ModeChanged", { command = "redrawstatus" })
			self.once = true
		end
	end,
	-- Now we define some dictionaries to map the output of mode() to the
	-- corresponding string and color. We can put these into `static` to compute
	-- them at initialisation time.
	static = {
		mode_names = { -- change the strings if you like it vvvvverbose!
			n = "NOR",
			no = "NOR",
			nov = "NOr",
			noV = "NOv",
			["no\22"] = "NO?",
			niI = "NOi",
			niR = "Nir",
			niV = "Niv",
			nt = "NOt",
			v = "VIS",
			vs = "VIs",
			V = "VIl",
			Vs = "Vls",
			["\22"] = "VIb",
			["\22s"] = "VIb",
			s = "SEL",
			S = "SEl",
			["\19"] = "SEb",
			i = "INS",
			ic = "Ic",
			ix = "Ix",
			R = "REP",
			Rc = "REc",
			Rx = "REx",
			Rv = "REv",
			Rvc = "Rvc",
			Rvx = "Rvx",
			c = "CMD",
			cv = "Ex ",
			r = "...",
			rm = "M ",
			["r?"] = "? ",
			["!"] = "! ",
			t = "TER",
		},
		mode_colors = {
			n = "grey",
			i = "blue",
			v = "orange",
			V = "orange",
			["\22"] = "orange",
			c = "string",
			s = "purple",
			S = "purple",
			["\19"] = "purple",
			R = "blue",
			r = "blue",
			["!"] = "red",
			t = "red",
		},
	},
	-- We can now access the value of mode() that, by now, would have been
	-- computed by `init()` and use it to index our strings dictionary.
	-- note how `static` fields become just regular attributes once the
	-- component is instantiated.
	-- To be extra meticulous, we can also add some vim statusline syntax to
	-- control the padding and make sure our string is always at least 2
	-- characters long. Plus a nice Icon.
	provider = function(self)
		return " %2(" .. self.mode_names[self.mode] .. "%) "
		-- return " "
	end,
	-- Same goes for the highlight. Now the foreground will change according to the current mode.
	-- hl = function(self)
	--     local mode = self.mode:sub(1, 1) -- get only the first mode character
	--     -- return { bg = self.mode_colors[mode], fg = "black", bold = false, }
	--     return { bg = "black", bold = false }
	-- end,
	-- Re-evaluate the component only on ModeChanged event!
	-- This is not required in any way, but it's there, and it's a small
	-- performance improvement.
	update = "ModeChanged",
}
