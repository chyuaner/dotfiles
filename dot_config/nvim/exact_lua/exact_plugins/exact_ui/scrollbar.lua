-- if true then return {} end -- 先停用

return {
  {
    'dstein64/nvim-scrollview',
    opts = {
      current_only = true,
      -- base = 'buffer',
      -- column = 80, -- 註解掉這行，讓它自己決定位置
      -- excluded_filetypes = { 'neo-tree', 'help' },
      signs_on_startup = { 'all' },
      diagnostics_severities = { vim.diagnostic.severity.ERROR },
    },
    config = function(_, opts)
      require('scrollview').setup(opts)
    end,
  },

  -- {
  --   'wfxr/minimap.vim',
  --   config = function()
  --     vim.g.minimap_width = 10
  --     vim.g.minimap_auto_start = 1
  --     vim.g.minimap_auto_start_win_enter = 1
  --   end,
  -- }
  -- {
  --   'gorbit99/codewindow.nvim',
  --   config = function()
  --     local codewindow = require('codewindow')
  --     codewindow.setup()
  --     codewindow.apply_default_keybinds()
  --   end,
  -- },
  ---@module "neominimap.config.meta"
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false, -- NOTE: NO NEED to Lazy load
    -- Optional. You can alse set your own keybindings
    keys = {
      -- Global Minimap Controls
      { "<leader>nm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
      { "<leader>no", "<cmd>Neominimap Enable<cr>", desc = "Enable global minimap" },
      { "<leader>nc", "<cmd>Neominimap Disable<cr>", desc = "Disable global minimap" },
      { "<leader>nr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh global minimap" },

      -- Window-Specific Minimap Controls
      { "<leader>nwt", "<cmd>Neominimap WinToggle<cr>", desc = "Toggle minimap for current window" },
      { "<leader>nwr", "<cmd>Neominimap WinRefresh<cr>", desc = "Refresh minimap for current window" },
      { "<leader>nwo", "<cmd>Neominimap WinEnable<cr>", desc = "Enable minimap for current window" },
      { "<leader>nwc", "<cmd>Neominimap WinDisable<cr>", desc = "Disable minimap for current window" },

      -- Tab-Specific Minimap Controls
      { "<leader>ntt", "<cmd>Neominimap TabToggle<cr>", desc = "Toggle minimap for current tab" },
      { "<leader>ntr", "<cmd>Neominimap TabRefresh<cr>", desc = "Refresh minimap for current tab" },
      { "<leader>nto", "<cmd>Neominimap TabEnable<cr>", desc = "Enable minimap for current tab" },
      { "<leader>ntc", "<cmd>Neominimap TabDisable<cr>", desc = "Disable minimap for current tab" },

      -- Buffer-Specific Minimap Controls
      { "<leader>nbt", "<cmd>Neominimap BufToggle<cr>", desc = "Toggle minimap for current buffer" },
      { "<leader>nbr", "<cmd>Neominimap BufRefresh<cr>", desc = "Refresh minimap for current buffer" },
      { "<leader>nbo", "<cmd>Neominimap BufEnable<cr>", desc = "Enable minimap for current buffer" },
      { "<leader>nbc", "<cmd>Neominimap BufDisable<cr>", desc = "Disable minimap for current buffer" },

      ---Focus Controls
      { "<leader>nf", "<cmd>Neominimap Focus<cr>", desc = "Focus on minimap" },
      { "<leader>nu", "<cmd>Neominimap Unfocus<cr>", desc = "Unfocus minimap" },
      { "<leader>ns", "<cmd>Neominimap ToggleFocus<cr>", desc = "Switch focus on minimap" },
    },
    init = function()
      -- The following options are recommended when layout == "float"
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36 -- Set a large value

      --- Put your configuration here
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = false,

        click = {
          -- Enable mouse click on the minimap
          enabled = true, ---@type boolean
          -- Automatically switch focus to the minimap when clicked
          auto_switch_focus = true, ---@type boolean
        },
      }
    end,
  }
  -- { "petertriho/nvim-scrollbar",
  --   cond = true,
  --   config = function()
  --     require("scrollbar").setup({
  --       show = true,
  --       show_in_active_only = false,
  --       set_highlights = true,
  --       folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
  --       max_lines = false, -- disables if no. of lines in buffer exceeds this
  --       hide_if_all_visible = false, -- Hides everything if all lines are visible
  --       throttle_ms = 100,
  --       handle = {
  --           text = " ",
  --           blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
  --           color = nil,
  --           color_nr = nil, -- cterm
  --           highlight = "CursorColumn",
  --           hide_if_all_visible = true, -- Hides handle if all lines are visible
  --       },
  --       marks = {
  --           Cursor = {
  --               text = "•",
  --               priority = 0,
  --               gui = nil,
  --               color = nil,
  --               cterm = nil,
  --               color_nr = nil, -- cterm
  --               highlight = "Normal",
  --           },
  --           Search = {
  --               text = { "-", "=" },
  --               priority = 1,
  --               gui = nil,
  --               color = nil,
  --               cterm = nil,
  --               color_nr = nil, -- cterm
  --               highlight = "Search",
  --           },
  --           Error = {
  --               text = { "-", "=" },
  --               priority = 2,
  --               gui = nil,
  --               color = nil,
  --               cterm = nil,
  --               color_nr = nil, -- cterm
  --               highlight = "DiagnosticVirtualTextError",
  --           },
  --           Warn = {
  --               text = { "-", "=" },
  --               priority = 3,
  --               gui = nil,
  --               color = nil,
  --               cterm = nil,
  --               color_nr = nil, -- cterm
  --               highlight = "DiagnosticVirtualTextWarn",
  --           },
  --           Info = {
  --               text = { "-", "=" },
  --               priority = 4,
  --               gui = nil,
  --               color = nil,
  --               cterm = nil,
  --               color_nr = nil, -- cterm
  --               highlight = "DiagnosticVirtualTextInfo",
  --           },
  --           Hint = {
  --               text = { "-", "=" },
  --               priority = 5,
  --               gui = nil,
  --               color = nil,
  --               cterm = nil,
  --               color_nr = nil, -- cterm
  --               highlight = "DiagnosticVirtualTextHint",
  --           },
  --           Misc = {
  --               text = { "-", "=" },
  --               priority = 6,
  --               gui = nil,
  --               color = nil,
  --               cterm = nil,
  --               color_nr = nil, -- cterm
  --               highlight = "Normal",
  --           },
  --           GitAdd = {
  --               text = "┆",
  --               priority = 7,
  --               gui = nil,
  --               color = nil,
  --               cterm = nil,
  --               color_nr = nil, -- cterm
  --               highlight = "GitSignsAdd",
  --           },
  --           GitChange = {
  --               text = "┆",
  --               priority = 7,
  --               gui = nil,
  --               color = nil,
  --               cterm = nil,
  --               color_nr = nil, -- cterm
  --               highlight = "GitSignsChange",
  --           },
  --           GitDelete = {
  --               text = "▁",
  --               priority = 7,
  --               gui = nil,
  --               color = nil,
  --               cterm = nil,
  --               color_nr = nil, -- cterm
  --               highlight = "GitSignsDelete",
  --           },
  --       },
  --       excluded_buftypes = {
  --           "terminal",
  --       },
  --       excluded_filetypes = {
  --           "dropbar_menu",
  --           "dropbar_menu_fzf",
  --           "DressingInput",
  --           "cmp_docs",
  --           "cmp_menu",
  --           "noice",
  --           "prompt",
  --           "TelescopePrompt",
  --       },
  --       autocmd = {
  --           render = {
  --               "BufWinEnter",
  --               "TabEnter",
  --               "TermEnter",
  --               "WinEnter",
  --               "CmdwinLeave",
  --               "TextChanged",
  --               "VimResized",
  --               "WinScrolled",
  --           },
  --           clear = {
  --               "BufWinLeave",
  --               "TabLeave",
  --               "TermLeave",
  --               "WinLeave",
  --           },
  --       },
  --       handlers = {
  --           cursor = true,
  --           diagnostic = true,
  --           gitsigns = false, -- Requires gitsigns
  --           handle = true,
  --           search = false, -- Requires hlslens
  --           ale = false, -- Requires ALE
  --       },
  --   })
  --   end
  -- },
}
