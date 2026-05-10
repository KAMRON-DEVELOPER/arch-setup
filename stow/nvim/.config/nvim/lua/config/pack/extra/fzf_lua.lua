vim.pack.add(
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/ibhagwan/fzf-lua"
)

local fzf = require("fzf_lua")
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
map("n", "<leader>ff", fzf.files, { desc = "Find files" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
map("n", "<leader>fw", fzf.grep_cword, { desc = "Grep word under cursor" })
map("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
map("n", "<leader>fh", fzf.helptags, { desc = "Find help" })
map("n", "<leader>fm", fzf.manpages, { desc = "Find man pages" })
map("n", "<leader>fr", fzf.resume, { desc = "Resume finder" })
map("n", "<leader>fp", fzf.builtin, { desc = "Find picker" })
map(
	"n",
	"<leader>fd",
	fzf.diagnostics_document,
	{ desc = "Document diagnostics" }
)
map(
	"n",
	"<leader>fD",
	fzf.diagnostics_workspace,
	{ desc = "Workspace diagnostics" }
)
map("n", "<leader>fq", fzf.quickfix, { desc = "Quickfix" })
