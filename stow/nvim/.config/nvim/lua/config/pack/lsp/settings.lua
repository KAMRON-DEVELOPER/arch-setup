local setting = {}

-- "native" = Neovim built-in vim.lsp.completion
-- "blink"  = blink.cmp
-- "none"   = no completion engine
setting.completion = "native"

-- only used when M.completion == "blink"
setting.blink = {
  luasnip = false,
  friendly_snippets = false,
}

return setting
