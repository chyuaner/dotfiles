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

      -- Function to determine file permissions and appropriate background color
      local function get_permissions_color()
        local file = vim.fn.expand("%:p")

        if file == "" or file == nil then
          return "No File", "#3B4252" -- Default blue for no or non-existing file
        else
          local permissions = vim.fn.getfperm(file)
          -- Check only the first three characters for 'rwx' to determine owner permissions
          local owner_permissions = permissions:sub(1, 3)
          -- Green for owner 'rwx', blue otherwise
          return permissions, owner_permissions == "rwx" and "#456d23" or "#3B4252"
        end
      end

      return {
        options = {
          icons_enabled = true,
          theme = 'onedark',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {
              'Avante',
              'AvanteSelectedFiles',
            },
            winbar = {},
            {
              'undotree',
              'AvanteInput',
            }
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
          lualine_x = {
            {
              function()
                local permissions, _ = get_permissions_color() -- Ignore bg_color here if unused
                return permissions
              end,
              color = function()
                local _, bg_color = get_permissions_color() -- Use bg_color for dynamic coloring
                return { fg = fg_color, bg = bg_color, gui = "bold" }
              end,
              -- separator = { left = "", right = "" },
              -- separator = { left = "", right = "" },
              -- separator = { left = "", right = "" },
              -- separator = { left = "", right = "" },
              -- separator = { left = "", right = "" },
              separator = { left = "", right = "" },
              -- separator = { left = "", right = "" },
              -- separator = { left = "", right = "" },
              padding = 1,
            },
            'encoding', 'fileformat', 'filetype'
          },
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
