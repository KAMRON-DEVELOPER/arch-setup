vim.pack.add(
	"https://github.com/nvim-lua/plenary.nvimm",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	}
)

require("neo-tree").setup({
	sources = {
		"filesystem",
		"buffers",
		"git_status",
		"document_symbols",
	},
	-- global, universal, none
	clipboard = { sync = "universal" },
	close_if_last_window = false,
	default_source = "filesystem",
	enable_diagnostics = true,
	enable_git_status = true,
	enable_modified_markers = true,
	-- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
	enable_opened_markers = true,
	-- Refresh the tree when a file is written.
	-- Only used if `use_libuv_file_watcher` is false.
	enable_refresh_on_write = true,
	-- If enabled neotree will keep the cursor on the first letter
	-- of the filename when moving in the tree.
	enable_cursor_hijack = false,
	popup_border_style = "",
	use_popups_for_input = true,
	use_default_mappings = true,

	source_selector = {
		winbar = false,
		statusline = false,
	},

	-- default component configs
	default_component_configs = {
		container = {
			enable_character_fade = true,
			width = "100%",
			right_padding = 0,
		},
		--diagnostics = {
		--  symbols = {
		--    hint = "H",
		--    info = "I",
		--    warn = "!",
		--    error = "X",
		--  },
		--  highlights = {
		--    hint = "DiagnosticSignHint",
		--    info = "DiagnosticSignInfo",
		--    warn = "DiagnosticSignWarn",
		--    error = "DiagnosticSignError",
		--  },
		--},

		-- indent
		indent = {
			indent_size = 2,
			padding = 0,
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			-- expander config, needed for nesting files
			-- if nil and file nesting is enabled, will enable expanders
			with_expanders = nil,
			expander_collapsed = "",
			expander_expanded = "",
		},

		-- icon
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "󰉖",
			folder_empty_open = "󰷏",
			provider = function(icon, node, state)
				if node.type == "file" or node.type == "terminal" then
					local success, web_devicons =
						pcall(require, "nvim-web-devicons")
					local name = node.type == "terminal" and "terminal"
						or node.name
					if success then
						local devicon, hl = web_devicons.get_icon(name)
						icon.text = devicon or icon.text
						icon.highlight = hl or icon.highlight
					end
				end
			end,
		},

		-- modified
		modified = { symbol = "[+]" },

		name = {
			-- Requires `enable_opened_markers = true`.
			highlight_opened_files = true,
		},

		git_status = {
			symbols = {
				-- Change type
				added = "✚",
				deleted = "✖",
				modified = "",
				renamed = "󰁕",
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
			align = "right",
		},
	},

	-- window
	window = {
		-- left, right, top, bottom, float, current
		position = "right",
		width = 40, -- applies to left and right positions
		height = 15, -- applies to top and bottom positions
		-- expand the window when file exceeds the window width. does not work with position = "float"
		auto_expand_width = false,
		popup = {
			size = {
				height = "80%",
				width = "50%",
			},
			position = "50%", -- 50% means center it
			title = function(state) -- format the text that appears at the top of a popup window
				return "Neo-tree " .. state.name:gsub("^%l", string.upper)
			end,
		},

		mappings = {
			-- ["<space>"] = "toggle_node",
			-- ["<cr>"] = "open",
			-- ["<esc>"] = "cancel",
			-- ["q"] = "close_window",
			-- ["?"] = "show_help",

			-- ["s"] = "open_vsplit",
			-- ["S"] = "open_split",
			-- ["t"] = "open_tabnew",

			-- ["a"] = "add",
			-- ["A"] = "add_directory",
			-- ["d"] = "delete",
			-- ["r"] = "rename",
			-- ["y"] = "copy_to_clipboard",
			-- ["x"] = "cut_to_clipboard",
			-- ["p"] = "paste_from_clipboard",
			-- ["R"] = "refresh",

			["t"] = { "toggle_node" },
			["<2-LeftMouse>"] = "open",
			["<cr>"] = "open",
			["<esc>"] = "cancel",
			["P"] = {
				"toggle_preview",
				config = {
					use_float = true,
					use_image_nvim = true,
					title = "Neo-tree Preview",
				},
			},
			["<C-j>"] = { "scroll_preview", config = { direction = -10 } },
			["<C-k>"] = { "scroll_preview", config = { direction = 10 } },
			["F"] = "focus_preview",
			["S"] = "open_split",
			["s"] = "open_vsplit",
			["T"] = "open_tabnew",
			["W"] = "open_with_window_picker",
			["C"] = "close_node",
			["z"] = "close_all_nodes",
			["Z"] = "expand_all_nodes",
			["R"] = "refresh",
			["a"] = {
				"add",
				config = {
					show_path = "none", -- "none", "relative", "absolute"
				},
			},
			["A"] = "add_directory",
			["d"] = "delete",
			["r"] = "rename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["<C-r>"] = "clear_clipboard",
			["c"] = "copy",
			["m"] = "move",
			["e"] = "toggle_auto_expand_width",
			["q"] = "close_window",
			["i"] = "show_file_details",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
		},
	},

	-- filesystem
	filesystem = {
		filtered_items = {
			-- when true, they will just be displayed differently than normal items
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = true,
		},

		follow_current_file = {
			-- This will find and focus the file in the active buffer every time
			enabled = false,
			-- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			leave_dirs_open = false,
		},

		-- netrw disabled, opening a directory opens neo-tree
		-- disabled, open_default
		hijack_netrw_behavior = "disabled",

		-- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
		use_libuv_file_watcher = false,

		window = {
			mappings = {
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["D"] = "fuzzy_finder_directory",
				["<C-x>"] = "clear_filter",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
				["i"] = "show_file_details",
				["b"] = "rename_basename",
				["o"] = {
					"show_help",
					nowait = false,
					config = { title = "Order by", prefix_key = "o" },
				},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["og"] = { "order_by_git_status", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
			fuzzy_finder_mappings = {
				["<down>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-j>"] = "move_cursor_down",
				["<C-k>"] = "move_cursor_up",
				["<Esc>"] = "close",
				["<S-CR>"] = "close_keep_filter",
				["<C-CR>"] = "close_clear_filter",
				["<C-w>"] = { "<C-S-w>", raw = true },
				{
					-- normal mode mappings
					n = {
						["j"] = "move_cursor_down",
						["k"] = "move_cursor_up",
						["<S-CR>"] = "close_keep_filter",
						["<C-CR>"] = "close_clear_filter",
						["<esc>"] = "close",
					},
				},
			},
		},
	},

	-- buffers
	buffers = {
		follow_current_file = {
			enabled = false,
			leave_dirs_open = false,
		},

		-- when true, empty folders will be grouped together
		group_empty_dirs = true,
		show_unloaded = true,

		window = {
			mappings = {
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["d"] = "buffer_delete",
				["bd"] = "buffer_delete",
				["i"] = "show_file_details",
				["b"] = "rename_basename",
				["o"] = {
					"show_help",
					nowait = false,
					config = { title = "Order by", prefix_key = "o" },
				},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
		},
	},

	-- git status
	git_status = {
		window = {
			position = "float",

			mappings = {
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["gU"] = "git_undo_last_commit",
				["ga"] = "git_add_file",
				["gt"] = "git_toggle_file_stage",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
				["i"] = "show_file_details",
				["b"] = "rename_basename",
				["o"] = {
					"show_help",
					nowait = false,
					config = { title = "Order by", prefix_key = "o" },
				},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
			},
		},
	},

	-- document symbols
	document_symbols = {
		follow_cursor = true,
		follow_tree_cursor = true,

		window = {
			mappings = {
				["<cr>"] = "jump_to_symbol",
				["o"] = "jump_to_symbol",
				["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
				["d"] = "noop",
				["y"] = "noop",
				["x"] = "noop",
				["p"] = "noop",
				["c"] = "noop",
				["m"] = "noop",
				["a"] = "noop",
				["/"] = "filter",
				["f"] = "filter_on_submit",
			},
		},
		custom_kinds = {
			-- define custom kinds here (also remember to add icon and hl group to kinds)
			-- ccls
			-- [252] = 'TypeAlias',
			-- [253] = 'Parameter',
			-- [254] = 'StaticMethod',
			-- [255] = 'Macro',
		},
		kinds = {
			Unknown = { icon = "?", hl = "" },
			Root = { icon = "", hl = "NeoTreeRootName" },
			File = { icon = "󰈙", hl = "Tag" },
			Module = { icon = "", hl = "Exception" },
			Namespace = { icon = "󰌗", hl = "Include" },
			Package = { icon = "󰏖", hl = "Label" },
			Class = { icon = "󰌗", hl = "Include" },
			Method = { icon = "", hl = "Function" },
			Property = { icon = "󰆧", hl = "@property" },
			Field = { icon = "", hl = "@field" },
			Constructor = { icon = "", hl = "@constructor" },
			Enum = { icon = "󰒻", hl = "@number" },
			Interface = { icon = "", hl = "Type" },
			Function = { icon = "󰊕", hl = "Function" },
			Variable = { icon = "", hl = "@variable" },
			Constant = { icon = "", hl = "Constant" },
			String = { icon = "󰀬", hl = "String" },
			Number = { icon = "󰎠", hl = "Number" },
			Boolean = { icon = "", hl = "Boolean" },
			Array = { icon = "󰅪", hl = "Type" },
			Object = { icon = "󰅩", hl = "Type" },
			Key = { icon = "󰌋", hl = "" },
			Null = { icon = "", hl = "Constant" },
			EnumMember = { icon = "", hl = "Number" },
			Struct = { icon = "󰌗", hl = "Type" },
			Event = { icon = "", hl = "Constant" },
			Operator = { icon = "󰆕", hl = "Operator" },
			TypeParameter = { icon = "󰊄", hl = "Type" },

			-- ccls
			-- TypeAlias = { icon = ' ', hl = 'Type' },
			-- Parameter = { icon = ' ', hl = '@parameter' },
			-- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
			-- Macro = { icon = ' ', hl = 'Macro' },
		},
	},
})

local function map(mode, lhs, rhs, desc, opts)
	opts = vim.tbl_extend("force", { silent = true, desc = desc }, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- filesystem
map(
	"n",
	"<leader>ee",
	"<cmd>Neotree toggle source=filesystem position=right reveal=false<cr>",
	"Explorer: Files right"
)

map(
	"n",
	"<leader>eE",
	"<cmd>Neotree toggle source=filesystem position=float reveal=false<cr>",
	"Explorer: Files float"
)

-- buffers
map(
	"n",
	"<leader>eb",
	"<cmd>Neotree toggle source=buffers position=right reveal=false<cr>",
	"Explorer: Buffers right"
)

map(
	"n",
	"<leader>eB",
	"<cmd>Neotree toggle source=buffers position=float reveal=false<cr>",
	"Explorer: Buffers float"
)

-- document symbols
map(
	"n",
	"<leader>es",
	"<cmd>Neotree toggle source=document_symbols position=right reveal=false<cr>",
	"Explorer: Symbols right"
)

map(
	"n",
	"<leader>eS",
	"<cmd>Neotree toggle source=document_symbols position=float reveal=false<cr>",
	"Explorer: Symbols float"
)

-- optional close
map("n", "<leader>ec", "<cmd>Neotree close<cr>", "Explorer: Close")
