return {

  {
    "mbbill/undotree",
    config = function()
      -- vim.g.mundo_preview_bottom = 1
      -- vim.g.mundo_auto_preview = 1
      -- vim.g.mundo_window_height = 20
      -- vim.g.mundo_window_width = 80
      -- vim.g.mundo_window_top = 0
      -- vim.g.mundo_window_left = 0

      vim.keymap.set('n', '<F6>', vim.cmd.UndotreeToggle)
      vim.g.undotree_WindowLayout = 3

      vim.cmd([[
        function g:Undotree_CustomMap()
            map <buffer> <s-DOWN> J
            map <buffer> <s-UP> K
        endfunction
      ]])
      -- 使用 vim.cmd 執行 Vim 傳統語法
      -- vim.cmd([[
      --   nnoremap <F6> :UndotreeToggle<CR>
      --   if !exists('g:undotree_WindowLayout')
      --       let g:undotree_WindowLayout = 1
      --   endif
      -- ]])

    end,
  }
  --  {
  --   "mbbill/undotree",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   config = true,
  --   keys = { -- load the plugin only when using it's keybinding:
  --     { "<F6>", "<cmd>lua require('undotree').toggle()<cr>" },
  --     { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
  --   },
  -- }

  -- {
  --   "jiaoshijie/undotree",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   config = true,
  --   keys = { -- load the plugin only when using it's keybinding:
  --     { "<F6>", "<cmd>lua require('undotree').toggle()<cr>" },
  --     { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
  --   },
  --   opts = {
  --     float_diff = true,  -- using float window previews diff, set this `true` will disable layout option
  --     layout = "left_bottom", -- "left_bottom", "left_left_bottom"
  --     position = "right", -- "left", "right", "bottom"
  --     ignore_filetype = { 'undotree', 'undotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground' },
  --     window = {
  --       winblend = 30,
  --     },
  --     keymaps = {
  --       ['j'] = "move_next",
  --       ['k'] = "move_prev",
  --       ['gj'] = "move2parent",
  --       ['J'] = "move_change_next",
  --       ['K'] = "move_change_prev",
  --       ['<cr>'] = "action_enter",
  --       ['p'] = "enter_diffbuf",
  --       ['q'] = "quit",
  --     },
  --   },
  -- }
}
