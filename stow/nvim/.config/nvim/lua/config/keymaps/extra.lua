local map = vim.keymap.set

-- toggle cmdheight between 0 and 1
map("n", "<leader>ch", function()
  if vim.o.cmdheight == 0 then
    vim.o.cmdheight = 1
    print("Command line: visible")
  else
    vim.o.cmdheight = 0
    print("Command line: hidden")
  end
end, { desc = "Toggle command height" })
