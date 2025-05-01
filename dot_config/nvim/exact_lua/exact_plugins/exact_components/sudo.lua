return {
  "lambdalisue/suda.vim",
  lazy = false,
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    { "<leader>e", "<cmd>SudaRead<cr>", desc = "Edit with sudo" },
  },
}
