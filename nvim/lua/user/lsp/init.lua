local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  print("error loading lsp")
  return
end

require "user.lsp.configs"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
