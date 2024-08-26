local lint = require("lint")

lint.linters.eslint_d = require("lint.util").wrap(lint.linters.eslint_d, function(diagnostic)
      -- try to ignore "No ESLint configuration found" error
      -- if diagnostic.message:find("Error: No ESLint configuration found") then -- old version
      -- update: 20240814, following is working
      if diagnostic.message:find("Error: Could not find config file") then
        return nil
      end
      return diagnostic
    end)

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  lua = { "luacheck" },
  markdown = { "markdownlint" },
  python = { "mypy", "ruff" },
  svelte = { "eslint_d" },
  typescript = { "eslint_d" },
  yaml = { "yamllint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
