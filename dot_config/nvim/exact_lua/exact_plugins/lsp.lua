-- 專責 LSP / 補全相關 plugin 定義
return {
  -- 依照mason官方教學抄過來 https://github.com/williamboman/mason-lspconfig.nvim
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  -- 補全相關
  -- 以下為 hrsh7th/nvim-cmp 的官方範例
  -- call plug#begin(s:plug_dir)
  -- Plug 'neovim/nvim-lspconfig'
  -- Plug 'hrsh7th/cmp-nvim-lsp'
  -- Plug 'hrsh7th/cmp-buffer'
  -- Plug 'hrsh7th/cmp-path'
  -- Plug 'hrsh7th/cmp-cmdline'
  -- Plug 'hrsh7th/nvim-cmp'

  -- " For vsnip users.
  -- Plug 'hrsh7th/cmp-vsnip'
  -- Plug 'hrsh7th/vim-vsnip'

  -- " For luasnip users.
  -- " Plug 'L3MON4D3/LuaSnip'
  -- " Plug 'saadparwaiz1/cmp_luasnip'

  -- " For mini.snippets users.
  -- " Plug 'echasnovski/mini.snippets'
  -- " Plug 'abeldekat/cmp-mini-snippets'

  -- " For ultisnips users.
  -- " Plug 'SirVer/ultisnips'
  -- " Plug 'quangnguyen30192/cmp-nvim-ultisnips'

  -- " For snippy users.
  -- " Plug 'dcampos/nvim-snippy'
  -- " Plug 'dcampos/cmp-snippy'

  -- call plug#end()
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/nvim-cmp" },

  -- " For luasnip users.
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  { "rafamadriz/friendly-snippets" },

  { "onsails/lspkind.nvim",
    lazy = true,
  }
}
