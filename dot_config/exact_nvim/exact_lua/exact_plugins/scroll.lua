return {
  -- { "psliwka/vim-smoothie" },
  { "karb94/neoscroll.nvim",
    cond = function()
      -- 如果是在 GUI（如 NeoVide、Goneovim）中，則不啟用插件
      if vim.g.neovide or vim.fn.has("goneovim") == 1 or vim.fn.has("gui_running") == 1 then
        return false
      end

      -- 獲取 TERM 環境變數
      local term = vim.fn.getenv("TERM")
      -- 檢查是否是常見的文字終端
      local is_terminal = term and (term:match("xterm") or term:match("screen") or term:match("tmux") or term:match("linux"))

      -- 如果是文字終端，則啟用插件
      return is_terminal ~= nil
    end,
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
      local neoscroll = require("neoscroll")

      -- 增加對<PageUp>與<PageDown>的支持
      local scroll_up = function()
        neoscroll.scroll(-vim.wo.scroll, { move_cursor = true, duration = 100 })
      end
      local scroll_down = function()
        neoscroll.scroll(vim.wo.scroll, { move_cursor = true, duration = 100 })
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
