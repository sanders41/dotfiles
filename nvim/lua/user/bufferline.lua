local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  print("error loading bufferline")
  return
end

bufferline.setup {
  options = {
    numbers = "none",
    close_command = "Bdelete! %d",
    buffer_close_icon = 'x',
    right_mouse_command = "Bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    diagnostics = false, -- | "nvim_lsp"
    diagnostics_update_in_insert = false,
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    persist_buffer_sort = true,
    separator_style = "thin", -- | "thick" | "thin" | { "any", "any" },
    enforce_regular_tabs = true,
  }
}
