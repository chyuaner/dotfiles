return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      local function is_neo_tree_open()
        -- 遍歷所有窗口，檢查是否有窗口對應到 "neo-tree" 緩衝區
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.fn.bufname(buf):match("neo%-tree") then
            return true -- 找到 NeoTree 窗口
          end
        end
        return false -- 沒有找到 NeoTree 窗口
      end

      require("toggleterm").setup {
        open_mapping = [[<C-\>]],
        on_open = function(_)
          if is_neo_tree_open() then
            vim.defer_fn(function()
              local cmd = string.format("Neotree toggle")
              vim.cmd(cmd)
              vim.cmd(cmd)
              vim.cmd("wincmd p")
            end, 100)
          end
        end,
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'horizontal',
        close_on_exit = true,
        shell = vim.o.shell,
      }

      -- 添加第二個快捷鍵映射
      vim.api.nvim_set_keymap('n', '<C-`>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
    end,
  },
}
