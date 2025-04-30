-- if true then return {} end -- 暫時停用

return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function(_, opts)

      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },

        -- Optional: add any additional configuration here
        views = {
          cmdline_popup = {
            border = {
              style = "rounded", -- 邊框樣式，可選 "none", "single", "double", "rounded", "solid", "shadow"
              padding = { 1, 4 }, -- 邊框內的填充（上、右、下、左）
            },
            win_options = {
              winblend = 10, -- 增加透明度，模擬陰影效果
              winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder", -- 高亮設定
            },
          },
          popupmenu = {
            border = {
              -- noice.nvim 支援以下邊框樣式：
              -- * `"none"`：無邊框。
              -- * `"single"`：單線邊框。
              -- * `"double"`：雙線邊框。
              -- * `"rounded"`：圓角邊框。
              -- * `"solid"`：實心邊框。
              -- * `"shadow"`：陰影效果。
              style = "rounded", -- 這裡可以設定不同的樣式
              pshadowadding = { 1, 1 }, -- 調整內部填充
            },
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "regex" }, -- 確保安裝 regex 支援
        highlight = {
          enable = true, -- 啟用高亮
        },
      })
    end,
  }
}
