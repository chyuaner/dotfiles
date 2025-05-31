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
        open_mapping = [[<C-\>]], -- 設定開關快速鍵

        -- on_open時，以Neotree當Offset
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
      vim.api.nvim_set_keymap('n', '<A-\\>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-`>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<A-\\>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<C-`>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })

      -- 添加Alt+Esc鍵離開終端模式，回到Normal Mode
      vim.api.nvim_set_keymap('t', '<A-Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
    end,
  },

  -- 在nvim內的Terminal用 `nvim Readme.md` 開啟檔案，會在當前nvim以新Buffer開啟
  {
    "willothy/flatten.nvim",
    -- config = true,
    -- or pass configuration with
    opts = {
      window = {
        open = "alternate",
        diff = "tab_vsplit",
        focus = "first",
      },
    },
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
}
