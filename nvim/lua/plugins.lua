local cmd = vim.cmd

cmd [[packadd packer.nvim]]


return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'Mofiqul/vscode.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
  }
  use 'airblade/vim-gitgutter'
  use 'hoob3rt/lualine.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'tpope/vim-fugitive'
  use 'mhartington/formatter.nvim'
  use 'cespare/vim-toml'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'simrat39/rust-tools.nvim'
  use 'rust-lang/rust.vim'
end)
