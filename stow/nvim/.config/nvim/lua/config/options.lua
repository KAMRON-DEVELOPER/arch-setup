vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.mouse = "a" -- default since v0.8+


opt.fillchars = { eob = " " } -- remove ~ at the end of buffer

opt.autocomplete = true       -- default false

-- enable 24-bit colors
opt.termguicolors = true

-- transparency and border style of popup-menu windows
opt.pumblend = 30         -- default 0
opt.pumborder = "rounded" -- default ""

-- transparency and border style of floating windows
opt.winblend = 100        -- default 0
opt.winborder = "rounded" -- default ""

-- highlight group
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1a1b26" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

opt.signcolumn = "yes"

-- highlight current line
opt.cursorline = true

opt.number = true
opt.relativenumber = true

opt.swapfile = false
opt.wrap = false

-- system clipboard
-- neovim requires a clipboard provider to communicate with OS.
-- you can check if your provider is working by running :checkhealth provider
opt.clipboard = "unnamedplus"

-- enable ignorecase + smartcase for better searching
-- makes all searches case-insensitive and
-- case-sensitive when search pattern contains at least one uppercase letter.
opt.ignorecase = true
opt.smartcase = true

-- tabstop        How wide \t looks on screen (display only)
-- softtabstop    How far Tab/Backspace jumps in insert mode
-- shiftwidth     How wide >> / auto-indent levels are
-- expandtab      Whether Tab key inserts \t or spaces
-- smarttab       Tab at line start uses shiftwidth instead of softtabstop
-- autoindent     New line copies current line's indent
-- smartindent    New line adjusts indent based on { } syntax
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true

opt.splitbelow = true
opt.splitright = true

opt.wrap = false
opt.scrolloff = 0
opt.sidescrolloff = 0

if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.7
end
