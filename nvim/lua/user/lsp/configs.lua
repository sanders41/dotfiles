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

local servers = { "pyright", "ts_ls" }
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

vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set(
        "n",
        "<leader>a",
        function()
          vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
          -- or vim.lsp.buf.codeAction() if you don't want grouping.
        end,
        { silent = true, buffer = bufnr }
      )
      vim.keymap.set(
        "n",
        "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
        function()
          vim.cmd.RustLsp({'hover', 'actions'})
        end,
        { silent = true, buffer = bufnr }
      )     -- you can also put keymaps in here
    end,
  },
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
