 vim.g.rustaceanvim = function()
   return {
     server = {
       on_attach = require("user.lsp.handlers").on_attach,
       capabilities = require("user.lsp.handlers").capabilities,
     },
   }
 end
