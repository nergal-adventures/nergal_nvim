-- Diagnostic highlight groups
local diag = vim.diagnostic.severity

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff6c6b" })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = "#51afef" })
vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = "#98be65" })

-- Virtual text
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff6c6b" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#ECBE7B" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = "#51afef" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = "#98be65" })

-- Underlines (use underline instead of ugly squiggles)
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff6c6b" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "#ECBE7B" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = "#51afef" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = "#98be65" })


vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#C678DD" })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct",   { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "CmpItemKindClass",    { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword",  { fg = "#56B6C2" })


vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    require("config.lsp_colors")
  end,
})

