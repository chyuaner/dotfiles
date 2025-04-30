return {
  "lambdalisue/suda.vim",
  lazy = true,
  cmd = { "SudaRead", "SudaWrite" },
  config = function()
    vim.g.suda_smart_edit = 1
  end,
  keys = {
    { "<leader>e", "<cmd>SudaRead<cr>", desc = "Edit with sudo" },
  },
}
