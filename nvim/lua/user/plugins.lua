local cmd = vim.cmd
local fn = vim.fn

-- Automatically install packer if not installed
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Makes packer display in a floating window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

packer.startup(function()
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim" -- Used by a lot of plugins
  use "neovim/nvim-lspconfig"
  -- use "Mofiqul/vscode.nvim"
  use "folke/tokyonight.nvim"
  use "folke/trouble.nvim"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use "nvim-tree/nvim-tree.lua"
  use "lewis6991/gitsigns.nvim"
  use "hoob3rt/lualine.nvim"
  use "akinsho/bufferline.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "moll/vim-bbye"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "ray-x/lsp_signature.nvim"
  use "tpope/vim-fugitive"
  use "mhartington/formatter.nvim"
  use "cespare/vim-toml"
  use "nvim-telescope/telescope.nvim"
  use {"nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "simrat39/rust-tools.nvim"
  use "rust-lang/rust.vim"
  use "akinsho/toggleterm.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "kylechui/nvim-surround"
  use {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    run = "cd app && npm install"
  }
  use "sumneko/lua-language-server"
  use "milisims/nvim-luaref"
  use "rhysd/git-messenger.vim"
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use "nvim-treesitter/playground"
  use "NoahTheDuke/vim-just"
  use "IndianBoy42/tree-sitter-just"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
