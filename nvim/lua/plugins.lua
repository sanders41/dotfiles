local cmd = vim.cmd

cmd [[packadd packer.nvim]]


return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim' -- Used by a lot of plugins
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
  use "akinsho/bufferline.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "moll/vim-bbye"
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'tpope/vim-fugitive'
  use 'mhartington/formatter.nvim'
  use 'cespare/vim-toml'
  use 'nvim-telescope/telescope.nvim'
  use 'simrat39/rust-tools.nvim'
  use 'rust-lang/rust.vim'
end)
