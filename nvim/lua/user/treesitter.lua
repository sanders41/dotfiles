local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print("error loading treesitter")
  return
end

configs.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- Parsers to ignore. M1 Macs currently have an issue with phpdoc
  autopairs = {
    enable = false,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "python",  "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

require("tree-sitter-just").setup({})
