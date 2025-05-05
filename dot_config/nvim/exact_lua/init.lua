vim.g.suda_smart_edit = 1
require("config.options")
require("config.keymaps_nvim")
require("config.keymaps")
require("config.gui")
require("config.lazy")     -- 初始化 Lazy.nvim
require("lsp")             -- LSP 與 cmp 設定
require("config.terminal") -- 因為會被lazy.nvim override，所以要放在最後
