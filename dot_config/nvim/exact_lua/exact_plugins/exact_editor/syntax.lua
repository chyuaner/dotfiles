return {
  {
    "nvim-treesitter/nvim-treesitter",
    cond = function()
      -- 檢查是否有 gcc 或 clang 或 cc（任一存在就啟用）
      return vim.fn.executable("gcc") == 1
          or vim.fn.executable("cc") == 1
          or vim.fn.executable("clang") == 1
          or vim.fn.executable("cl") == 1
          or vim.fn.executable("zig") == 1
    end,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- <https://github.com/nvim-treesitter/nvim-treesitter#supported-languages>
        ensure_installed = {
          "regex",
          "lua",
          "php",
          "python",
          "go",
          "html",
          "css",
          "javascript"
        },
        highlight = {
          enable = true, -- 啟用高亮
        },
        indent = { enable = true },
      })
    end,
  },
}
