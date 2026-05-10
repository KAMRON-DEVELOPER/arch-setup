vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- behavior
opt.mouse = "a"
opt.swapfile = false
opt.clipboard = "unnamedplus"
opt.autocomplete = true

-- ui
require("vim._core.ui2").enable()
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.fillchars = { eob = " " }
opt.cursorline = true
opt.wrap = false

-- windows
opt.pumblend = 0
opt.pumborder = "none"
opt.winblend = 0
opt.winborder = "rounded"
opt.splitbelow = true
opt.splitright = true

-- highlight
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

-- search
opt.ignorecase = true
opt.smartcase = true

-- indentation
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.colorcolumn = "80,120"

-- scroll
opt.scrolloff = 0
opt.sidescrolloff = 0

opt.completeopt = { "menuone", "noselect", "popup", "fuzzy", "preview" }

if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.7
end
