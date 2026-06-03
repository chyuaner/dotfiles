return {
  {'romgrk/barbar.nvim',
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
    dependencies = {
      -- 'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    lazy = false,
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      auto_hide = -1,
      clickable = true,
      icons = {
        buffer_index = false,
        buffer_number = false,
        button = '',
        diagnostics = {{enabled = true}, {enabled = true}},
        filetype = {enabled = true},
        separator = {left = '▎', right = ''},
        -- separator = {left = '', right = ''},
      },
      sidebar_filetypes = {
        -- ['neo-tree'] = {
        --   event = 'BufWipeout',
        --   -- text = ' Explorer',
        --   align = 'left',
        --   -- event = 'BufWinEnter'
        -- },
        undotree = {
          text = 'undotree',
          align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
        },
      },
      -- icons = {current = {filetype = {enabled = false}}},
      -- maximum_padding = math.huge,
      -- animation = false,
      -- insert_at_start = true,
      -- …etc.
    },
    config = function(_, opts)
      -- require'bufferline'.setup {
      --   -- animation = false, -- 禁用動畫效果
      --   sidebar_filetypes = {
      --     ['neo-tree'] = {event = 'BufWipeout'},
      --     undotree = {
      --       text = 'undotree',
      --       align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
      --     },
      --   },
      -- }
      require('barbar').setup(opts)

      -- 修正neo-tree的winbar開啟後，切換winbat tab會導致barbar offset跑掉的問題
      -- <https://chatgpt.com/share/683aa9e0-6214-800f-96f9-df29d366ad2a>
      local function neo_tree_is_visible()
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "neo-tree" then
            return true
          end
        end
        return false
      end
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
          if vim.bo.filetype == "neo-tree" then
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].filetype == "neo-tree" then
                local width = vim.api.nvim_win_get_width(win)
                require("barbar.api").set_offset(width, " Explorer")
                break
              end
            end
          end
        end,
      })
      vim.api.nvim_create_autocmd("BufLeave", {
        pattern = "*",
        callback = function()
          -- ⚠️ 只有在「沒有任何 neo-tree 視窗」時才清除 offset
          vim.defer_fn(function()
            if not neo_tree_is_visible() then
              require("barbar.api").set_offset(0)
            end
          end, 10)  -- 使用 defer 確保事件序列完成
        end,
      })

      -- 智慧型關閉行為：如果還有其他檔案，僅關閉當前分頁；若是最後一個檔案則關閉 Neovim。若在特殊/側邊欄視窗，則直接關閉視窗。
      local function smart_close()
        local buftype = vim.bo.buftype
        local filetype = vim.bo.filetype

        -- 如果是特殊/輔助視窗（如 neo-tree, toggleterm 等），直接關閉視窗本身
        local is_special = vim.tbl_contains({
          "neo-tree", "toggleterm", "qf", "notify", "trouble", "lazy", "mason", "noice"
        }, filetype) or buftype ~= ""

        if is_special then
          vim.cmd('quit')
          return
        end

        -- 獲取所有載入且列出在 tabline 上的緩衝區數量
        local buffers = vim.tbl_filter(function(buf)
          return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted
        end, vim.api.nvim_list_bufs())

        -- 如果只剩下一個（或更少）一般檔案 Buffer，直接退出
        if #buffers <= 1 then
          vim.cmd('quit')
        else
          vim.cmd('BufferClose')
        end
      end

      -- 重定義 :Q 與 :WQ 命令
      vim.api.nvim_create_user_command('Q', smart_close, {})
      vim.api.nvim_create_user_command('WQ', function()
        vim.cmd('write')
        smart_close()
      end, {})

      -- 將命令列中的 q/wq 用智慧型的 Q/WQ 替換
      vim.cmd([[
        cnoreabbrev <expr> q ((getcmdtype() is# ':' && getcmdline() is# 'q') ? 'Q' : 'q')
        cnoreabbrev <expr> wq ((getcmdtype() is# ':' && getcmdline() is# 'wq') ? 'WQ' : 'wq')
      ]])

      -- 設定快速鍵
      -- vim.api.nvim_set_keymap('t', '<A-Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-l>', '<cmd>BufferNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-h>', '<cmd>BufferPrevious<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-RIGHT>', '<cmd>BufferNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-LEFT>', '<cmd>BufferPrevious<CR>', { noremap = true, silent = true })

      vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>enew<CR>', { noremap = true, silent = true })
    end,
  },
}
