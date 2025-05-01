-- if true then return {} end -- 暫時停用
return {
  {
    "numToStr/Comment.nvim",
    opts = {
      padding = true,
      sticky = true,
      ignore = nil,
      toggler = { line = 'gcc', block = 'gbc' },
      opleader = { line = 'gc', block = 'gb' },
      extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
      mappings = { basic = true, extra = true },
      pre_hook = nil,
      post_hook = nil,
    },
    config = function(_, opts)
      require("Comment").setup(opts)

      local api = require('Comment.api')
      local config = require('Comment.config'):get()

      -- api.toggle.linewise(motion, config?)
      -- api.toggle.linewise.current(motion?, config?)
      -- api.toggle.linewise.count(count, config?)

      -- api.toggle.blockwise(motion, config?)
      -- api.toggle.blockwise.current(motion?, config?)
      -- api.toggle.blockwise.count(count, config?)

      -- Toggle current line (linewise) using C-/
      vim.keymap.set('n', '<C-_>', api.toggle.linewise.current)

      -- -- Toggle current line (blockwise) using C-\
      -- vim.keymap.set('n', '<C-\\>', api.toggle.blockwise.current)

      -- Toggle lines (linewise) with dot-repeat support
      -- Example: <leader>gc3j will comment 4 lines
      vim.keymap.set(
          'n', '<leader>gc', api.call('toggle.linewise', 'g@'),
          { expr = true }
      )

      -- Toggle lines (blockwise) with dot-repeat support
      -- Example: <leader>gb3j will comment 4 lines
      vim.keymap.set(
          'n', '<leader>gb', api.call('toggle.blockwise', 'g@'),
          { expr = true }
      )

      local esc = vim.api.nvim_replace_termcodes(
          '<ESC>', true, false, true
      )

      -- Toggle selection (linewise)
      -- vim.keymap.set('x', '<leader>c', function()
      vim.keymap.set('x', '<C-_>', function()
          vim.api.nvim_feedkeys(esc, 'nx', false)
          api.toggle.linewise(vim.fn.visualmode())
      end)

    end,
  }

}
