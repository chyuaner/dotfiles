return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup {
        open_mapping = [[<C-\>]], -- 設定開關快速鍵

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
