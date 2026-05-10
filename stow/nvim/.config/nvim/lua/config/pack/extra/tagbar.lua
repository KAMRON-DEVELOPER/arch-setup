vim.pack.add("preservim/tagbar")

vim.keymap.set(
	"n",
	"<Leader>tt",
	":TagbarToggle<CR>",
	{ desc = "Toggle Tagbar" }
)
