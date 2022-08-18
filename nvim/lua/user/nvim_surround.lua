local status_ok, nvim_surround = pcall(require, "nvim-surround")
if not status_ok then
  print('error loading nvim-surround')
  return
end

nvim_surround.setup({})
