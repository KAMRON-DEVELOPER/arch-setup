local map = vim.keymap.set

map("n", "<leader>w", "<CMD>write<CR>", { desc = "Write buffer" })
map("n", "<leader>q", "<CMD>quit<CR>", { desc = "Quite buffer" })
map("n", "<leader>Q", "<CMD>quit!<CR>", { desc = "Force quit buffer" })

map("n", "==", "gg<S-v>G", { desc = "Select all" })

map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- copy file name and paths
map(
	"n",
	"<leader>cf",
	'<cmd>let @+ = expand("%")<CR>',
	{ desc = "Copy File Name" }
)
map(
	"n",
	"<leader>cp",
	'<cmd>let @+ = expand("%:p")<CR>',
	{ desc = "Copy File Path" }
)

-- increment/decrement numbers
map("n", "<leader>=", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- clear search highlights
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
