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
    lualine_b = {{"filename", path=2}, "branch", "diff", "diagnostics"},
    lualine_c = {},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {"progress"},
    lualine_z = {"location"},
  },
})
