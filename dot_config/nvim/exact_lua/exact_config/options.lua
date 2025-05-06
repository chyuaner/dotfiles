-- 編輯器行為設定
vim.api.nvim_set_option("clipboard", "unnamedplus") -- 使用系統剪貼簿（Wayland有直接支援，不須依賴vim-wayland-clipboard）
vim.opt.confirm = true      -- 操作過程有衝突時，以明確的文字來詢問
vim.opt.history = 10000 -- 設定命令歷史記錄數量為 10000
-- vim.opt.directory = "." -- 將暫存檔存放在當前資料夾中
-- require("tools.swap") -- 將暫存檔存放置位置另外做邏輯
vim.opt.mouse = "a" -- 啟用滑鼠支援

-- 編碼設定
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "cp950" }
vim.opt.enc = "utf-8"

-- 設定編輯選項
vim.opt.number         = true -- 顯示行號
vim.opt.relativenumber = false -- 相對行號
vim.opt.tabstop        = 4 -- tab鍵寬度
vim.opt.shiftwidth     = 4 -- 自動縮排寬度
vim.opt.expandtab      = true -- 使用空格代替tab
vim.opt.termguicolors  = true -- 支持真彩色
vim.opt.wrap           = true -- 不自動換折行
vim.opt.colorcolumn = "80,120"  -- 顯示編輯器建議寬度
vim.opt.scrolloff = 3       -- 捲動時保留 n 行彈性
require("config.listchars") -- 顯示行尾符號
vim.opt.list = true

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
