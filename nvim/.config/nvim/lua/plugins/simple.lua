 -- Truly minimal modern Neovim configuration
-- No LazyVim defaults - just essential modern plugins
return {
  -- WezTerm Dynamic Theme FIRST (highest priority)
  {
    "wezterm-dynamic-theme",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      
      vim.api.nvim_set_hl(0, "Normal", { fg = "NONE", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { fg = "NONE", bg = "NONE" })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7a8390", bg = "NONE" })
      
      local font_sync = require("config.font_sync")
      font_sync.apply()
      
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          font_sync.apply()
        end,
      })
      
      vim.api.nvim_create_user_command("WeztermFontSync", function()
        if font_sync.apply() then
          vim.notify("WezTerm font palette synced", vim.log.levels.INFO)
        else
          vim.notify("Failed to read WezTerm palette", vim.log.levels.WARN)
        end
      end, {})
      
      vim.api.nvim_create_user_command("WeztermCheckSync", function()
        font_sync.sync_if_changed()
      end, {})
      
      require("config.ui").apply_float_style()
    end,
  },

  -- Optional: transparent.nvim AFTER theme (lower priority)
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 900,
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NormalFloat", "FloatBorder", "FloatTitle", "FloatFooter",
          "WhichKeyFloat", "WhichKeyNormal",
          "SnacksPicker", "SnacksPickerPreview", "SnacksPickerPrompt",
        },
      })
    end,
  },

   -- Modern picker (replaces telescope)
   {
     "folke/snacks.nvim",
     priority = 800,
     lazy = false,
     opts = {
       -- Buffer management (replaces mini.bufremove)
       bufdelete = { enabled = true },

       -- Input prompts (vim.ui.input)
       input = { enabled = true },

       dashboard = {
         enabled = true,
         preset = {
           header = [[
 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
         },
         sections = {
           { section = "header", hl = "SnacksDashboardHeader" },
           { section = "keys", gap = 1, padding = 1 },
           { section = "startup" },
         },
       },
        styles = {
          notification = { border = { style = "single" } },
        },
  picker = { 
             layout = {
               preset = "vertical",
               width = 0.8,
               height = 0.8,
               border = "single",
             },
             win = {
               border = "single",
               padding = { 0, 0 },
               wo = {
                 winblend = 0,
                 signcolumn = "no",
                 statuscolumn = "",
                 winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
               },
               input   = { border = "single", padding = {0,0}, wo = { winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder" } },
               list    = { border = "single", padding = {0,0}, wo = { winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder" } },
               preview = { border = "single", padding = {0,0}, wo = { winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder" } },
             },
           },
      },
  },

  -- Command line, messages, and notifications UI (center screen)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        command_palette = true,       -- Center command line popup
        long_message_to_split = true, -- Long messages in split
        lsp_doc_border = true,        -- LSP docs with border
      },
      views = {
        cmdline_popup = {
          border = {
            style = "single",
          },
        },
      },
    },
  },

  -- Treesitter for advanced syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "python",
        "javascript",
        "typescript",
        "bash",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Modern completion (replaces nvim-cmp)
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = { preset = "enter" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },

  -- Modern file explorer (replaces netrw/neo-tree)
  {
    "echasnovski/mini.files",
    version = false,
    keys = {
      { "<leader>e", function() require("mini.files").open() end, desc = "File Explorer" },
    },
    opts = {},
  },





   -- Keymap display with spacebar trigger
   {
     "folke/which-key.nvim",
     event = "VeryLazy",
     init = function()
       vim.o.timeout = true
       vim.o.timeoutlen = 300
     end,
         config = function()
           require("which-key").setup({
             win = {
               border = "single",
               padding = { 0, 0 },
               wo = { winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder" },
             },
           })
         -- Register mappings
        require("which-key").add({
          { "<leader>f", group = "Find" },
          { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
          { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live Grep" },
          { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
          { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
          { "<leader>b", group = "Buffers" },
          { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
          { "<leader>bD", function() Snacks.bufdelete.all() end, desc = "Delete All Buffers" },
          { "<leader>e", function() require("mini.files").open() end, desc = "File Explorer" },
          { "<leader>t", function() require("transparent").toggle() end, desc = "Toggle Transparency" },
          { "<leader>us", "<cmd>WeztermCheckSync<CR>", desc = "Check WezTerm font sync" },
          { "<leader>uf", "<cmd>WeztermFontSync<CR>", desc = "Force WezTerm font sync" },
          { "<leader>h", "<cmd>nohlsearch<CR>", desc = "Clear highlights" },
          { "<leader>w", "<cmd>w<CR>", desc = "Save" },
          { "<leader>q", "<cmd>q<CR>", desc = "Quit" },
        })
     end,
   },
 }
