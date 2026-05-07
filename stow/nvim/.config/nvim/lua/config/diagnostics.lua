local sev = vim.diagnostic.severity

vim.diagnostic.config({
	virtual_text = true, -- show inline diagnostics
	virtual_lines = false,

	-- virtual_lines = {
	--  current_line = true,
	-- },

	severity_sort = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = true,
	},

	signs = {
		text = {
			[sev.ERROR] = " ",
			[sev.WARN] = " ",
			[sev.INFO] = " ",
			[sev.HINT] = " ",
		},
	},
})


