local function get_python_formatter()
  -- 2>&1 to also capture stderr
  local status_ok, python_packages = pcall(io.popen, "pip freeze 2>&1")
  if not status_ok then
    if python_packages ~= nil then
      python_packages:close()
    end
    return
  end
  if python_packages ~= nil then
    local black = false
    local isort = false
    local ruff = false
    for package in python_packages:lines() do
      if string.find(package, "ERROR:") then
        python_packages:close()
        return
      elseif string.find(package, "black") then
        black = true
      elseif string.find(package, "isort") then
        isort = true
      elseif string.find(package, "ruff") then
        ruff = true
      end

      if black and isort and ruff then
        break
      end
    end

    python_packages:close()

    local packages = {}
    if isort then
      table.insert(packages, "isort")
    end

    if ruff then
      table.insert(packages, "ruff_fix")

      if black then
        table.insert(packages, "black")
      else
        table.insert(packages, "ruff_format")
      end
    elseif black then
      table.insert(packages, "black")
    end

    if next(packages) == nil then
      return
    end

    return packages
  end
end

local formatters = {
  css = { { "prettierd", "prettier" } },
  go = { "gofmt" },
  html = { { "prettierd", "prettier" } },
  javascript = { { "prettierd", "prettier" } },
  lua = { "stylua" },
  markdown = { { "prettierd", "prettier" } },
  rust = { "rustfmt" },
  typescript = { { "prettierd", "prettier" } },
  yaml = { { "prettierd", "prettier" } },
}

local python_formatter = get_python_formatter()

if python_formatter ~= nil then
  formatters.python = python_formatter
end

require("conform").setup({
  formatters_by_ft = formatters,
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
