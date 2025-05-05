return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  init_options = {
    typescript = {
      tsdk = ""
    }
  },
  root_markers = { "package.json" },
}
