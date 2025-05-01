return {
  {
    "pysan3/fcitx5.nvim",
    cond = function()
      return vim.fn.executable("fcitx5-remote") == 1
    end,
    event = { "ModeChanged" }, -- 在模式改變時載入插件
    config = function()
      require("fcitx5").setup() -- 初始化插件

      -- 以下是手動指定規則
      -- local en = "keyboard-us"
      -- local tw = "chewing"

      -- require("fcitx5").setup({
      --   imname = {
      --     norm = en,
      --     ins = tw,
      --     cmd = en,
      --   },
      --   remember_prior = false,
      -- })

      -- -- If you are using `jk` to escape, map 全角のｊｋ.
      -- vim.cmd([[
      -- inoremap <silent> ｊｋ <Esc>
      -- tnoremap <silent> ｊｋ <Esc>
      -- ]])
    end,
  },
}
