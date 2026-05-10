vim.pack.add({
	{ "https://github.com/nvim-mini/mini.icons" },
	{ "https://github.com/nvim-tree/nvim-web-devicons" },
	{ "https://github.com/stevearc/oil.nvim" },
})

require("oil").setup({
	default_file_explorer = false,

	win_options = {
		signcolumn = "yes",
		cursorcolumn = false,
	},

	delete_to_trash = true,
	watch_for_changes = true,

	keymaps = {
		["g?"] = { "actions.show_help", mode = "n" },
		["<CR>"] = "actions.select",
		["<C-s>"] = { "actions.select", opts = { vertical = true } },
		["<C-h>"] = { "actions.select", opts = { horizontal = true } },
		["<C-t>"] = { "actions.select", opts = { tab = true } },
		["<C-p>"] = "actions.preview",
		["<C-c>"] = { "actions.close", mode = "n" },
		["<C-l>"] = "actions.refresh",
		["-"] = { "actions.parent", mode = "n" },
		["_"] = { "actions.open_cwd", mode = "n" },
		["`"] = { "actions.cd", mode = "n" },
		["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
		["gs"] = { "actions.change_sort", mode = "n" },
		["gx"] = "actions.open_external",
		["H"] = { "actions.toggle_hidden", mode = "n" },
		["g\\"] = { "actions.toggle_trash", mode = "n" },
	},

	use_default_keymaps = true,

	view_options = {
		show_hidden = false,
	},

	float = {
		padding = 2,
		max_width = 0,
		max_height = 0,
		win_options = {
			winblend = 0,
		},
		-- preview_split: Split direction: "auto", "left", "right", "above", "below".
		preview_split = "auto",

		override = function(conf)
			return conf
		end,
	},
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
