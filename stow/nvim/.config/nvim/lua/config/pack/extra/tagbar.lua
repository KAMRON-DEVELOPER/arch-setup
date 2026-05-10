vim.pack.add("https://github.com/preservim/tagbar")

vim.keymap.set(
	"n",
	"<Leader>tt",
	":TagbarToggle<CR>",
	{ desc = "Toggle Tagbar" }
)
