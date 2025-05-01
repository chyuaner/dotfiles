return {
  {'romgrk/barbar.nvim',
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    dependencies = {
      -- 'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    -- opts = {
    --   -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    --   -- animation = false,
    --   -- insert_at_start = true,
    --   -- …etc.
    -- },
    config = function(_, opts)
      require'bufferline'.setup {
        -- animation = false, -- 禁用動畫效果
        sidebar_filetypes = {
          ['neo-tree'] = {event = 'BufWipeout'},
          undotree = {
            text = 'undotree',
            align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
          },
        },
      }

      -- 重定義 :q 命令為僅關閉當前 Buffer
      vim.api.nvim_create_user_command('Q', function()
        vim.cmd('BufferClose') -- 使用 barbar.nvim 的 BufferClose 呀命
      end, {})

      -- 重定義 :wq 命令為保存後僅關閉當前 Buffer
      vim.api.nvim_create_user_command('WQ', function()
        vim.cmd('write') -- 保存文件
        vim.cmd('BufferClose') -- 使用 barbar.nvim 的 BufferClose 命令
      end, {})

      -- 設定快速鍵
      -- vim.api.nvim_set_keymap('t', '<A-Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-l>', '<cmd>BufferNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-h>', '<cmd>BufferPrevious<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-RIGHT>', '<cmd>BufferNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-LEFT>', '<cmd>BufferPrevious<CR>', { noremap = true, silent = true })
    end,
  },
}
