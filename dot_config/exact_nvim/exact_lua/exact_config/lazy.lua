-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  rocks = {
    hererocks = true,  -- recommended if you do not have global installation of Lua 5.1.
  },
  spec = {
    -- 先關閉此功能（目前在neo-tree無法work，而且會造成neovide出問題）
    -- {
    --   "3rd/image.nvim",
    --   opts = {},
    --   config = function()
    --     require("image").setup({
    --       backend = "ueberzug", -- or "ueberzug"
    --       processor = "magick_rock", -- or "magick_rock"
    --     })
    --   end,
    -- },
    -- 自動載入 plugins 資料夾中的所有插件
    { import = "plugins" },
    { import = "plugins.colorscheme.nightfox" }, -- 自訂配色
    { import = "plugins.tab.barbar" }, -- 目前只有barbar處理Buffer是最好的

    -- 手動引入 o-plugins 資料夾中的插件
    -- require("o-plugins.nvim-listchars"),
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
})
