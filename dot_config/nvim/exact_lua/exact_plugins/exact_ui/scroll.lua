return {
  -- { "psliwka/vim-smoothie" },
  { "karb94/neoscroll.nvim",
    cond = require("tools.gui").is_enable_sixel(),
    opts = {
      mappings = {                 -- Keys to be mapped to their corresponding default scrolling animation
        '<C-u>', '<C-d>',
        '<C-b>', '<C-f>',
        '<C-y>', '<C-e>',
        'zt', 'zz', 'zb',
      },
      hide_cursor = true,          -- Hide cursor while scrolling
      stop_eof = true,             -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      duration_multiplier = 1.0,   -- Global duration multiplier
      easing = 'linear',           -- Default easing function
      pre_hook = nil,              -- Function to run before the scrolling animation starts
      post_hook = nil,             -- Function to run after the scrolling animation ends
      performance_mode = false,    -- Disable "Performance Mode" on all buffers.
      ignored_events = {           -- Events ignored while scrolling
          'WinScrolled', 'CursorMoved'
      },
    },
    config = function(_, opts)
      -- 傳遞 opts 給插件的 setup 函數
      require("neoscroll").setup(opts)

      -- 增加對<PageUp>與<PageDown>的支持
      local scroll_up = function()
        require("neoscroll").scroll(-vim.wo.scroll, { move_cursor = true, duration = 100 })
      end
      local scroll_down = function()
        require("neoscroll").scroll(vim.wo.scroll, { move_cursor = true, duration = 100 })
      end
      -- Normal 模式
      vim.keymap.set("n", "<PageUp>", scroll_up, { silent = true })
      vim.keymap.set("n", "<PageDown>", scroll_down, { silent = true })
      -- Insert 模式
      vim.keymap.set("i", "<PageUp>", function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        scroll_up()
        vim.api.nvim_feedkeys("i", "n", true)
      end, { silent = true })
      vim.keymap.set("i", "<PageDown>", function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        scroll_down()
        vim.api.nvim_feedkeys("i", "n", true)
      end, { silent = true })
    end

    -- config = function()
    --   require("neoscroll").setup({
    --     mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>" },
    --     hide_cursor = true, -- Hide cursor while scrolling
    --     stop_eof = true, -- Stop at <EOF> when scrolling downwards
    --     respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    --     cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll anymore
    --     pre_hook = nil, -- Function to run before the scrolling animation starts
    --     post_hook = nil, -- Function to run after the scrolling animation ends
    --   })
    -- end
  }
}
