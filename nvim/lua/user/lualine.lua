local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  print("error loading lualine")
  return
end

lualine.setup({
  options = {
    theme = "tokyonight",
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff", "diagnostics"},
    lualine_c = {{"filename", path=2}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {"progress"},
    lualine_z = {"location"},
  },
})
