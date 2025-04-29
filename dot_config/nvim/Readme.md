Yuan Neovim 備忘
===

## 基本快速鍵

重要鍵
* leader key: `\`
* window key: `ctrl+w`
    * move cursor: <window>(方向鍵)

擴充自行設定的快速鍵
* `F9`: NeoTree

編輯習慣（已經覆寫）
*

## 基本Command

* :Neotree float git_status git_base=main

## 資料夾結構

```
dot_config/nvim
├── init.vim #主要設定進入點 傳統vim設定檔 (傳統語法兼容用)
├── lua
│   ├── init.lua #主要設定進入點 新式給nvim專用設定
│   ├── config
│   │   ├── gui.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       └── example.lua #LazyNvim給的範例，已經被第一段截斷掉，所以此腳本將不會執行
└── Readme.md
```

## 代找外掛
 * Align
 *

## neo-tree

```
{ "<F9>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
{ "<leader>e", "<Cmd>Neotree reveal<CR>" },
{ "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
{ "<leader>fT", "<cmd>Neotree float<cr>", desc = "NeoTree Float" },
{ "<leader>fF", "<cmd>Neotree filesystem float<cr>", desc = "NeoTree Filesystem Float" },
{ "<leader>fG", "<cmd>Neotree git_status float<cr>", desc = "NeoTree Git Status Float" },
{ "<leader>fB", "<cmd>Neotree buffers float<cr>", desc = "NeoTree Buffers Float" }
```

在當前NeoTree視窗
* `P`: 預覽開關
