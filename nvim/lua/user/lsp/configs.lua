local status_ok, mason = pcall(require, "mason")
if not status_ok then
  print("error loading mason")
  return
end

local lspconfig = require("lspconfig")
-- local servers = { "gopls", "pyright", "rust_analyzer", "lua_ls" }
local servers = { "gopls", "pyright", "lua_ls" }
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

local capabilities = require("user.lsp.handlers").capabilities
local custom_attach = require("user.lsp.handlers").on_attach

for _, server in pairs(servers) do
  local opts = {
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end

local rt = require("rust-tools")

rt.setup({
  server = {
    -- on_attach = function(_, bufnr)
    on_attach = custom_attach,
    capabilities = capabilities,
    flags = lsp_flags
  },
  tools = {
    inlay_hints = {
      auto = false,
    },
  },
})
