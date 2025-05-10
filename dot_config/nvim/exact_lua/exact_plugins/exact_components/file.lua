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
    end
  },
}
