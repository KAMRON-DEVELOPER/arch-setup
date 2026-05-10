local settings = require("config.pack.lsp.settings")

local api = vim.api

vim.api.nvim_create_autocmd("LspAttach", {
  group = api.nvim_create_augroup("lsp_attach", { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if not client then
      return
    end

    local function supports(method)
      return client:supports_method(method, bufnr)
    end

  local function map(mode, lhs, rhs, desc, opts)
    opts = opts or {}

    vim.keymap.set(
      mode,
      lhs,
      rhs,
      vim.tbl_extend("force", {
        buffer = bufnr,
        silent = true,
        desc = desc,
      }, opts)
    )
  end

    -- native completion
    if
      settings.completion == "native" and supports("textDocument/completion")
    then
    local chars = {}
    for i = 32, 126 do
      table.insert(chars, string.char(i))
    end

    client.server_capabilities.completionProvider.triggerCharacters = chars

    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

    -- manual trigger
    map("i", "<C-Space>", function()
      vim.lsp.completion.get()
    end, "LSP: trigger completion")
    map("i", "<C-@>", function()
      vim.lsp.completion.get()
    end, "LSP: trigger completion")

    -- completion menu navigation
    map("i", "<C-j>", function()
      return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
    end, "Completion: Next")

    map("i", "<C-k>", function()
      return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
    end, "Completion: Previous")

    map("i", "<CR>", function()
      return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
    end, "Completion: Accept")

    map("i", "<C-e>", function()
      return vim.fn.pumvisible() == 1 and "<C-e>" or "<C-e>"
    end, "Completion: Cancel")
    end

    if supports("textDocument/codeAction") then
      map({ "n", "v" }, "<C-.>", vim.lsp.buf.code_action, "LSP: Code Action")
    end

    if supports("textDocument/hover") then
      map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
    end

    if supports("textDocument/rename") then
      map("n", "<F2>", vim.lsp.buf.rename, "LSP: Rename")
    end

    if supports("textDocument/formatting") then
      map({ "i", "n", "v" }, "<C-f>", function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, "LSP: Format Buffer")
    end

    if supports("textDocument/definition") then
      map("n", "gd", vim.lsp.buf.definition, "LSP: Definition")
    end

    if supports("textDocument/declaration") then
      map("n", "gD", vim.lsp.buf.declaration, "LSP: Declaration")
    end

    if supports("textDocument/references") then
      map("n", "gr", vim.lsp.buf.references, "LSP: References")
    end

    if supports("textDocument/implementation") then
      map("n", "gi", vim.lsp.buf.implementation, "LPS: Implementation")
    end

    if supports("textDocument/typeDefinition") then
      map("n", "gt", vim.lsp.buf.type_definition, "LSP: Type Definition")
    end

    if supports("textDocument/inlayHint") then
      map("n", "<leader>hh", function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
          { bufnr = bufnr }
        )
      end, "LSP: Toggle Inlay Hints")
    end

    -- -- auto format
    -- if not supports("textDocument/willSaveWaitUntil")
    --     and supports("textDocument/formatting") then
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = api.nvim_create_augroup("lsp_attach", { clear = false }),
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
    --     end,

    --   })
    -- end
  end,
})
