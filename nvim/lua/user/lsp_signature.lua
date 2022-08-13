local status_ok, lsp_signature = pcall(require, "lsp_signature")
if not status_ok then
  print('error loading lsp_signature')
  return
end

lsp_signature.on_attach({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  }
})
