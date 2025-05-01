return {
  {
    "fraso-dev/nvim-listchars",
    opts = true,
    event = "BufEnter",
    config = function()
      require("nvim-listchars").setup({
        save_state = true,      -- If enabled, save toggled state in a cache file. Will overwrite current `vim.opt.list` value.
        listchars = {           -- `listchars` to be displayed. See available options by running `:help listchars`
          tab = "> ",
          trail = "-",
          nbsp = "+",
          eol = "↲",
          space = "·",
        },
        notifications = true,   -- Enable or disable listchars notifications
        exclude_filetypes = {}, -- List of filetypes where `listchars` is disabled
        lighten_step = 5,       -- Amount to add/remove from base color
      })
    end,
  }
}
