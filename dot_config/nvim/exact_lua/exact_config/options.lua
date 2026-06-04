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

-- Polyfills for vim.version helpers (< 0.10)
if vim.version and not vim.version.ge then
  vim.version.ge = function(v1, v2) return vim.version.cmp(v1, v2) >= 0 end
  vim.version.gt = function(v1, v2) return vim.version.cmp(v1, v2) > 0 end
  vim.version.le = function(v1, v2) return vim.version.cmp(v1, v2) <= 0 end
  vim.version.lt = function(v1, v2) return vim.version.cmp(v1, v2) < 0 end
  vim.version.eq = function(v1, v2) return vim.version.cmp(v1, v2) == 0 end
end

-- Polyfill for vim.api.nvim_get_hl (< 0.10)
if vim.fn.has("nvim-0.10") == 0 then
  local orig_get_hl = vim.api.nvim_get_hl
  vim.api.nvim_get_hl = function(ns_id, opts)
    if opts then
      opts.create = nil
    end
    return orig_get_hl(ns_id, opts)
  end
end

-- SSH / TMUX 剪貼簿共享 (OSC 52)
local is_ssh = vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil

if is_ssh then
  -- 處於 SSH 遠端連線環境下：使用 TextYankPost 自動發送 OSC 52 逸出碼到本機剪貼簿
  -- 避免啟用 unnamedplus 觸發舊版 Neovim 的 clipboard provider 遞迴與超時錯誤
  local function osc52_copy(lines)
    local text = table.concat(lines, "\n")
    local status, encoded
    if vim.base64 then
      status, encoded = pcall(vim.base64.encode, text)
    end
    if not status or not encoded then return end
    local osc = string.format("\x1b]52;c;%s\x07", encoded)
    if vim.env.TMUX then
      osc = string.format("\x1bPtmux;\x1b%s\x1b\\", osc:gsub("\x1b", "\x1b\x1b"))
    end
    io.stderr:write(osc)
    io.stderr:flush()
  end

  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("SSHOSC52Copy", { clear = true }),
    callback = function()
      local event = vim.v.event
      -- 複製/刪除/剪下到無名暫存器或系統剪貼簿暫存器時，同步到本地剪貼簿
      if event.regname == "" or event.regname == "+" or event.regname == "*" then
        osc52_copy(event.regcontents)
      end
    end,
  })
else
  -- 本地環境：使用系統預設的剪貼簿連通
  vim.api.nvim_set_option("clipboard", "unnamedplus") -- 使用系統剪貼簿（nvim Wayland有直接支援，不須依賴vim-wayland-clipboard）
end
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
