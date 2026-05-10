local api = vim.api

local function augroup(name)
	return api.nvim_create_augroup("kam_" .. name, { clear = true })
end

-- highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight selection on yank",
	group = augroup("highlight_yank"),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- create parent directory before saving a normal file
api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match == "" then
			return
		end

		local buftype = vim.bo[event.buf].buftype
		if buftype ~= "" then
			return
		end

		local file = vim.uv.fs_realpath(event.match) or event.match
		local dir = vim.fn.fnamemodify(file, ":p:h")

		if dir ~= "" then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

api.nvim_create_autocmd("FileType", {
	group = augroup("indent_4"),
	pattern = {
		"c",
		"cpp",
		"cs",
		"python",
		"rust",
		"zig",
		"go",
		"java",
		"php",
		"ruby",
		"swift",
		"kotlin",
		"make",
	},

	callback = function(event)
		local opt = vim.bo[event.buf]

		opt.tabstop = 4
		opt.softtabstop = 4
		opt.shiftwidth = 4
	end,
})
