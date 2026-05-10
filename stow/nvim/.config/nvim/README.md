# Neovim

this is a minimal neovim configuration.

* [Documentation](https://neovim.io/doc/)
* [User documentation](https://neovim.io/doc/user/)

## Setup

> [!NOTE]
> Neovim 0.12 (released March 29) ships built-in treesitter support,
> a native plugin manager, and native LSP completion.
>
> Neovim 0.12 ships built-in parsers for common languages (:checkhealth vim.treesitter).
> Highlighting works without any plugin.

```bash
sudo pacman -S tree-sitter-cli
```

## Why `nvim-lspconfig` Is Here

Neovim has a built-in LSP client. But the client only knows how to *talk*
to language servers — it does not know anything about any specific server:
not what command to run, not which filetypes should trigger it, not where
to look for the project root. That information has to come from somewhere.

`nvim-lspconfig` is that somewhere. It ships a collection of `lsp/*.lua`
files — one per server — each returning a table like this:

```lua
-- nvim-lspconfig's lsp/rust_analyzer.lua (simplified)
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
}
```

Since Neovim 0.11, the runtimepath is scanned for `lsp/` directories.
When you call `vim.lsp.config("rust_analyzer", { capabilities = ... })`,
Neovim finds nvim-lspconfig's `lsp/rust_analyzer.lua` through the
runtimepath and deep-merges your call on top of it. Your override wins,
but the base — `cmd`, `filetypes`, `root_markers` — comes from the plugin.

Without nvim-lspconfig installed, `vim.lsp.config("rust_analyzer", {...})`
runs without error but the server never starts. There is no `cmd` to
execute, no filetypes to watch, nothing for `mason-lspconfig` to enable.

This is also why you never `require("lspconfig")` in the current config.
The old API (`lspconfig.rust_analyzer.setup({})`) is now deprecated.
The plugin's job today is purely to be a data source — a bundle of
community-maintained `lsp/*.lua` files that Neovim picks up automatically
from the runtimepath.

## Default Keymaps

### LSP

"gra" (Normal and Visual mode) is mapped to vim.lsp.buf.code_action()
"gri" is mapped to vim.lsp.buf.implementation()
"grn" is mapped to vim.lsp.buf.rename()
"grr" is mapped to vim.lsp.buf.references()
"grt" is mapped to vim.lsp.buf.type_definition()
"grx" is mapped to vim.lsp.codelens.run()
"gO" is mapped to vim.lsp.buf.document_symbol()
CTRL-S (Insert mode) is mapped to vim.lsp.buf.signature_help()
v_an and v_in fall back to LSP vim.lsp.buf.selection_range() if treesitter is not active.
gx handles textDocument/documentLink. Example: with gopls, invoking gx on "os" in this Go code will open documentation externally:

### diagnostic

`]d` jumps to the next diagnostic in the buffer.
`[d` jumps to the previous diagnostic in the buffer.
`]D` jumps to the last diagnostic in the buffer.
`[D` jumps to the first diagnostic in the buffer.
`<C-w>d` shows diagnostic at cursor in a floating window.
