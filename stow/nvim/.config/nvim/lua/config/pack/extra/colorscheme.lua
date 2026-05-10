vim.pack.add({
	{ "https://github.com/navarasu/onedark.nvim" },
	{ "https://github.com/ellisonleao/gruvbox.nvim" },
	{ "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{
		src = "https://github.com/rose-pine/neovim",
		name = "rose-pine",
	},
	{ "https://github.com/vague-theme/vague.nvim" },
})

-- dark, darker, cool, deep, warm, warmer, light
require("onedark").setup({
	style = "dark",
	transparent = false,
	lualine = { transparent = false },
	code_style = {
		comments = "italic",
		keywords = "none",
		functions = "none",
		strings = "none",
		variables = "none",
	},
})
-- require("onedark").load()

require("gruvbox").setup({
	dim_inactive = false,
	transparent_mode = false,
	italic = {
		strings = false,
		emphasis = false,
		comments = true,
		operators = false,
		folds = false,
	},
})
-- vim.cmd.colorscheme("gruvbox")

-- moon, storm, night, day
require("tokyonight").setup({
	style = "storm",
	transparent = false,
	dim_inactive = true,
	lualine_bold = false,
	styles = {
		comments = { italic = true },
		keywords = {},
		functions = {},
		variables = {},
		-- dark, transparent, normal
		sidebars = "dark",
		floats = "dark",
	},
})
-- vim.cmd.colorscheme("tokyonight")

-- latte, frappe, macchiato, mocha
require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = false,
	show_end_of_buffer = false,
	no_italic = false,
	no_bold = false,
	float = {
		transparent = false,
		solid = false,
	},
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	lsp_styles = {
		virtual_text = {
			errors = { "italic" },
			hints = { "italic" },
			warnings = { "italic" },
			information = { "italic" },
			ok = { "italic" },
		},
		inlay_hints = {
			background = true,
		},
	},
})
-- vim.cmd.colorscheme("catppuccin-nvim")

-- main, moon, dawn
require("rose-pine").setup({
	variant = "auto", -- auto, main, moon, or dawn
	dark_variant = "main", -- main, moon, or dawn
	dim_inactive_windows = false,
	extend_background_behind_borders = true,
	styles = {
		bold = true,
		italic = true,
		transparency = false,
	},
})
-- vim.cmd.colorscheme("rose-pine")

require("vague").setup({
	transparent = false,
	bold = false, -- Disable bold globally
	italic = false, -- Disable italic globally
})
-- vim.cmd.colorscheme("vague")
