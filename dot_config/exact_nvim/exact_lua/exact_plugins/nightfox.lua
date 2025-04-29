-- if true then return {} end
return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- 自訂配色
      local palettes = {
        nordfox = {
          -- A specific style's value will be used over the `all`'s value
          bg1 = "#2f3440", -- 故意改背景顏色為別的極相似色（因為當背景顏色和終端機背景顏色完全一致時，會觸發終端機透明的設定）
        },
      }

      require("nightfox").setup({
        options = {
          transparent = false,     -- Disable setting background
          terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
        palettes = palettes
      })

      vim.cmd("colorscheme nordfox")
    end,
  },
}
