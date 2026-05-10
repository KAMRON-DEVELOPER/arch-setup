local sev = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  underline = false,

  severity_sort = true,
  update_in_insert = false,

  float = {
    border = "rounded",
    source = true,
  },

  -- signs = {
  -- 	severity = {
  -- 		min = vim.diagnostic.severity.HINT,
  -- 	},
  -- },

  signs = {
    text = {
      [sev.ERROR] = " ",
      [sev.WARN] = " ",
      [sev.INFO] = " ",
      [sev.HINT] = "󰌵 ",
      -- [sev.HINT] = " ",
    },
  },
})
