-- if true then return {} end -- 停用

return {
  {'romgrk/barbar.nvim',
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
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
        },
      }

      -- 設定快速鍵
      -- vim.api.nvim_set_keymap('t', '<A-Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-]>', '<cmd>BufferNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-[>', '<cmd>BufferPrevious<CR>', { noremap = true, silent = true })

    end,
  },
}
