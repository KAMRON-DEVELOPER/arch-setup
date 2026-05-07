local keymap = vim.keymap.set

-- half page jump
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- buffer
keymap("n", "<Tab>", ":bnext<CR>", { silent = true, desc = "Next buffer" })
keymap("n", "<S-Tab>", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })

-- tab
keymap("n", "<leader>to", ":tabnew<CR>", { silent = true, desc = "Open new tab" })
keymap("n", "<leader>tf", ":tabnew %<CR>", { silent = true, desc = "Open current buffer in new tab" })
keymap("n", "<leader>tx", ":tabclose<CR>", { silent = true, desc = "Close current tab" })
keymap("n", "<leader>tn", ":tabn<CR>", { silent = true, desc = "Go to next tab" })
keymap("n", "<leader>tp", ":tabp<CR>", { silent = true, desc = "Go to previous tab" })

-- window
-- split
keymap("n", "<leader>sv", "<C-w>v", { silent = true, desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { silent = true, desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { silent = true, desc = "Make splits equal size" })
keymap("n", "<leader>sx", ":close<CR>", { silent = true, desc = "Close current split" })

-- resize
keymap("n", "<C-S-Down>", ":resize +2<CR>", { silent = true, desc = "Resize horizontal split Down" })
keymap("n", "<C-S-Up>", ":resize -2<CR>", { silent = true, desc = "Resize horizontal split Up" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Resize vertical split Down" })
keymap("n", "<C-Right>", ":vertical resize +2CR>", { silent = true, desc = "Resize vertical split Up" })

--
keymap("n", "<c-k>", ":wincmd k<CR>", { silent = true, desc = "Navigate to up pane" })
keymap("n", "<c-j>", ":wincmd j<CR>", { silent = true, desc = "Navigate to down pane" })
keymap("n", "<c-h>", ":wincmd h<CR>", { silent = true, desc = "Navigate to left pane" })
keymap("n", "<c-l>", ":wincmd l<CR>", { silent = true, desc = "Navigate to right pane" })

-- normal mode
keymap("n", "<A-h>", "<C-w>h", { silent = true, desc = "Move to left window" })
keymap("n", "<A-j>", "<C-w>j", { silent = true, desc = "Move to lower window" })
keymap("n", "<A-k>", "<C-w>k", { silent = true, desc = "Move to upper window" })
keymap("n", "<A-l>", "<C-w>l", { silent = true, desc = "Move to right window" })

-- insert mode
keymap("i", "<A-h>", "<C-o><C-w>h", { silent = true, desc = "Move to left window" })
keymap("i", "<A-j>", "<C-o><C-w>j", { silent = true, desc = "Move to lower window" })
keymap("i", "<A-k>", "<C-o><C-w>k", { silent = true, desc = "Move to upper window" })
keymap("i", "<A-l>", "<C-o><C-w>l", { silent = true, desc = "Move to right window" })

-- terminal mode
keymap("t", "<A-h>", "<C-\\><C-n><C-w>h", { silent = true, desc = "Move to left window" })
keymap("t", "<A-j>", "<C-\\><C-n><C-w>j", { silent = true, desc = "Move to lower window" })
keymap("t", "<A-k>", "<C-\\><C-n><C-w>k", { silent = true, desc = "Move to upper window" })
keymap("t", "<A-l>", "<C-\\><C-n><C-w>l", { silent = true, desc = "Move to right window" })

-- open terminal
vim.keymap.set("n", "<S-t>", function()
  vim.cmd("split")
  vim.cmd("resize 10")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { noremap = true, silent = true })
