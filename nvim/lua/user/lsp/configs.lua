local status_ok, mason = pcall(require, "mason")
if not status_ok then
  print("error loading mason")
  return
end

local function line_length()
  local length = os.getenv("LINELENGTH")

  if length then
    return length
  end

  return "100"
end

local servers = { "pyright" }
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

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
  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end

-- Explicit ts_ls configuration with corrected root_dir to fix nvim-lspconfig bug
vim.lsp.config("ts_ls", {
  on_attach = custom_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  root_dir = function(bufnr, on_dir)
    local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
      or vim.list_extend(root_markers, { '.git' })
    local deno_path = vim.fs.root(bufnr, { 'deno.json', 'deno.lock' })
    -- FIX: Remove extra braces to prevent triple-nesting bug
    local project_root = vim.fs.root(bufnr, root_markers)
    -- Exclude deno projects
    if deno_path and (not project_root or #deno_path >= #project_root) then
      return
    end
    on_dir(project_root or vim.fn.getcwd())
  end,
})
vim.lsp.enable("ts_ls")

vim.lsp.config("lua_ls", {
  on_attach = custom_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
    },
  },
})

vim.lsp.config("ruff", {
  on_attach = custom_attach,
  init_options = {
    settings = {
      args = {
        string.format("--line-length=%s", line_length()),
      },
    },
  }
})
vim.lsp.enable("ruff")

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})
