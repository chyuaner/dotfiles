-- if true then return {} end
return {
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
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}
