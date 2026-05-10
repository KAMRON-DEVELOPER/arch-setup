vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

-- package manager
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- auto installer
require("mason-tool-installer").setup({
  ensure_installed = {
    -- "lua-language-server", -- lsp (lua), mason-lspconfig (lua_ls)
    -- "stylua", -- formatter (lua)
    -- "luaformatter", -- formatter (lua)
    -- "pyright", -- lsp (python)
    -- "basedpyright", -- lsp (python)
    "mypy", -- linter (python)
    -- "ruff", -- lsp, linter, formatter (python)
    -- "pyrefly", -- lsp, linter (python)
    "isort", -- formatter (python)
    "black", -- formatter (python)
    -- "zls", -- lsp, formatter (zig)
    -- "rust-analyzer", -- lsp (rust)
    -- "rustfmt", -- formatter (rust), comes with rust
    -- "gopls",                      -- lsp (go), official go language server (pronounced "Go please")
    "gofumpt", -- formatter (go), a stricter gofmt
    "goimports", -- formatter (go), formats like gofmt and fix imports
    -- "eslint_d", -- formatter (js, ts),
    -- "typescript-language-server", -- lsp (js, ts), mason-lspconfig (ts_ls)
    -- "vtsls", -- lsp (ts)
    -- "quick-lint-js",              -- lsp (js, ts), 130x faster than ESlint
    "prettierd", -- formatter (js, ts, json, html, JSX, markdown, yaml)
    "prettier", -- formatter (js, ts, json, html, JSX, markdown, yaml)
    -- "clangd",                     -- lsp (C and C++)
    "clang-format", -- formatter (c, c++)
    -- "cmake-language-server",      -- lsp (cmake), mason-lspconfig (cmake)
    -- "neocmakelsp", -- lsp (cmake), mason-lspconfig (neocmake)
    -- "cmakelint",                  -- linter (cmake)
    -- "cmake-lint",                  -- linter (cmake)
    "gersemi", -- formatter (cmake)
    -- "dockerfile-language-server", -- lsp (docker), mason-slpconfig (dockerls)
    -- "docker-compose-language-service", -- lsp (docker compose), mason-lspconfig (docker_compose_language_service)
    -- "json-lsp", -- lsp (json), mason-slpconfig (jsonls)
    "taplo", -- lsp (toml)
    "bash-language-server", -- lsp (bash), mason-slpconfig (bashls)
    "markdownlint", -- linter, formatter(markdown),
    -- "codebook", -- lsp(spell checker)
    "sqlfmt", -- formatter(sql)
    "sqlfluff", -- linter, formatter(sql)
    "hclfmt", -- formatter(HCL)
  },
})

-- lspconfig bridge
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "stylua",
    "basedpyright",
    "ruff",
    "zls",
    "rust_analyzer",
    "gopls",
    "ts_ls",
    "clangd",
    "cmake",
    "dockerls",
    "docker_compose_language_service",
    "jsonls",
    "taplo",
    "bashls",
  },
})
