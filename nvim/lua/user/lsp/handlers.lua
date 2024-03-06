local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      -- focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  -- local opts = { noremap = true, silent = true }
  local function buf_set_keymap(keys, func, desc)
    vim.api.nvim_buf_set_keymap(bufnr, "n", keys, func, { desc = desc })
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration")
  buf_set_keymap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
  buf_set_keymap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover documentation")
  buf_set_keymap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation")
  buf_set_keymap("<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace folder")
  buf_set_keymap("<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove workspace folder")
  buf_set_keymap(
    "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List workspace folders"
  )
  buf_set_keymap("<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definitions")
  buf_set_keymap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename vairable")
  buf_set_keymap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action")
  buf_set_keymap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Go to reference")
  buf_set_keymap("<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", "Show diagnostics")
  buf_set_keymap("[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Go to previous diagnostic")
  buf_set_keymap("]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Go to next diagnostic")
  vim.cmd [[ command! Format execute "lua vim.lsp.buf.formatting()" ]]
end

M.on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  if client.name == "tsserver" or client.name == "rust_analyzer" then
    client.server_capabilities.documentFormatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  print("error loading cmp_nvim_lsp")
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities()

return M
