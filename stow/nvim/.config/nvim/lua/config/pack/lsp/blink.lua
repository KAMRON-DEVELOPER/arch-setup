local api = vim.api
local settings = require("config.pack.lsp.settings")

vim.api.nvim_create_autocmd("PackChanged", {
	group = api.nvim_create_augroup("pack_build_blink", { clear = true }),
	callback = function(ev)
		local spec = ev.data and ev.data.spec
		local name = spec and spec.name
		local kind = ev.data and ev.data.kind

		if name ~= "blink.cmp" then
			return
		end

		if kind ~= "install" and kind ~= "update" then
			return
		end

		local ok, blink = pcall(require, "blink.cmp")
		if not ok then
			vim.notify(
				"blink.cmp installed. Restart Neovim, then run :BlinkBuild if needed",
				vim.log.levels.WARN
			)
			return
		end

		local result = blink.build():wait(60000)

		if result.code == 0 then
			vim.notify("blink.cmp built successfully", vim.log.levels.INFO)
		else
			vim.notify("blink.cmp build failed", vim.log.levels.ERROR)
		end
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	group = api.nvim_create_augroup("pack_build_luasnip", { clear = true }),
	callback = function(ev)
		local spec = ev.data and ev.data.spec
		local name = spec and spec.name
		local kind = ev.data and ev.data.kind
		if name ~= "LuaSnip" then
			return
		end

		if kind ~= "install" and kind ~= "update" then
			return
		end

		local result = vim.system({ "make", "install_jsregexp" }, {
			cwd = ev.data.path,
			text = true,
		}):wait()

		if result.code == 0 then
			vim.notify(
				"LuaSnip jsregexp built successfully",
				vim.log.levels.INFO
			)
		else
			vim.notify(
				"LuaSnip jsregexp build failed:\n" .. (result.stderr or ""),
				vim.log.levels.ERROR
			)
		end
	end,
})

local plugins = {
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
}

if settings.blink.luasnip then
	table.insert(plugins, { src = "https://github.com/L3MON4D3/LuaSnip" })
end

if settings.blink.friendly_snippets then
	table.insert(
		plugins,
		{ src = "https://github.com/rafamadriz/friendly-snippets" }
	)
end

vim.pack.add(plugins)

local blink = require("blink.cmp")

vim.api.nvim_create_user_command("BlinkBuild", function()
	local result = blink.build():wait(60000)

	if result.code == 0 then
		vim.notify("blink.cmp built successfully", vim.log.levels.INFO)
	else
		vim.notify("blink.cmp build failed", vim.log.levels.ERROR)
	end
end, {})

blink.setup({
	-- default, super-tab, enter, none
	-- All presets have the following mappings:
	-- C-space: Open menu or open docs if already open
	-- C-n/C-p or Up/Down: Select next/previous item
	-- C-e: Hide menu
	-- C-k: Toggle signature help (if signature.enabled = true)
	keymap = {
		preset = "default",
	},

	completion = {
		list = {
			max_items = 200,
			-- When `true`, will automatically select the first item in the completion list
			preselect = false,
			-- When `true`, inserts the completion item automatically when selecting it
			auto_insert = true,
		},

		menu = { auto_show = true },

		documentation = { auto_show = true, auto_show_delay_ms = 500 },

		-- Displays a preview of the selected item on the current line
		ghost_text = { enabled = false, show_with_menu = true },
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			snippets = {
				opts = {
					friendly_snippets = settings.blink.friendly_snippets,
				},
			},
		},
	},

	snippets = settings.blink.luasnip and "luasnip" or "default",

	-- Experimental signature help support
	signature = {
		enabled = false,
		-- Show the signature help automatically
		trigger = { enabled = true },
	},

	appearance = {
		highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
		-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
		kind_icons = {
			Text = "󰉿",
			Method = "󰊕",
			Function = "󰊕",
			Constructor = "󰒓",

			Field = "󰜢",
			Variable = "󰆦",
			Property = "󰖷",

			Class = "󱡠",
			Interface = "󱡠",
			Struct = "󱡠",
			Module = "󰅩",

			Unit = "󰪚",
			Value = "󰦨",
			Enum = "󰦨",
			EnumMember = "󰦨",

			Keyword = "󰻾",
			Constant = "󰏿",

			Snippet = "󱄽",
			Color = "󰏘",
			File = "󰈔",
			Reference = "󰬲",
			Folder = "󰉋",
			Event = "󱐋",
			Operator = "󰪚",
			TypeParameter = "󰬛",
		},
	},
})

if settings.blink.luasnip then
	local ok, luasnip = pcall(require, "luasnip")

	if ok then
		luasnip.config.setup({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			delete_check_events = "TextChanged",
		})

		require("luasnip.loaders.from_vscode").lazy_load()

		local map = vim.keymap.set

		map({ "i", "s" }, "<C-k>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { silent = true, desc = "Expand or jump snippet" })

		map({ "i", "s" }, "<C-j>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { silent = true, desc = "Jump back snippet" })

		map({ "i", "s" }, "<C-e>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end, { silent = true, desc = "Change snippet choice" })
	end
end
