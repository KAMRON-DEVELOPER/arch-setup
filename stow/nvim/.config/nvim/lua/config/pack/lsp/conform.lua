vim.pack.add({ src = "https://github.com/stevearc/conform.nvim" })

local prettier = { "prettier", "prettierd", stop_after_first = true }

local fos = { lsp_fallback = true, async = false, timeout_ms = 3000 }

local function format(bufnr)
  local ok, conform = pcall(require, "conform")
  if ok then
    conform.format(
      vim.tbl_extend("force", fos, bufnr and { bufnr = bufnr } or {})
    )
  end
end

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black", lsp_format = "fallback" },
    rust = { "rustfmt", lsp_format = "fallback", stop_after_first = true },
    zig = { "zigfmt", lsp_format = "fallback" },
    go = {
      "goimports",
      "gofmt",
      "gofumpt",
      lsp_format = "fallback",
      stop_after_first = true,
    },
    dart = { "dart_format" },
    c = { "clangformat" },
    cpp = { "clangformat" },
    cmake = { "gersemi" },
    javascript = prettier,
    typescript = prettier,
    javascriptreact = prettier,
    typescriptreact = prettier,
    yaml = prettier,
    toml = { "taplo" },
    json = prettier,
    html = prettier,
    css = prettier,
    markdown = prettier,
    dockerfile = { "dockerfmt" },
    hcl = { "hcl" },
  },

  -- format_on_save = fos,

  notify_on_error = true,
  notify_no_formatters = true,
})

vim.keymap.set({ "i", "n", "v" }, "<C-A-f>", function(args)
  format(args.buf)
end, { desc = "Conform: format" })

-- format on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = format,
-- })
