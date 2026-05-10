vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

local fzf = require("fzf-lua")
fzf.setup({
	winopts = {
		preview = {
			default = "bat",
		},
	},

	files = {
		previewer = "bat",
	},
})

local map = vim.keymap.set
map("n", "<leader>zp", fzf.builtin, { desc = "FzF: Find Builtin Pickers" })
map("n", "<leader>zb", fzf.buffers, { desc = "FzF: Find Buffers" })
map("n", "<leader>zf", fzf.files, { desc = "FzF: Find Files" })
map("n", "<leader>zc", fzf.grep_cword, { desc = "FzF: Grep Current Word" })
map("n", "<leader>fg", fzf.live_grep, { desc = "FzF: Live Grep" })
map("n", "<leader>zr", fzf.resume, { desc = "FzF: Find Resume" })
map("n", "<leader>zh", fzf.helptags, { desc = "FzF: Find Help Tags" })
map("n", "<leader>sm", fzf.manpages, { desc = "FzF: Find Man Pages" })

require("which-key").setup({
	spec = {
		{
			"<leader>zf",
			group = "FzF: Find",
			icon = { icon = "", color = "green" },
		},
	},
})
