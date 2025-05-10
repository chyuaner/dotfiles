-- if true then return {} end
return {
  {
    -- 會自動cd到專案目錄
    -- "ahmedkhalf/project.nvim",

    -- 使用修改版的project.nvim
    -- 因為此套件會噴警告，原作者已經沒再維護了
    -- vim.lsp.buf_get_clients() is deprecated. Run ":checkhealth vim.deprecated" for more information
    "Spelis/project.nvim",
    branch = "patch-1",
    dependencies = { "nvim-telescope/telescope.nvim" },
    enabled = vim.fn.has("nvim-0.10") == 1,

    config = function()
      require("project_nvim").setup {
        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = { "lsp", "pattern" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,

        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }

      require('telescope').load_extension('projects')
    end
  },

  {
    'rmagatti/auto-session',
    -- event = 'VeryLazy', -- 或者你選擇合適的時機載入
    event = 'VimLeavePre', -- 插件只在關閉時載入以自動儲存
    cmd = { "SessionRestore", "SessionSave", "SessionDelete" },
    opts = {
      log_level = 'error',
      auto_session_enable = true,          -- ✅ 開啟 plugin 的 session 功能
      auto_restore_enabled = false,        -- ❌ 禁止自動還原
      auto_save_enabled = true,            -- ✅ 啟用自動儲存
      auto_session_suppress_dirs = { '~/', '~/Downloads', '/' }, -- 可選
    },
    keys = {
      { "<Leader>sr", "<cmd>SessionRestore<cr>", desc = "Restore Session" },
      { "<Leader>ss", "<cmd>SessionSave<cr>", desc = "Save Session" },
      { "<Leader>sd", "<cmd>SessionDelete<cr>", desc = "Delete Session" },
    },
    config = function(_, opts)
      require("auto-session").setup(opts)
    end,
  },
  {
    'rmagatti/session-lens',
    dependencies = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('session-lens').setup({
        path_display = { 'shorten' },
      })
    end,
    keys = {
      { "<Leader>sl", "<cmd>Telescope session-lens search_session<cr>", desc = "Search Sessions" },
    }
  }
}
