return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "regex" }, -- 確保安裝 regex 支援
        highlight = {
          enable = true, -- 啟用高亮
        },
      })
    end,
  }
}
