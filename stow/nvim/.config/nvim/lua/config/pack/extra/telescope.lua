vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind

		if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
			vim.system({ "make" }, { cwd = ev.data.path }):wait()
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
})

local telescope = require("telescope")
telescope.setup()
-- telescope.load_extension("fzf")
-- telescope.load_extension("aerial")
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "aerial")

local builtin = require("telescope.builtin")
local map = vim.keymap.set

function FindClasses()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Class" },
		prompt_title = "Find Classes",
	})
end

function FindFunctions()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Function", "Method" },
		prompt_title = "Find Functions",
	})
end

function FindVariables()
	builtin.lsp_dynamic_workspace_symbols({
		symbols = { "Variable", "Constant" },
		prompt_title = "Find Variables",
	})
end

map("n", "<leader>fi", builtin.builtin, { desc = "Builtin" })
map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fs", builtin.grep_string, { desc = "Grep string" })
map("n", "<leader>fq", builtin.quickfix, { desc = "Quickfix" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>fr", builtin.resume, { desc = "Resume" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>fm", builtin.man_pages, { desc = "Man pages" })

map("n", "<leader>fcc", FindClasses, { desc = "Find classes" })
map("n", "<leader>fcf", FindFunctions, { desc = "Find functions" })
map("n", "<leader>fcv", FindVariables, { desc = "Find variables" })
