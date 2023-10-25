require("conform").setup({
  formatters_by_ft = {
    css = { { "prettierd", "prettier" } },
    go = { "gofmt" },
    html = { { "prettierd", "prettier" } },
    javascript = { { "prettierd", "prettier" } },
    lua = { "stylua" },
    markdown = { { "prettierd", "prettier" } },
    python = { "ruff", "ruff-format" },
    rust = { "rustfmt" },
    typescript = { { "prettierd", "prettier" } },
    yaml = { { "prettierd", "prettier" } },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
