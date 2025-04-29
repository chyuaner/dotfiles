-- 這個檔案是用來設定 Neovim 的鍵盤快捷鍵
local map = vim.keymap.set

-- Tab切換
-- vim.api.nvim_set_keymap('n', '<A-l>', '<cmd>tabnext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-h>', '<cmd>tabprevious<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-RIGHT>', '<cmd>tabnext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-LEFT>', '<cmd>tabprevious<CR>', { noremap = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<C-Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- 原始vim會佔用 <C-l> 快速鍵，導致上述跳窗鍵盤無法靈活此用，故將此按鍵改為 <leader>ur
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)
