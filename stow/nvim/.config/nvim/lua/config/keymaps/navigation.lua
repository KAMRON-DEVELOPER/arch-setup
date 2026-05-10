local map = vim.keymap.set

-- half page jump
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- buffer
map("n", "<Tab>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
map(
	"n",
	"<S-Tab>",
	":bprevious<CR>",
	{ silent = true, desc = "Previous buffer" }
)

-- tab
map("n", "<leader>to", ":tabnew<CR>", { silent = true, desc = "Open new tab" })
map(
	"n",
	"<leader>tf",
	":tabnew %<CR>",
	{ silent = true, desc = "Open current buffer in new tab" }
)
map(
	"n",
	"<leader>tx",
	":tabclose<CR>",
	{ silent = true, desc = "Close current tab" }
)
map("n", "<leader>tn", ":tabn<CR>", { silent = true, desc = "Go to next tab" })
map(
	"n",
	"<leader>tp",
	":tabp<CR>",
	{ silent = true, desc = "Go to previous tab" }
)

-- split
map("n", "<leader>sv", "<C-w>v", { silent = true, desc = "Split vertically" })
map("n", "<leader>sh", "<C-w>s", { silent = true, desc = "Split horizontally" })
map(
	"n",
	"<leader>se",
	"<C-w>=",
	{ silent = true, desc = "Make splits equal size" }
)
map(
	"n",
	"<leader>sx",
	":close<CR>",
	{ silent = true, desc = "Close current split" }
)

-- resize with arros
map(
	"n",
	"<C-S-Left>",
	":vertical resize -2<CR>",
	{ silent = true, desc = "Decrease window width" }
)
map(
	"n",
	"<C-S-Right>",
	":vertical resize +<2CR>",
	{ silent = true, desc = "Increase window width" }
)
map(
	"n",
	"<C-S-Down>",
	":resize +2<CR>",
	{ silent = true, desc = "Decrease window height" }
)
map(
	"n",
	"<C-S-Up>",
	":resize -2<CR>",
	{ silent = true, desc = "Increase window height" }
)

-- resize with h/j/k/l
map(
	"n",
	"<C-S-h>",
	":vertical resize -2<CR>",
	{ silent = true, desc = "Resize vertical split Down" }
)
map(
	"n",
	"<C-S-l>",
	":vertical resize +2CR>",
	{ silent = true, desc = "Resize vertical split Up" }
)
map(
	"n",
	"<C-S-j>",
	":resize +2<CR>",
	{ silent = true, desc = "Resize horizontal split Down" }
)
map(
	"n",
	"<C-S-k>",
	":resize -2<CR>",
	{ silent = true, desc = "Resize horizontal split Up" }
)

-- move with h/j/k/l
map("n", "<A-h>", "<C-w>h", { silent = true, desc = "Move to left window" })
map("n", "<A-j>", "<C-w>j", { silent = true, desc = "Move to lower window" })
map("n", "<A-k>", "<C-w>k", { silent = true, desc = "Move to upper window" })
map("n", "<A-l>", "<C-w>l", { silent = true, desc = "Move to right window" })

-- navigate with arrows
map(
	"n",
	"<c-Left>",
	":wincmd h<CR>",
	{ silent = true, desc = "Navigate to left pane" }
)
map(
	"n",
	"<c-Down>",
	":wincmd j<CR>",
	{ silent = true, desc = "Navigate to down pane" }
)
map(
	"n",
	"<c-Up>",
	":wincmd k<CR>",
	{ silent = true, desc = "Navigate to up pane" }
)
map(
	"n",
	"<c-Right>",
	":wincmd l<CR>",
	{ silent = true, desc = "Navigate to right pane" }
)

-- navigate with h/j/k/l
map(
	"n",
	"<c-h>",
	":wincmd h<CR>",
	{ silent = true, desc = "Navigate to left pane" }
)
map(
	"n",
	"<c-j>",
	":wincmd j<CR>",
	{ silent = true, desc = "Navigate to below pane" }
)
map(
	"n",
	"<c-k>",
	":wincmd k<CR>",
	{ silent = true, desc = "Navigate to above pane" }
)
map(
	"n",
	"<c-l>",
	":wincmd l<CR>",
	{ silent = true, desc = "Navigate to right pane" }
)

-- terminal
-- insert mode
map(
	"i",
	"<A-h>",
	"<C-o><C-w>h",
	{ silent = true, desc = "Move to left window" }
)
map(
	"i",
	"<A-j>",
	"<C-o><C-w>j",
	{ silent = true, desc = "Move to lower window" }
)
map(
	"i",
	"<A-k>",
	"<C-o><C-w>k",
	{ silent = true, desc = "Move to upper window" }
)
map(
	"i",
	"<A-l>",
	"<C-o><C-w>l",
	{ silent = true, desc = "Move to right window" }
)

-- terminal mode
map(
	"t",
	"<A-h>",
	"<C-\\><C-n><C-w>h",
	{ silent = true, desc = "Move to left window" }
)
map(
	"t",
	"<A-j>",
	"<C-\\><C-n><C-w>j",
	{ silent = true, desc = "Move to lower window" }
)
map(
	"t",
	"<A-k>",
	"<C-\\><C-n><C-w>k",
	{ silent = true, desc = "Move to upper window" }
)
map(
	"t",
	"<A-l>",
	"<C-\\><C-n><C-w>l",
	{ silent = true, desc = "Move to right window" }
)

-- open terminal
vim.keymap.set("n", "<S-t>", function()
	vim.cmd("split")
	vim.cmd("resize 10")
	vim.cmd("terminal")
	vim.cmd("startinsert")
end, { noremap = true, silent = true })

-- diagnostics
map(
	"n",
	"<leader>dd",
	vim.diagnostic.open_float,
	{ desc = "Diagnostic: Show Current Line" }
)

map("n", "<leader>dn", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Diagnostic: Next" })

map("n", "<leader>dp", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Diagnostic: Previous" })

map("n", "<leader>df", function()
	vim.diagnostic.jump({ count = -999999 })
end, { desc = "Diagnostic: First" })

map("n", "<leader>dl", function()
	vim.diagnostic.jump({ count = 999999 })
end, { desc = "Diagnostic: Last" })

map("n", "<leader>de", function()
	vim.diagnostic.jump({
		count = 1,
		severity = vim.diagnostic.severity.ERROR,
	})
end, { desc = "Diagnostic: Next Error" })

map("n", "<leader>dE", function()
	vim.diagnostic.jump({
		count = -1,
		severity = vim.diagnostic.severity.ERROR,
	})
end, { desc = "Diagnostic: Previous Error" })

map("n", "<leader>dx", function()
	vim.diagnostic.setqflist()
end, { desc = "Diagnostic: Send to Quickfix" })

map("n", "<leader>dt", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Diagnostic: Toggle" })

vim.keymap.set("n", "<leader>dvt", function()
	local enable = not vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = enable })
end, { desc = "Toggle diagnostic virtual_text" })

vim.keymap.set("n", "<leader>dvl", function()
	local enable = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = enable })
end, { desc = "Toggle diagnostic virtual_lines" })

