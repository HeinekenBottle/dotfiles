-- lua/config/wezterm_sync.lua
local M = {}

local function read_palette()
  local p = vim.fn.expand("~/.cache/wezterm/current_palette.json")
  if vim.fn.filereadable(p) == 0 then return nil end
  local ok, data = pcall(vim.fn.readfile, p)
  if not ok then return nil end
  return vim.json.decode(table.concat(data, "\n"))
end

function M.apply()
  local pal = read_palette(); if not pal then return end
  -- never set bg; only fg (truecolor)
  local FG = pal.fg or "#ffffff"
  local KEY = pal.ansi and pal.ansi[5] or FG      -- e.g. blue for key hints
  local ACC = pal.ansi and pal.ansi[3] or FG      -- e.g. green for accents

  vim.api.nvim_set_hl(0, "Normal",      { fg = FG, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = FG, bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff", bg = "NONE" }) -- thin bright border
  -- Lazy/which-key/snacks (foregrounds only)
  vim.api.nvim_set_hl(0, "WhichKey",         { fg = KEY, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichKeyDesc",     { fg = ACC, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPicker",     { fg = FG,  bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder",{ fg="#ffffff", bg="NONE" })
  -- add a few safe syntax groups (no bg)
  vim.api.nvim_set_hl(0, "Identifier", { fg = pal.ansi and pal.ansi[6] or FG, bg = "NONE" }) -- cyan
  vim.api.nvim_set_hl(0, "Statement",  { fg = pal.ansi and pal.ansi[1] or FG, bg = "NONE" }) -- red
  vim.api.nvim_set_hl(0, "Type",       { fg = pal.ansi and pal.ansi[4] or FG, bg = "NONE" }) -- blue
end

return M