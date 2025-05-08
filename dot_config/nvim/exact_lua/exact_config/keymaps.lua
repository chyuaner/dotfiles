-- 這個檔案是依據自己之前在vscode的編輯習慣，用來設定editor的鍵盤快捷鍵

local map = vim.keymap.set
local neomap = vim.api.nvim_set_keymap

vim.keymap.set("n", "c", [["_c]], { noremap = true })
vim.keymap.set("n", "C", [["_C]], { noremap = true })
vim.keymap.set("n", "d", [["_d]], { noremap = true })
vim.keymap.set("n", "x", [["_x]], { noremap = true })

-- 處理剪貼簿習慣對應（在Insert模式可使用慣用的快速鍵）
vim.opt.keymodel = "startsel" -- 啟用 Shift + 方向鍵選取功能
neomap('n', '<C-a>', 'ggVG', { noremap = true, silent = true })
neomap('i', '<C-a>', '<Esc>ggVG', { noremap = true, silent = true })
neomap('i', '<C-v>', '<Esc>"+pa', { noremap = true, silent = true }) -- Insert Mode 下的 Ctrl+V 貼上
neomap('v', '<C-c>', '"+y', { noremap = true, silent = true }) -- Visual Mode 下的 Ctrl+C 複製
neomap('v', '<C-x>', '"+d', { noremap = true, silent = true }) -- Visual Mode 下的 Ctrl+X 剪下
neomap('v', '<C-v>', '"+p', { noremap = true, silent = true }) -- Visual Mode 下的 Ctrl+V 貼上

-- 單字的左右移動
neomap('n', '<C-Right>', 'w', { noremap = true, silent = true })
neomap('n', '<C-Left>', 'b', { noremap = true, silent = true })
neomap('n', '<C-S-Right>', 'W', { noremap = true, silent = true })
neomap('n', '<C-S-Left>', 'B', { noremap = true, silent = true })
-- 在 Insert 模式下，Ctrl + Shift + 方向鍵移動並選取單詞
vim.api.nvim_set_keymap('i', '<C-S-Right>', '<Esc>v<C-o>w<C-o>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-Left>', '<Esc>v<C-o>b<C-o>i', { noremap = true, silent = true })

-- 整行移動的快速鍵
neomap('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
neomap('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
neomap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
neomap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
neomap('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
neomap('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- 使用 Alt+方向鍵 移動整行
neomap('n', '<A-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
neomap('n', '<A-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
neomap('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
neomap('i', '<A-Up>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
neomap('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
neomap('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- Ctrl+Alt+Shift+j/k 複製整行並向下/向上貼上
neomap('n', '<C-A-S-j>', 'yyp', { noremap = true, silent = true })
neomap('n', '<C-A-S-k>', 'yyP', { noremap = true, silent = true })
-- Ctrl+Alt+Shift+方向鍵 複製整行並向下/向上貼上
neomap('n', '<C-A-S-Down>', 'yyp', { noremap = true, silent = true })
neomap('n', '<C-A-S-Up>', 'yyP', { noremap = true, silent = true })
neomap('i', '<C-A-S-Down>', '<Esc>yypgi', { noremap = true, silent = true })
neomap('i', '<C-A-S-Up>', '<Esc>yyPgi', { noremap = true, silent = true })

-- -- 處理不同終端的行為
-- -- 在 Insert Mode 下的 Ctrl+Enter 在下一行插入新行並保持 Insert 模式
-- local term = vim.fn.getenv("TERM")
-- local term_program = vim.fn.getenv("TERM_PROGRAM")
-- if term_program == "iTerm.app" then
--     -- iTerm 的快捷鍵設置
--     neomap('i', '<C-CR>', '<Esc>o', { noremap = true, silent = true })
--     neomap('i', '<C-S-CR>', '<Esc>O', { noremap = true, silent = true })
-- elseif term == "alacritty" then
--     -- Alacritty 的快捷鍵設置
--     neomap('i', '<C-CR>', '<Esc>o', { noremap = true, silent = true })
--     neomap('i', '<C-S-CR>', '<Esc>O', { noremap = true, silent = true })
-- elseif term == "xterm-256color" then
--     -- xterm-256color 的快捷鍵設置
--     neomap('i', '<A-CR>', '<Esc>o', { noremap = true, silent = true })
--     neomap('i', '<A-S-CR>', '<Esc>O', { noremap = true, silent = true })
-- end

-- 使用Ctrl(Alt)+Enter 在下一行插入新行並保持 Insert 模式
-- 檢查 $TERM 或 $TERM_PROGRAM 的值
-- Alacritty, GUI(Neovide, Goneovim) 皆可
-- xterm-256color採用程式: Konsole, iTerm2, gnome-terminal 會有按鍵吃不到的問題，詳下述註解：
-- 使用Ctrl+Enter 在下一行插入新行並保持 Insert 模式（xterm-256color 吃不到）
neomap('i', '<C-CR>', '<Esc>o', { noremap = true, silent = true })
neomap('i', '<C-S-CR>', '<Esc>O', { noremap = true, silent = true })
-- 使用Alt+Enter 在下一行插入新行並保持 Insert 模式
neomap('i', '<A-CR>', '<Esc>o', { noremap = true, silent = true })
neomap('i', '<A-S-CR>', '<Esc>O', { noremap = true, silent = true }) -- xterm-256color 吃不到shift

-- 啟用 Tab 縮排
neomap('n', '<TAB>', 'v>', { noremap = true, silent = true })
neomap('n', '<S-TAB>', 'v<', { noremap = true, silent = true })
neomap('v', '<TAB>', '>gv', { noremap = true, silent = true })
neomap('v', '<S-TAB>', '<gv', { noremap = true, silent = true })
neomap('i', '<S-TAB>', '<C-d>', { noremap = true, silent = true }) -- Insert Mode 下的 Shift+Tab 退縮排

-- 透過 v 選取整行縮排後，不取消選取整行
neomap('v', '<', '<gv', { noremap = true, silent = true })
neomap('v', '>', '>gv', { noremap = true, silent = true })

-- 自動折行開關切換
map("n", "<A-z>", "<cmd>set wrap!<CR>", { noremap = true, silent = true, desc = "Toggle Auto Wrap Line" })
map("i", "<A-z>", "<Esc><cmd>set wrap!<CR>a", { noremap = true, silent = true, desc = "Toggle Auto Wrap Line" })
