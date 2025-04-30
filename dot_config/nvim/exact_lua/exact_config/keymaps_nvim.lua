-- 這個檔案是用來設定 Neovim 的鍵盤快捷鍵
local map = vim.keymap.set
-- konsole終端限制：
-- Esc 會送成 Ctrl+[
-- Ctrl+Enter 鍵會被視為 Ctrl+M (對策: 多增加相同功能的Ctrl+Alt+Enter)
-- <A-S-CR>

-- Ctrl+s 儲存
map("n", "<C-s>", "<cmd>write<CR>", { noremap = true, silent = true, desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>write<CR>a", { noremap = true, silent = true, desc = "Save file in insert mode" })

-- Tab切換
-- 現在由barbar控制，先停用
-- vim.api.nvim_set_keymap('n', '<A-l>', '<cmd>tabnext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-h>', '<cmd>tabprevious<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-RIGHT>', '<cmd>tabnext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-LEFT>', '<cmd>tabprevious<CR>', { noremap = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-A-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-A-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-A-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-A-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<C-A-Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-A-Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-A-Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-A-Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- 原始vim會佔用 <C-l> 快速鍵，導致上述跳窗鍵盤無法靈活此用，故將此按鍵改為 <leader>ur
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)
