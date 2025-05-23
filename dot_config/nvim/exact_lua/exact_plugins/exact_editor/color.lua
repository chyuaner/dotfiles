return {
  -- 單純顯示顏色
  -- 不過以下ccc.nvim與oklch-color-picker.nvim都有此功能，故關閉
  {
    'norcalli/nvim-colorizer.lua',
    lazy = false,
    config = function()
      -- Attaches to every FileType mode
      require 'colorizer'.setup()

      -- require("colorizer").setup({
      --   '*'; -- Highlight all files, but customize some others.
      --   '!vim'; -- Exclude vim from highlighting.
      --   '!markdown'; -- Exclude markdown from highlighting.
      --   '!text'; -- Exclude text from highlighting.
      --   '!html'; -- Exclude html from highlighting.
      --   '!css'; -- Exclude css from highlighting.
      --   '!javascript'; -- Exclude javascript from highlighting.
      --   '!typescript'; -- Exclude typescript from highlighting.
      -- }, {
      --   RGB = true;         -- #RGB hex codes
      --   RRGGBB = true;     -- #RRGGBB hex codes
      --   names = false;     -- "Name" codes like Blue or blue
      --   RRGGBBAA = true;   -- #RRGGBBAA hex codes
      --   rgb_fn = true;     -- CSS rgb() and rgba() functions
      --   hsl_fn = true;     -- CSS hsl() and hsla() functions
      -- })
    end,
  },
  { "nvzone/volt", lazy = true },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
    keys = {
      {
        "<leader>v", "<cmd>Huefy<cr>", desc = "Color pick under cursor"
      },
    },
  }

  -- {
  --   "uga-rosa/ccc.nvim",
  --   lazy = false,
  --   cmd = "CccPick",
  --   keys = {
  --     {
  --       "<leader>v", "<cmd>CccPick<cr>", desc = "Color pick under cursor"
  --     },
  --   },
  --   config = function()
  --     -- Enable true color
	 --    vim.opt.termguicolors = true
  --
  --     local ccc = require("ccc")
  --     local mapping = ccc.mapping
  --
  --     ccc.setup({
  --       -- Your preferred settings
  --       -- Example: enable highlighter
  --       highlighter = {
  --         auto_enable = true,
  --         lsp = true,
  --       },
  --       inputs = {
  --         ccc.input.rgb,
  --         ccc.input.hsl,
  --         ccc.input.cmyk,
  --
  --       }
  --     })
  --   end,
  -- }

  -- {
  --   "eero-lehtinen/oklch-color-picker.nvim",
  --   enabled = require("tools.gui").is_graphical(),
  --   event = "VeryLazy",
  --   version = "*",
  --   keys = {
  --     -- One handed keymap recommended, you will be using the mouse
  --     {
  --       "<leader>v",
  --       function() require("oklch-color-picker").pick_under_cursor() end,
  --       desc = "Color pick under cursor",
  --     },
  --   },
  --   ---@type oklch.Opts
  --   opts = {},
  -- },

}
