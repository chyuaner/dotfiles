if true then return {} end -- 停用

-- 查看說明：
-- nvim +"help bufferline" +only

return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup{
        options = {
          mode = "buffers",
          custom_filter = function(buf_number)
            local buf_ft = vim.bo[buf_number].filetype
            if buf_ft == "toggleterm" then
              return false
            end
            return true
          end,
          click_callback = function(buf_number)
            local buf_ft = vim.bo[buf_number].filetype
            if buf_ft == "toggleterm" then
              -- 如果是 toggleterm 的 Buffer，阻止切換
              print("Cannot switch to terminal buffer!")
              return
            end
            -- 否則切換到目標 Buffer
            vim.api.nvim_set_current_buf(buf_number)
          end,
          -- custom_filter = function(buf_number)
          --   -- 過濾掉 toggleterm 的終端 Buffer
          --   local buf_name = vim.fn.bufname(buf_number)
          --   if buf_name:match("term://") then
          --     return false
          --   end
          --   return true
          -- end,
          -- offsets = {
          --   {
          --     filetype = "neo-tree",
          --     text = function()
          --       return vim.fn.getcwd()
          --     end,
          --     highlight = "Directory",
          --     text_align = "left"
          --   }
          -- }
        }
      }
    end,
  }
}
