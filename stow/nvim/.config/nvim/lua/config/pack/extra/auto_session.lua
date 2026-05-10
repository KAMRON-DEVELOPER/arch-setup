vim.pack.add({ { "https://github.com/rmagatti/auto-session" } })

require("lua.config.pack.extra.auto_session").setup({
	enabled = true,
	auto_save = false,
	auto_restore = false,
	auto_create = false,
	auto_restore_last_session = false,
	cwd_change_handling = true,
	single_session_mode = false,

	git_use_branch_name = true,
	git_auto_restore_on_branch_change = true,

	allowed_dirs = { "~/coding/**" },
	bypass_save_filetypes = { "alpha" },

	session_lens = {
		-- "telescope" | "snacks" | "fzf" | "select" | nil
		-- falls back to vim.ui.select
		picker = nil,

		-- only used for telescope.
		-- registers the telescope extension at startup so you can use :Telescope session-lens
		load_on_setup = true,

		mappings = {
			delete_session = { { "i", "n" }, "<C-d>" },
			alternate_session = { { "i", "n" }, "<C-s>" },
			copy_session = { { "i", "n" }, "<C-y>" },
		},
	},

	post_cwd_changed_cmds = {
		function()
			local ok, lualine = pcall(require, "lualine")
			if ok then
				lualine.refresh()
			end
		end,
	},
})

vim.o.sessionoptions =
	"blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.keymap.set(
	"n",
	"<leader>ass",
	"<cmd>AutoSession search<CR>",
	{ desc = "Session search" }
)
vim.keymap.set(
	"n",
	"<leader>ast",
	"<cmd>AutoSession toggle<CR>",
	{ desc = "Toggle autosave" }
)
vim.keymap.set(
	"n",
	"<leader>asw",
	"<cmd>AutoSession save<CR>",
	{ desc = "Save Session" }
)
vim.keymap.set(
	"n",
	"<leader>asr",
	"<cmd>AutoSession restore<CR>",
	{ desc = "Restore session for cwd" }
)
