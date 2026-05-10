vim.pack.add({
  { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
})

require("tree-sitter-manager").setup({
  ensure_installed = {
    "zsh",
    "bash",
    "c",
    "lua",
    "python",
    "rust",
    "zig",
    "go",
    "typescript",
    "tsx",
    "javascript",
    "dart",
    "dockerfile",
    "gitignore",
    "json",
    "yaml",
    "toml",
    "html",
    "css",
  },
  auto_install = true,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
  callback = function(event)
    local filetype = vim.bo[event.buf].filetype
    local lang = vim.treesitter.language.get_lang(filetype)

    if not lang then
      return
    end

    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(event.buf, lang)
    end
  end,
})
