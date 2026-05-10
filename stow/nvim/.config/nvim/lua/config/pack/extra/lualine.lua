vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
})

-- Lualine has sections as shown below.
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+

local lualine = require("lualine")

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		-- theme = "iceberg_dark",
		-- theme = "codedark",
		-- theme = "base16",
		-- theme = "tokyonight",
		-- theme = "gruvbox_dark",
		-- theme = "jellybeans",
		-- theme = "dracula",
		-- theme = "ayu_mirage",
		-- theme = "horizon",
		-- theme = "nord",
		-- theme = "onedark",
		-- theme = "wombat",

		-- component_separators = { left = '', right = '' }, -- beetween
		-- section_separators = { left = "", right = "" }, -- inside
		-- component_separators = { left = "", right = "" }, -- beetween
		-- section_separators = { left = "", right = "" }, -- inside
	},
	always_divide_middle = true,
	always_show_tabline = true,
	sections = {
		lualine_a = {
			"mode",
			-- { "mode", separator = { left = "", right = "" }, right_padding = 2 },
		},
		lualine_b = { "branch" },
		lualine_c = {},
		lualine_x = { "diagnostics", "filesize" },
		lualine_y = { "filename" },
		lualine_z = {
			"location",
			-- { "location", separator = { left = "", right = "" }, left_padding = 2 },
		},
	},
	-- inactive_sections = {
	-- 	lualine_a = { "mode" },
	-- 	lualine_b = { "branch" },
	-- 	lualine_c = {},
	-- 	lualine_x = { "diagnostics", "filesize" },
	-- 	lualine_y = { "filename" },
	-- 	lualine_z = { "location" },
	-- },
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
