-- if true then return {} end
return {
  { "nvzone/volt" , lazy = true },
  {
    "nvzone/menu",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-neo-tree/neo-tree.nvim"
    },
    event = "VeryLazy",
    config = function()
      -- Keyboard users
      vim.keymap.set("n", "<C-t>", function()
        require("menu").open("default")
      end, {})

      -- mouse users + nvimtree users!
      vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
        require('menu.utils').delete_old_menus()

        vim.cmd.exec '"normal! \\<RightMouse>"'

        -- clicked buf
        local mouse = vim.fn.getmousepos()
        local buf = vim.api.nvim_win_get_buf(mouse.winid)
        local ft = vim.bo[buf].ft
        local gitsigns = require("gitsigns")
        local hunks = gitsigns.get_hunks and gitsigns.get_hunks(buf)

        local in_signcolumn = mouse.wincol <= vim.fn.getwininfo(mouse.winid)[1].textoff
        local is_git_buf = vim.b[buf].gitsigns_head ~= nil
        local has_hunks = hunks and #hunks > 0

        local options
        if ft == "neo-tree" then
          options = "neo-tree"
        elseif in_signcolumn and is_git_buf and has_hunks then
          options = "gitsigns"
        else
          options = "default"
        end

        -- -- Debug用途
        -- local name = vim.api.nvim_buf_get_name(buf)
        -- local lsp = vim.lsp.get_clients({ bufnr = buf })
        -- vim.notify("👉 Buffer: " .. buf ..
        --   "\nFile: " .. name ..
        --   "\nFiletype: " .. ft ..
        --   "\nGitsigns Head: " .. vim.inspect(vim.b[buf].gitsigns_head) ..
        --   "\nHas Hunks: " .. tostring(has_hunks) ..
        --   "\nMouse Col: " .. mouse.wincol ..
        --   "\nText Offset: " .. vim.fn.getwininfo(mouse.winid)[1].textoff ..
        --   "\nIn SignColumn: " .. tostring(in_signcolumn) ..
        --   "\nLSP: " .. tostring(#lsp > 0) ..
        --   "\n🧭 Menu: " .. options, vim.log.levels.INFO
        -- )
        require("menu").open(options, { mouse = true })
      end, {})

    end,
  },
}
