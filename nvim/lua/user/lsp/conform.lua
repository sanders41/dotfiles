require("conform").setup({
  formatters_by_ft = {
    css = { { "prettierd", "prettier" } },
    go = { "gofmt" },
    html = { { "prettierd", "prettier" } },
    javascript = { { "prettierd", "prettier" } },
    just = { "just" },
    lua = { "stylua" },
    markdown = { { "prettierd", "prettier" } },
    python = { "ruff", "black" },
    rust = { "rustfmt" },
    typescript = { { "prettierd", "prettier" } },
    yaml = { { "prettierd", "prettier" } },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
