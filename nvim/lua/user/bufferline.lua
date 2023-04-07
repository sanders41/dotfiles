local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  print("error loading bufferline")
  return
end

bufferline.setup {
   options = {
     numbers = "none",
     close_command = "Bdelete! %d",
     right_mouse_command = "Bdelete! %d",
     left_mouse_command = "buffer %d",
     middle_mouse_command = nil,
  },
}
