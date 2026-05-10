local map = vim.keymap.set

map("n", "<leader>w", "<CMD>write<CR>", { desc = "Write buffer" })
map("n", "<leader>q", "<CMD>quit<CR>", { desc = "Quite buffer" })
map("n", "<leader>Q", "<CMD>quit!<CR>", { desc = "Force quit buffer" })

map("n", "==", "gg<S-v>G", { desc = "Select all" })

map("n", "<leader>=", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

map("n", "<leader>ch", ":nohl<CR>", { desc = "Clear search highlights" })

-- toggle cmdheight between 0 and 1
map("n", "<leader>cv", function()
  if vim.o.cmdheight == 0 then
    vim.o.cmdheight = 1
    print("Command line: visible")
  else
    vim.o.cmdheight = 0
    print("Command line: hidden")
  end
end, { desc = "Toggle command height" })

-- copy file name and paths
map(
  "n",
  "<leader>cf",
  "<cmd>let @+ = expand(\"%\")<CR>",
  { desc = "Copy File Name" }
)
map(
  "n",
  "<leader>cp",
  "<cmd>let @+ = expand(\"%:p\")<CR>",
  { desc = "Copy File Path" }
)
