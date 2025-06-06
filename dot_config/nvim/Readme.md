Yuan Neovim 備忘
===
## 依賴的套件
* ripgrep 全文搜尋用
* tree-sitter 快速且增量式的語法剖析器（parser）
* tree-sitter-bash
* tree-sitter-cli
* imagemagick
* ueberzugpp

## 基本快速鍵

### 重要鍵
* leader key: `\`
* window key: `ctrl+w`
    * move cursor: <window>(方向鍵)

### 擴充自行設定的快速鍵
* `<F6>` 可以回朔到開啟檔案以來的任何歷史，還會標出修改的地方
* `<F7>` 看看你設定了哪些變數、函數，也可以快速跳轉
* `<F8>`: NeoTree: 查看已經開啟的檔案
* `<F9>`: NeoTree
* `<F10>`: git status
* `<leader>fT`: 浮動NeoTree
* `<leader>fB`: 已開啟的檔案

### 編輯習慣（已經覆寫）
* shift+方向鍵(傳統): 選取文字（傳統習慣）
    * PS. 不能用jk是因為 shift+j shift+k有被其他功能綁定，不覆寫是想順便習慣vim用法
* alt+方向鍵(傳統/jk)：移動整行
* ctrl+alt+shaft+方向鍵(傳統/jk)：向上/向下複製整行
* tab縮排(含輸入模式的shift+tab傳統習慣對應)

#### 剪貼簿
* 輸入模式
    * ctrl+v: 貼上
* 選取模式
    * ctrl+x: 剪下
    * ctrl+c: 複製
    * ctrl+v: 取代貼上

## 基本Command

* :Neotree float git_status git_base=main
* :verbose map <C-,>
* echo getchar()

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

## LSP -Language Server Protocol
因為設定方式與結構太過複雜，故獨立開

### 和LSP有關的目錄結構
```
~/.config/nvim/
├── lua/
│   ├── plugins/
│   │   ├── lsp.lua               <-- 所有 LSP / cmp 相關 plugin 定義
│   ├── lsp/
│   │   ├── init.lua              <-- 初始化 Mason / LSP 等
│   │   ├── config/
│   │   │   ├── mason.lua         <-- 1. Mason 設定，需要的程式語言安裝都在這定義
│   │   │   ├── lspconfig.lua     <-- 2. 載入各語言的設定
│   │   │   └── cmp.lua           <-- nvim-cmp 設定
│   │   └── servers/
│   │       ├── php.lua
│   │       ├── pyright.lua
│   │       └── ...
│   └──（可另外有 config/、keymaps/ 等其他模組）
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
