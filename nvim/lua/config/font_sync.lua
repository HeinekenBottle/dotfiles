local M = {}

M.palette_file = vim.fn.expand("~/.cache/wezterm/current_font_palette.json")
M.last_mtime = 0

local function read_font_palette()
  if vim.fn.filereadable(M.palette_file) == 0 then 
    return nil 
  end
  
  local ok, data = pcall(vim.fn.readfile, M.palette_file)
  if not ok then 
    return nil 
  end
  
  local decode_ok, palette = pcall(vim.json.decode, table.concat(data, "\n"))
  if not decode_ok then
    return nil
  end
  
  return palette
end

function M.apply()
  local pal = read_font_palette()
  if not pal then 
    return false
  end
  
  local FG = pal.fg or "#ffffff"
  local BOLD_FG = pal.bold_fg or FG
  local CURSOR = pal.cursor or "#ffffff"
  
  local BLACK = pal.ansi and pal.ansi[1] or "#000000"
  local RED = pal.ansi and pal.ansi[2] or "#ff0000"
  local GREEN = pal.ansi and pal.ansi[3] or "#00ff00"
  local YELLOW = pal.ansi and pal.ansi[4] or "#ffff00"
  local BLUE = pal.ansi and pal.ansi[5] or "#0000ff"
  local MAGENTA = pal.ansi and pal.ansi[6] or "#ff00ff"
  local CYAN = pal.ansi and pal.ansi[7] or "#00ffff"
  local WHITE = pal.ansi and pal.ansi[8] or "#ffffff"
  
  local BRIGHT_BLACK = pal.brights and pal.brights[1] or "#808080"
  local BRIGHT_RED = pal.brights and pal.brights[2] or "#ff8080"
  local BRIGHT_GREEN = pal.brights and pal.brights[3] or "#80ff80"
  local BRIGHT_YELLOW = pal.brights and pal.brights[4] or "#ffff80"
  local BRIGHT_BLUE = pal.brights and pal.brights[5] or "#8080ff"
  local BRIGHT_MAGENTA = pal.brights and pal.brights[6] or "#ff80ff"
  local BRIGHT_CYAN = pal.brights and pal.brights[7] or "#80ffff"
  local BRIGHT_WHITE = pal.brights and pal.brights[8] or "#ffffff"
  
  vim.api.nvim_set_hl(0, "Normal", { fg = FG, bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = FG, bg = "NONE" })
  
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = WHITE, bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatTitle", { fg = BRIGHT_YELLOW, bg = "NONE", bold = true })
  
  vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = GREEN, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = BLUE, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = CYAN, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = YELLOW, bg = "NONE" })
  
  vim.api.nvim_set_hl(0, "WhichKey", { fg = BLUE, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = CYAN, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = GREEN, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = BRIGHT_BLACK, bg = "NONE" })
  
  vim.api.nvim_set_hl(0, "SnacksPicker", { fg = FG, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = WHITE, bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerTitle", { fg = BRIGHT_YELLOW, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = GREEN, bg = "NONE", bold = true })
  
  vim.api.nvim_set_hl(0, "MiniFilesDirectory", { fg = BLUE, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "MiniFilesFile", { fg = FG, bg = "NONE" })
  vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { fg = GREEN, bg = "NONE", bold = true })
  
  vim.api.nvim_set_hl(0, "Identifier", { fg = CYAN, bg = "NONE" })
  vim.api.nvim_set_hl(0, "Statement", { fg = RED, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "Type", { fg = BLUE, bg = "NONE" })
  vim.api.nvim_set_hl(0, "Function", { fg = BRIGHT_BLUE, bg = "NONE" })
  vim.api.nvim_set_hl(0, "String", { fg = GREEN, bg = "NONE" })
  vim.api.nvim_set_hl(0, "Number", { fg = YELLOW, bg = "NONE" })
  vim.api.nvim_set_hl(0, "Constant", { fg = MAGENTA, bg = "NONE" })
  vim.api.nvim_set_hl(0, "Special", { fg = BRIGHT_MAGENTA, bg = "NONE" })
  vim.api.nvim_set_hl(0, "Comment", { fg = BRIGHT_BLACK, bg = "NONE", italic = true })
  
  vim.api.nvim_set_hl(0, "Bold", { fg = BOLD_FG, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "@text.strong", { fg = BOLD_FG, bg = "NONE", bold = true })
  
  local stat = vim.loop.fs_stat(M.palette_file)
  if stat then
    M.last_mtime = stat.mtime.sec
  end
  
  return true
end

function M.has_palette_changed()
  local stat = vim.loop.fs_stat(M.palette_file)
  if not stat then
    return false
  end
  
  return stat.mtime.sec > M.last_mtime
end

function M.sync_if_changed()
  if M.has_palette_changed() then
    if M.apply() then
      vim.notify("Font palette synced from WezTerm", vim.log.levels.INFO)
      return true
    end
  end
  return false
end

return M
