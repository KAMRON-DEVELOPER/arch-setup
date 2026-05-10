local settings = require("config.pack.lsp.settings")

local capabilities = vim.lsp.protocol.make_client_capabilities()

if settings.completion == "blink" then
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end
end

-- apply capabilities globally to all LSP servers
vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

vim.lsp.config("pyright", {
  on_init = function(client)
    local cwd = vim.fn.getcwd()
    local venv_path = cwd .. "/.venv/bin/python"

    client.config.settings = client.config.settings or {}
    client.config.settings.python = client.config.settings.python or {}

    if vim.fn.executable(venv_path) == 1 then
      client.config.settings.python.pythonPath = venv_path
    else
      client.config.settings.python.pythonPath = vim.fn.exepath("python3")
    end

    client.notify("workspace/didChangeConfiguration")
    return true
  end,
})
