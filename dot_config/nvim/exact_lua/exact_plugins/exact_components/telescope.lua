-- if true then return {} end
return {
  -- 'nvim-telescope/telescope.nvim', tag = '0.1.8',
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },

  lazy = false,
  keys = {
    { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },

    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
  },
}
