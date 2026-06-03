if true then return {} end

return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
      animate = {
        enabled = true,
      },
      exit_when_last = true,
      keys = {
        -- 增加寬度 (Increase width)
        ["<C-w>>"] = function(win) win:resize("width", 3) end,
        -- 減少寬度 (Decrease width)
        ["<C-w><"] = function(win) win:resize("width", -3) end,
        -- 增加高度 (Increase height)
        ["<C-w>+"] = function(win) win:resize("height", 3) end,
        -- 減少高度 (Decrease height)
        ["<C-w>-"] = function(win) win:resize("height", -3) end,
      },
      left = {
        {
          title = "Neo-Tree Filesystem",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = "Neotree position=current filesystem",
        },
        {
          title = "Neo-Tree Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          open = "Neotree position=current buffers",
        },
        {
          title = "Neo-Tree Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=current git_status",
        },
        {
          title = "Neo-Tree Symbols",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "document_symbols"
          end,
          pinned = true,
          open = "Neotree position=current document_symbols",
        },
      },
      bottom = {
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
      },
    },
    config = function(_, opts)
      require("edgy").setup(opts)
    end,
  },
}
