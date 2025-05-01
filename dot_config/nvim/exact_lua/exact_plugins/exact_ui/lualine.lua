-- if true then return {} end -- 暫時停用

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    opts = function()

      -- 選擇計數格式
      local function selectionCount()
        local mode = vim.fn.mode()
        if not mode:find("[Vv]") then return "" end -- 僅在 Visual 模式下顯示
        local starts = vim.fn.line("v")
        local ends = vim.fn.line(".")
        local lines = math.abs(ends - starts) + 1
        local chars = vim.fn.wordcount().visual_chars or 0
        return string.format("📏 %dL %dC", lines, chars)
      end

      -- 自定義 location 格式
      local function customLocation()
        local location = vim.api.nvim_eval_statusline("%l:%c", {}).str -- 獲取行和列
        return "📍 " .. location -- 在字首添加 emoji
      end

      return {
        options = {
          icons_enabled = true,
          theme = 'onedark',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
            {'undotree'}
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {{ selectionCount }, { customLocation },}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {{ customLocation }},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {'neo-tree', 'toggleterm'}
      }
    end,
    -- config = function(_, opts)
    --   require('lualine').setup(opts)
    -- end,
  },
}
