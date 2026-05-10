local map = vim.keymap.set

map(
  "n",
  "<leader>w",
  "<CMD>write<CR>",
  { silent = true, desc = "Write buffer" }
)
map("n", "<leader>q", "<CMD>quit<CR>", { silent = true, desc = "Quite buffer" })
map(
  "n",
  "<leader>Q",
  "<CMD>quit!<CR>",
  { silent = true, desc = "Force quit buffer" }
)

map("n", "==", "gg<S-v>G", { silent = true, desc = "Select all" })

map("n", "<leader>=", "<C-a>", { silent = true, desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { silent = true, desc = "Decrement number" })

map(
  "n",
  "<leader>ch",
  ":nohl<CR>",
  { silent = true, desc = "Clear search highlights" }
)

-- toggle cmdheight between 0 and 1
map("n", "<leader>cv", function()
  if vim.o.cmdheight == 0 then
    vim.o.cmdheight = 1
    print("Command line: visible")
  else
    vim.o.cmdheight = 0
    print("Command line: hidden")
  end
end, { silent = true, desc = "Toggle command height" })

-- copy file name and paths
map(
  "n",
  "<leader>cf",
  "<cmd>let @+ = expand(\"%\")<CR>",
  { silent = true, desc = "Copy File Name" }
)
map(
  "n",
  "<leader>cp",
  "<cmd>let @+ = expand(\"%:p\")<CR>",
  { silent = true, desc = "Copy File Path" }
)

vim.keymap.set("n", "<leader>cc", function()
  vim.cmd("nohlsearch")

  pcall(vim.cmd, "messages clear")

  vim.cmd("redraw!")
end, { silent = true, desc = "Clear command line" })
