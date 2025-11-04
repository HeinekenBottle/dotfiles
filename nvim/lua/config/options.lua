-- Options are automatically loaded before lazy.nvim startup
-- Add any additional options here

-- Leader key
vim.g.mapleader = " "

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- Transparency options
vim.opt.pumblend = 10
vim.opt.winblend = 0

-- Clean up fillchars
vim.o.fillchars = "eob: "
