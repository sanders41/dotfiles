local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
  print("error loading nvim-treesitter")
  return
end

treesitter.setup()

treesitter.install("all")

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Enable treesitter indentation (experimental) for all filetypes except python and yaml
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    if not vim.tbl_contains({ "python", "yaml" }, ev.match) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
