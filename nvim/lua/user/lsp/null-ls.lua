local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  print("error loading null-ls")
  return
end

local function line_length()
  local length = os.getenv("LINELENGTH")

  if length then
    return length
  end

  return "100"
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with { filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "svelte",
      "less",
      "html",
      "json",
      "jsonc",
    }},
    formatting.black,
    formatting.gofmt.with { extra_args = { "-w" } },
    formatting.rustfmt,
    formatting.ruff.with {
      extra_args = {
        "--select=I001",
        string.format("--line-length=%s", line_length())
      }
    },
    diagnostics.markdownlint,
    diagnostics.mypy,
  },

  on_attach = function(client)
    -- if client.resolved_capabilities.document_formatting then
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
      ]])
    end
  end,
}
