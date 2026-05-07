local ol = vim.opt_local

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lua",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "html",
    "css",
    "json",
    "yaml",
    "ruby",
  },

  callback = function()
    ol.tabstop = 2
    ol.shiftwidth = 2
    ol.softtabstop = 2
    ol.expandtab = true
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = {
--     "lua",
--     "python",
--     "rust",
--     "go",
--     "zig",
--     "dart",
--     "dockerfile",
--     "gitignore",
--     "json",
--     "yaml",
--     "toml",
--     "vim",
--   },

--   callback = function()
--     vim.treesitter.start()
--   end,
-- })
