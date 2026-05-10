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

local function map(mode, lhs, rhs, desc, opts)
	opts = vim.tbl_extend("force", { desc = desc }, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- main picker menu
map("n", "<leader>fp", fzf.builtin, "Find picker")

-- files / buffers
map("n", "<leader>ff", fzf.files, "Find files")
map("n", "<leader>fF", fzf.oldfiles, "Find old files")
map("n", "<leader>fb", fzf.buffers, "Find buffers")
map("n", "<leader>fl", fzf.lines, "Find lines in open buffers")
map("n", "<leader>fL", fzf.blines, "Find lines in current buffer")
map("n", "<leader>ft", fzf.tabs, "Find tabs")

-- search / grep
map("n", "<leader>fg", fzf.live_grep, "Live grep")
map("n", "<leader>fG", fzf.grep, "Grep")
map("n", "<leader>fw", fzf.grep_cword, "Grep word under cursor")
map("n", "<leader>fW", fzf.grep_cWORD, "Grep WORD under cursor")
map("v", "<leader>fw", fzf.grep_visual, "Grep visual selection")
map("n", "<leader>fr", fzf.resume, "Resume picker")

-- help / commands / Neovim stuff
map("n", "<leader>fh", fzf.helptags, "Find help")
map("n", "<leader>fm", fzf.manpages, "Find man pages")
map("n", "<leader>fc", fzf.commands, "Find commands")
map("n", "<leader>f:", fzf.command_history, "Find command history")
map("n", "<leader>f/", fzf.search_history, "Find search history")
map("n", "<leader>fk", fzf.keymaps, "Find keymaps")
map("n", "<leader>fH", fzf.highlights, "Find highlights")
map("n", "<leader>fC", fzf.colorschemes, "Find colorschemes")

-- diagnostics / quickfix / location list
map("n", "<leader>fd", fzf.diagnostics_document, "Document diagnostics")
map("n", "<leader>fD", fzf.diagnostics_workspace, "Workspace diagnostics")
map("n", "<leader>fq", fzf.quickfix, "Find quickfix")
map("n", "<leader>fQ", fzf.quickfix_stack, "Find quickfix history")
map("n", "<leader>fo", fzf.loclist, "Find location list")
map("n", "<leader>fO", fzf.loclist_stack, "Find location list history")

-- LSP
map("n", "<leader>fs", fzf.lsp_document_symbols, "Document symbols")
map("n", "<leader>fS", fzf.lsp_workspace_symbols, "Workspace symbols")
map("n", "<leader>fR", fzf.lsp_references, "LSP references")
map("n", "<leader>fI", fzf.lsp_implementations, "LSP implementations")
map("n", "<leader>fT", fzf.lsp_typedefs, "LSP type definitions")
map("n", "<leader>fa", fzf.lsp_code_actions, "LSP code actions")

-- git
map("n", "<leader>gc", fzf.git_commits, "Git commits")
map("n", "<leader>gC", fzf.git_bcommits, "Git buffer commits")
map("n", "<leader>gb", fzf.git_branches, "Git branches")
map("n", "<leader>gs", fzf.git_status, "Git status")
map("n", "<leader>gS", fzf.git_stash, "Git stash")
