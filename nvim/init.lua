local set = vim.opt

require 'user.options'
require 'user.keymaps'
require 'user.plugins'
require 'user.treesitter'
require 'user.toggleterm'
require 'user.bufferline'
require 'user.lualine'
require 'user.nvim_cmp'
require 'user.nvim_tree'
require 'user.gitsigns'
require 'user.lsp'

vim.g.vscode_style = 'dark'

set.shell = 'zsh --login'
