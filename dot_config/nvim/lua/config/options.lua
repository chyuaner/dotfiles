-- 編輯器行為設定
vim.api.nvim_set_option("clipboard", "unnamedplus") -- 使用系統剪貼簿（Wayland有直接支援，不須依賴vim-wayland-clipboard）
vim.opt.confirm = true      -- 操作過程有衝突時，以明確的文字來詢問
vim.opt.history = 10000 -- 設定命令歷史記錄數量為 10000
-- vim.opt.directory = "." -- 將暫存檔存放在當前資料夾中
require("config.swap") -- 將暫存檔存放置位置另外做邏輯

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
vim.opt.colorcolumn = "80,120"  -- 顯示編輯器建議寬度
vim.opt.scrolloff = 3       -- 捲動時保留 n 行彈性
vim.opt.listchars = {
    eol = "¬",
    tab = "→→",
    trail = ".",
    extends = ">",
    precedes = "<" }
vim.opt.list = true

-- 整行移動的快速鍵
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- 使用 Alt+方向鍵 移動整行
vim.api.nvim_set_keymap('n', '<A-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-Up>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- Ctrl+Alt+Shift+j/k 複製整行並向下/向上貼上
vim.api.nvim_set_keymap('n', '<C-A-S-j>', 'yyp', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-S-k>', 'yyP', { noremap = true, silent = true })
-- Ctrl+Alt+Shift+方向鍵 複製整行並向下/向上貼上
vim.api.nvim_set_keymap('n', '<C-A-S-Down>', 'yyp', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-A-S-Up>', 'yyP', { noremap = true, silent = true })
-- Insert Mode 下的 Ctrl+Alt+Shift+方向鍵 複製整行並向下/向上貼上
vim.api.nvim_set_keymap('i', '<C-A-S-Down>', '<Esc>yypgi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-A-S-Up>', '<Esc>yyPgi', { noremap = true, silent = true })

-- -- 處理不同終端的行為
-- -- 在 Insert Mode 下的 Ctrl+Enter 在下一行插入新行並保持 Insert 模式
-- local term = vim.fn.getenv("TERM")
-- local term_program = vim.fn.getenv("TERM_PROGRAM")
-- if term_program == "iTerm.app" then
--     -- iTerm 的快捷鍵設置
--     vim.api.nvim_set_keymap('i', '<C-CR>', '<Esc>o', { noremap = true, silent = true })
--     vim.api.nvim_set_keymap('i', '<C-S-CR>', '<Esc>O', { noremap = true, silent = true })
-- elseif term == "alacritty" then
--     -- Alacritty 的快捷鍵設置
--     vim.api.nvim_set_keymap('i', '<C-CR>', '<Esc>o', { noremap = true, silent = true })
--     vim.api.nvim_set_keymap('i', '<C-S-CR>', '<Esc>O', { noremap = true, silent = true })
-- elseif term == "xterm-256color" then
--     -- xterm-256color 的快捷鍵設置
--     vim.api.nvim_set_keymap('i', '<A-CR>', '<Esc>o', { noremap = true, silent = true })
--     vim.api.nvim_set_keymap('i', '<A-S-CR>', '<Esc>O', { noremap = true, silent = true })
-- end

-- 使用Ctrl(Alt)+Enter 在下一行插入新行並保持 Insert 模式
-- 檢查 $TERM 或 $TERM_PROGRAM 的值
-- Alacritty, GUI(Neovide, Goneovim) 皆可
-- xterm-256color採用程式: Konsole, iTerm2, gnome-terminal 會有按鍵吃不到的問題，詳下述註解：
-- 使用Ctrl+Enter 在下一行插入新行並保持 Insert 模式（xterm-256color 吃不到）
vim.api.nvim_set_keymap('i', '<C-CR>', '<Esc>o', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-CR>', '<Esc>O', { noremap = true, silent = true })
-- 使用Alt+Enter 在下一行插入新行並保持 Insert 模式
vim.api.nvim_set_keymap('i', '<A-CR>', '<Esc>o', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-S-CR>', '<Esc>O', { noremap = true, silent = true }) -- xterm-256color 吃不到shift

-- 處理剪貼簿習慣對應（在Insert模式可使用慣用的快速鍵）
vim.opt.keymodel = "startsel" -- 啟用 Shift + 方向鍵選取功能
vim.api.nvim_set_keymap('i', '<C-v>', '<Esc>"+pa', { noremap = true, silent = true }) -- Insert Mode 下的 Ctrl+V 貼上
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true, silent = true }) -- Visual Mode 下的 Ctrl+C 複製
vim.api.nvim_set_keymap('v', '<C-x>', '"+d', { noremap = true, silent = true }) -- Visual Mode 下的 Ctrl+X 剪下
vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true, silent = true }) -- Visual Mode 下的 Ctrl+V 貼上

-- 啟用 Tab 縮排
vim.api.nvim_set_keymap('n', '<TAB>', 'v>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', 'v<', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<TAB>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-TAB>', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-TAB>', '<C-d>', { noremap = true, silent = true }) -- Insert Mode 下的 Shift+Tab 退縮排

-- 透過 v 選取整行縮排後，不取消選取整行
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })
