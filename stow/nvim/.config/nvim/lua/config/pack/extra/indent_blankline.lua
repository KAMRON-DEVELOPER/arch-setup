vim.pack.add({
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
})

require("ibl").setup({ enabled = false })

local map = vim.keymap.set

map("n", "<leader>ui", "<cmd>IBLToggle<cr>", {
  silent = true,
  desc = "Toggle indent guides",
})

map("n", "<leader>uI", "<cmd>IBLToggleScope<cr>", {
  silent = true,
  desc = "Toggle indent scope",
})
