vim.pack.add({ "https://github.com/preservim/tagbar" })

vim.keymap.set(
	"n",
	"<Leader>tbt",
	":TagbarToggle<CR>",
	{ desc = "Tagbar: toggle" }
)
