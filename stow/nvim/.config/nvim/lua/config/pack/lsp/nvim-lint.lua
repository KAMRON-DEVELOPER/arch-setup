vim.pack.add({ { src = "https://github.com/mfussenegger/nvim-lint" } })

local lint = require("lint")

lint.linters_by_ft = {
  python = { "ruff" }, -- ruff, flake8, mypy, pylint, pyrefly
  -- cmake = { "cmakelint" },
  -- cmake = { "cmake_lint" },
  -- javascript = { "eslint_d" },
  -- typescript = { "eslint_d" },
  -- javascriptreact = { "eslint_d" },
  -- typescriptreact = { "eslint_d" },
  -- bash = { "bash" },
  markdown = { "markdownlint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})
