local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  print("error loading null-ls")
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with { extra_args = { "--single-quote" } },
    formatting.black.with { extra_args = { "--line-length=100" } },
    formatting.isort.with { extra_args = { "--profile=black", "--line-length=100" } },
    formatting.rustfmt,
    diagnostics.flake8.with {
      extra_args = {
        "--ignore=E203,E231,E501,D100,D101,D102,D103,D104,D105,D106,D107,D401",
        "--max-line-length=100",
      },
    },
    diagnostics.mypy,
    diagnostics.markdownlint,
  },

  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
      ]])
    end
  end,
}
