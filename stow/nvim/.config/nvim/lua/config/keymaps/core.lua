local keymap = vim.keymap.set

-- save and quite
keymap("n", "<leader>w", "<CMD>write<CR>", { desc = "Write buffer" })
keymap("n", "<leader>q", "<CMD>quit<CR>", { desc = "Quite buffer" })
keymap("n", "<leader>Q", "<CMD>quit!<CR>", { desc = "Force quit buffer" })

-- select all
keymap("n", "==", "gg<S-v>G", { desc = "Select all" })

keymap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- copy file name and paths
keymap("n", "<leader>cf", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy File Name" })
keymap("n", "<leader>cp", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy File Path" })

-- increment/decrement numbers
keymap("n", "<leader>=", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- toggle cmdheight between 0 and 1
keymap("n", "<leader>ch", function()
  if vim.o.cmdheight == 0 then
    vim.o.cmdheight = 1
    print("Command line: visible")
  else
    vim.o.cmdheight = 0
    print("Command line: hidden")
  end
end, { desc = "Toggle command height" })