vim.keymap.set("n", "<leader>dvu", function()
	local enable = not vim.diagnostic.config().underline
	vim.diagnostic.config({ underline = enable })
end, { desc = "Toggle diagnostic underline" })

-- quickfixes
local function quickfix_toggle()
	local winid = vim.fn.getqflist({ winid = 0 }).winid

	if winid ~= 0 then
		vim.cmd.cclose()
	else
		vim.cmd.copen()
	end
end

map("n", "<leader>xx", quickfix_toggle, { desc = "Quickfix: Toggle" })
map("n", "<leader>xo", "<cmd>copen<cr>", { desc = "Quickfix: Open" })
map("n", "<leader>xc", "<cmd>cclose<cr>", { desc = "Quickfix: Close" })

map("n", "<leader>xn", "<cmd>cnext<cr>", { desc = "Quickfix: Next" })
map("n", "<leader>xp", "<cmd>cprevious<cr>", { desc = "Quickfix: Previous" })

map("n", "<leader>xf", "<cmd>cfirst<cr>", { desc = "Quickfix: First" })
map("n", "<leader>xl", "<cmd>clast<cr>", { desc = "Quickfix: Last" })

map("n", "<leader>xN", "<cmd>cnewer<cr>", { desc = "Quickfix: Newer List" })
map("n", "<leader>xP", "<cmd>colder<cr>", { desc = "Quickfix: Older List" })

map("n", "<leader>xh", "<cmd>chistory<cr>", { desc = "Quickfix: History" })

local function loclist_toggle()
	local winid = vim.fn.getloclist(0, { winid = 0 }).winid

	if winid ~= 0 then
		vim.cmd.lclose()
	else
		vim.cmd.lopen()
	end
end

map("n", "<leader>ll", loclist_toggle, { desc = "Location List: Toggle" })
map("n", "<leader>lo", "<cmd>lopen<cr>", { desc = "Location List: Open" })
map("n", "<leader>lc", "<cmd>lclose<cr>", { desc = "Location List: Close" })

map("n", "<leader>ln", "<cmd>lnext<cr>", { desc = "Location List: Next" })
map(
	"n",
	"<leader>lp",
	"<cmd>lprevious<cr>",
	{ desc = "Location List: Previous" }
)

map("n", "<leader>lf", "<cmd>lfirst<cr>", { desc = "Location List: First" })
map("n", "<leader>lL", "<cmd>llast<cr>", { desc = "Location List: Last" })
