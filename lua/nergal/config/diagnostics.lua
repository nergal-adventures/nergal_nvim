vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●", -- could be "■", "▎", "x"
  },
  signs = true,
  underline = true,
  update_in_insert = false, -- don't update while typing
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
  },
})

