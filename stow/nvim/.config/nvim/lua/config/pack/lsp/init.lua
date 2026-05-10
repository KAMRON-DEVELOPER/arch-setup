require("config.pack.lsp.mason")

local settings = require("config.pack.lsp.settings")

if settings.completion == "blink" then
	require("config.pack.lsp.blink")
end

require("config.pack.lsp.servers")
require("config.pack.lsp.attach")
require("config.pack.lsp.conform")
require("config.pack.lsp.nvim-lint")
