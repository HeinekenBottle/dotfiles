local M = {}

function M.apply_float_style()
  vim.opt.termguicolors = true
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7a8390", bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatTitle",  { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatFooter", { bg = "NONE" })
end

M.apply_float_style()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function() 
    M.apply_float_style() 
  end,
})

return M