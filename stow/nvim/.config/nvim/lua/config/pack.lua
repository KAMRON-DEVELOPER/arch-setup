-- vim.pack.add({
--   { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
-- })

-- require("tree-sitter-manager").setup({
--   ensure_installed = {
--     "zsh",
--     "bash",
--     "c",
--     "lua",
--     "python",
--     "rust",
--     "zig",
--     "go",
--     "typescript",
--     "tsx",
--     "javascript",
--     "dart",
--     "dockerfile",
--     "gitignore",
--     "json",
--     "yaml",
--     "toml",
--     "html",
--     "css",
--   },
--   auto_install = true,
-- })

-- vim.lsp.config('lua_ls', {
--   settings = {
--     Lua = {
--       runtime = { version = 'LuaJIT' },
--       diagnostics = {
--         globals = { 'vim' },
--       },
--       workspace = {
--         checkThirdParty = false,
--         library = {
--           vim.env.VIMRUNTIME,
--         },
--       },
--       telemetry = { enable = false },
--     },
--   },
-- })

-- Enable one or more servers
-- vim.lsp.enable('lua_ls')
-- vim.lsp.enable({ 'gopls', 'jsonls' })


-- New (0.12 native)
-- vim.lsp.config["lua_ls"] = {
-- 	cmd = { "lua-language-server" },
-- 	filetypes = { "lua" },
-- 	root_markers = { ".luarc.json", ".git" },
-- 	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
-- }
-- vim.lsp.enable("lua_ls")

-- vim.cmd.colorscheme("gruvbox-material")
-- require("nvim-treesitter.install").update("all")
-- require("nvim-treesitter.configs").setup({
-- 	auto_install = true,
-- })

-- -- INFO: completion engine
-- vim.pack.add({ "https://github.com/saghen/blink.cmp" }, { confirm = false })

-- require("blink.cmp").setup({
-- 	completion = {
-- 		documentation = {
-- 			auto_show = true,
-- 		},
-- 	},

-- 	-- default blink keymaps
-- 	keymap = {
-- 		["<C-p>"] = { "select_prev", "fallback_to_mappings" },
-- 		["<C-n>"] = { "select_next", "fallback_to_mappings" },

-- 		["<C-y>"] = { "select_and_accept", "fallback" },
-- 		["<C-e>"] = { "cancel", "fallback" },
-- 		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

-- 		["<Tab>"] = { "snippet_forward", "fallback" },
-- 		["<S-Tab>"] = { "snippet_backward", "fallback" },

-- 		["<C-b>"] = { "scroll_documentation_up", "fallback" },
-- 		["<C-f>"] = { "scroll_documentation_down", "fallback" },

-- 		["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
-- 	},

-- 	fuzzy = {
-- 		implementation = "lua",
-- 	},
-- })

-- vim.pack.add({
-- 	"https://github.com/neovim/nvim-lspconfig", -- default configs for lsps

-- 	-- NOTE: if you'd rather install the lsps through your OS package manager you
-- 	-- can delete the next three mason-related lines and their setup calls below.
-- 	-- see `:h lsp-quickstart` for more details.
-- 	"https://github.com/mason-org/mason.nvim", -- package manager
-- 	"https://github.com/mason-org/mason-lspconfig.nvim", -- lspconfig bridge
-- 	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", -- auto installer
-- }, { confirm = false })

-- require("mason").setup()
-- require("mason-lspconfig").setup()
-- require("mason-tool-installer").setup({
-- 	ensure_installed = vim.tbl_keys(lsp_servers),
-- })

-- -- INFO: fuzzy finder
-- vim.pack.add({
-- 	"https://github.com/nvim-lua/plenary.nvim", -- library dependency
-- 	"https://github.com/nvim-tree/nvim-web-devicons", -- icons (nerd font)
-- 	"https://github.com/nvim-telescope/telescope.nvim", -- the fuzzy finder
-- }, { confirm = false })

-- require("telescope").setup({})

-- local pickers = require("telescope.builtin")

-- vim.keymap.set("n", "<leader>sp", pickers.builtin, { desc = "[S]earch Builtin [P]ickers" })
-- vim.keymap.set("n", "<leader>sb", pickers.buffers, { desc = "[S]earch [B]uffers" })
-- vim.keymap.set("n", "<leader>sf", pickers.find_files, { desc = "[S]earch [F]iles" })
-- vim.keymap.set("n", "<leader>sw", pickers.grep_string, { desc = "[S]earch Current [W]ord" })
-- vim.keymap.set("n", "<leader>sg", pickers.live_grep, { desc = "[S]earch by [G]rep" })
-- vim.keymap.set("n", "<leader>sr", pickers.resume, { desc = "[S]earch [R]esume" })

-- vim.keymap.set("n", "<leader>sh", pickers.help_tags, { desc = "[S]earch [H]elp" })
-- vim.keymap.set("n", "<leader>sm", pickers.man_pages, { desc = "[S]earch [M]anuals" })

-- -- INFO: keybinding helper
-- vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { confirm = false })

-- require("which-key").setup({
-- 	spec = {
-- 		{ "<leader>s", group = "[S]earch", icon = { icon = "", color = "green" } },
-- 	},
-- })

-- uncomment to enable automatic plugin updates
-- vim.pack.update()
