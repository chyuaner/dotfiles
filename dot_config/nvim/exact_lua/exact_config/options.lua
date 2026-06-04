-- Polyfills for compatibility with older Neovim versions (< 0.10)
if not vim.fs then
  vim.fs = {}
end
if not vim.fs.joinpath then
  vim.fs.joinpath = function(...)
    return table.concat({...}, "/")
  end
end
if not vim.list_contains then
  vim.list_contains = function(t, value)
    for _, v in ipairs(t) do
      if v == value then
        return true
      end
    end
    return false
  end
end

-- SSH / TMUX 剪貼簿共享 (OSC 52)
if vim.fn.has("nvim-0.10") == 1 then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
else
  local function osc52_copy(lines, _)
    if not vim.base64 then return end
    local text = table.concat(lines, "\n")
    local status, encoded = pcall(vim.base64.encode, text)
    if not status then return end
    local osc = string.format("\x1b]52;c;%s\x07", encoded)
    if vim.env.TMUX then
      osc = string.format("\x1bPtmux;\x1b%s\x1b\\", osc:gsub("\x1b", "\x1b\x1b"))
    end
    io.stdout:write(osc)
    io.stdout:flush()
  end

  vim.g.clipboard = {
    name = 'OSC 52 Fallback',
    copy = {
      ['+'] = osc52_copy,
      ['*'] = osc52_copy,
    },
    paste = {
      ['+'] = function() return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')} end,
      ['*'] = function() return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')} end,
    },
  }
end

-- 編輯器行為設定
vim.api.nvim_set_option("clipboard", "unnamedplus") -- 使用系統剪貼簿（nvim Wayland有直接支援，不須依賴vim-wayland-clipboard）
vim.opt.confirm = true          -- 操作過程有衝突時，以明確的文字來詢問
vim.opt.history = 10000         -- 設定命令歷史記錄數量為 10000
-- vim.opt.directory = "."         -- 將暫存檔存放在當前資料夾中
-- require("tools.swap")           -- 將暫存檔存放置位置另外做邏輯
vim.opt.mouse = "a"             -- 啟用滑鼠支援

-- 編碼設定
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "cp950" }
vim.opt.enc = "utf-8"

-- 設定編輯選項
vim.opt.number         = true   -- 顯示行號
vim.opt.relativenumber = false  -- 相對行號
vim.opt.tabstop        = 4      -- tab鍵寬度
vim.opt.shiftwidth     = 4      -- 自動縮排寬度
vim.opt.expandtab      = true   -- 使用空格代替tab
vim.opt.termguicolors  = true   -- 支持真彩色
vim.opt.wrap           = true   -- 不自動換折行
vim.opt.colorcolumn = "80,120"  -- 顯示編輯器建議寬度
vim.opt.scrolloff = 3           -- 捲動時保留 n 行彈性
require("config.listchars")     -- 顯示行尾符號
vim.opt.list = true
vim.opt.splitkeep = "screen"    -- 保持視窗分割比例穩定


-- 設定正確的檔案類型對應
vim.filetype.add({
  pattern = {
    [".+%.sh%.tmpl"] = "bash",
    [".+%.zsh%.tmpl"] = "zsh",
    [".+%.ps1%.tmpl"] = "powershell",
    [".+%.py%.tmpl"] = "python",
    [".+%.go%.tmpl"] = "go",
  },
})
