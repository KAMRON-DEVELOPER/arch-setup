local function map(mode, lhs, rhs, desc, opts)
  opts = vim.tbl_extend("force", { silent = true, desc = desc }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- half page jump
map("n", "<C-d>", "<C-d>zz", "Half page down")
map("n", "<C-u>", "<C-u>zz", "Half page up")

-- buffers
map("n", "<Tab>", ":bnext<CR>", "Buffer: next")
map("n", "<S-Tab>", ":bprevious<CR>", "Buffer: previous")

-- tabs
map("n", "<leader>to", ":tabnew<CR>", "Tab: new")
map("n", "<leader>tf", ":tabnew %<CR>", "Tab: open current buffer")
map("n", "<leader>tx", ":tabclose<CR>", "Tab: close")
map("n", "<leader>tn", ":tabn<CR>", "Tab: next")
map("n", "<leader>tp", ":tabp<CR>", "Tab: previous")

-- splits
map("n", "<leader>sv", "<C-w>v", "Split: vertical")
map("n", "<leader>sh", "<C-w>s", "Split: horizontal")
map("n", "<leader>se", "<C-w>=", "Split: equal size")
map("n", "<leader>sx", ":close<CR>", "Split: close")

-- window navigation
map("n", "<C-h>", "<C-w>h", "Window: left")
map("n", "<C-j>", "<C-w>j", "Window: down")
map("n", "<C-k>", "<C-w>k", "Window: up")
map("n", "<C-l>", "<C-w>l", "Window: right")

-- insert-mode window navigation
map("i", "<A-h>", "<C-o><C-w>h", "Window: Left")
map("i", "<A-j>", "<C-o><C-w>j", "Window: Down")
map("i", "<A-k>", "<C-o><C-w>k", "Window: Up")
map("i", "<A-l>", "<C-o><C-w>l", "Window: Right")

-- terminal-mode window navigation
map("t", "<A-h>", "<C-\\><C-n><C-w>h", "Window: left")
map("t", "<A-j>", "<C-\\><C-n><C-w>j", "Window: down")
map("t", "<A-k>", "<C-\\><C-n><C-w>k", "Window: up")
map("t", "<A-l>", "<C-\\><C-n><C-w>l", "Window: right")

-- resize
map("n", "<leader>rh", "<cmd>vertical resize -2<cr>", "Resize: narrower")
map("n", "<leader>rl", "<cmd>vertical resize +2<cr>", "Resize: wider")
map("n", "<leader>rj", "<cmd>resize +2<cr>", "Resize: taller")
map("n", "<leader>rk", "<cmd>resize -2<cr>", "Resize: shorter")

map("n", "<leader>tt", function()
  vim.cmd("split")
  vim.cmd("resize 10")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, "Terminal: open horizontal")

-- diagnostics
map(
  "n",
  "<leader>dd",
  vim.diagnostic.open_float,
  "Diagnostic: show current line"
)

map("n", "<leader>dn", function()
  vim.diagnostic.jump({ count = 1 })
end, "Diagnostic: next")

map("n", "<leader>dp", function()
  vim.diagnostic.jump({ count = -1 })
end, "Diagnostic: previous")

map("n", "<leader>df", function()
  vim.diagnostic.jump({ count = -999999 })
end, "Diagnostic: first")

map("n", "<leader>dl", function()
  vim.diagnostic.jump({ count = 999999 })
end, "Diagnostic: last")

map("n", "<leader>de", function()
  vim.diagnostic.jump({
    count = 1,
    severity = vim.diagnostic.severity.ERROR,
  })
end, "Diagnostic: next error")

map("n", "<leader>dE", function()
  vim.diagnostic.jump({
    count = -1,
    severity = vim.diagnostic.severity.ERROR,
  })
end, "Diagnostic: previous error")

map("n", "<leader>dx", function()
  vim.diagnostic.setqflist()
end, "Diagnostic: send to quickfix")

map("n", "<leader>dt", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, "Diagnostic: toggle")

map("n", "<leader>dvt", function()
  local enable = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = enable })
end, "Diagnostic: toggle virtual text")

map("n", "<leader>dvl", function()
  local enable = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = enable })
end, "Diagnostic: toggle virtual lines")

map("n", "<leader>dul", function()
  local enable = not vim.diagnostic.config().underline
  vim.diagnostic.config({ underline = enable })
end, "Diagnostic: toggle underline")

-- quickfixes
local function quickfix_toggle()
  local winid = vim.fn.getqflist({ winid = 0 }).winid

  if winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end

map("n", "<leader>xx", quickfix_toggle, "Quickfix: toggle")
map("n", "<leader>xo", "<cmd>copen<cr>", "Quickfix: open")
map("n", "<leader>xc", "<cmd>cclose<cr>", "Quickfix: close")

map("n", "<leader>xn", "<cmd>cnext<cr>", "Quickfix: next")
map("n", "<leader>xp", "<cmd>cprevious<cr>", "Quickfix: previous")

map("n", "<leader>xf", "<cmd>cfirst<cr>", "Quickfix: first")
map("n", "<leader>xl", "<cmd>clast<cr>", "Quickfix: last")

map("n", "<leader>xN", "<cmd>cnewer<cr>", "Quickfix: newer list")
map("n", "<leader>xP", "<cmd>colder<cr>", "Quickfix: older list")

map("n", "<leader>xh", "<cmd>chistory<cr>", "Quickfix: history")

local function loclist_toggle()
  local winid = vim.fn.getloclist(0, { winid = 0 }).winid

  if winid ~= 0 then
    vim.cmd.lclose()
  else
    vim.cmd.lopen()
  end
end

map("n", "<leader>ll", loclist_toggle, "Location List: toggle")
map("n", "<leader>lo", "<cmd>lopen<cr>", "Location List: open")
map("n", "<leader>lc", "<cmd>lclose<cr>", "Location List: close")

map("n", "<leader>ln", "<cmd>lnext<cr>", "location list: next")
map("n", "<leader>lp", "<cmd>lprevious<cr>", "Location List: previous")

map("n", "<leader>lf", "<cmd>lfirst<cr>", "Location List: first")
map("n", "<leader>lL", "<cmd>llast<cr>", "Location List: last")
