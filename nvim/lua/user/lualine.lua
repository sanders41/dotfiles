local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  print('error loading lualine')
  return
end

lualine.setup({
  options = {
    theme = 'vscode',
  },
  sections = {
    lualine_a = {{'filename', path = 2}},
    lualine_b = {'branch', 'diff'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
})
