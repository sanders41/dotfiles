local function python_formatter()
  local status_ok, python_packages = pcall(io.popen, "pip freeze")
  if not status_ok then
    if python_packages ~= nil then
      python_packages:close()
    end
    return
  end
  if python_packages ~= nil then
    local black = false
    local ruff = false
    for package in python_packages:lines() do
      if string.find(package, "black") then
        black = true
      end

      if string.find(package, "ruff") then
        ruff = true
      end

      if black and ruff then
        break
      end
    end

    python_packages:close()

    if black and ruff then
      return { "ruff_fix", "black" }
    elseif black then
      return { "black" }
    elseif ruff then
      return { "ruff_fix", "ruff_format" }
    end
  else
    return
  end
end

require("conform").setup({
  formatters_by_ft = {
    css = { { "prettierd", "prettier" } },
    go = { "gofmt" },
    html = { { "prettierd", "prettier" } },
    javascript = { { "prettierd", "prettier" } },
    lua = { "stylua" },
    markdown = { { "prettierd", "prettier" } },
    python = python_formatter(),
    rust = { "rustfmt" },
    typescript = { { "prettierd", "prettier" } },
    yaml = { { "prettierd", "prettier" } },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
