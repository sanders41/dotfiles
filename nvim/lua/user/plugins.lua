local fn = vim.fn

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim", -- Used by a lot of plugins
  "neovim/nvim-lspconfig",
  "folke/tokyonight.nvim",
  "folke/trouble.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  "nvim-tree/nvim-tree.lua",
  "lewis6991/gitsigns.nvim",
  "hoob3rt/lualine.nvim",
  "akinsho/bufferline.nvim",
  "kyazdani42/nvim-web-devicons",
  "moll/vim-bbye",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "ray-x/lsp_signature.nvim",
  "tpope/vim-fugitive",
  "mhartington/formatter.nvim",
  "cespare/vim-toml",
  "nvim-telescope/telescope.nvim",
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  "simrat39/rust-tools.nvim",
  "rust-lang/rust.vim",
  "akinsho/toggleterm.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "kylechui/nvim-surround",
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && npm install"
  },
  "sumneko/lua-language-server",
  "milisims/nvim-luaref",
  "rhysd/git-messenger.vim",
  "sindrets/diffview.nvim",
  "nvim-treesitter/playground",
  "NoahTheDuke/vim-just",
  "IndianBoy42/tree-sitter-just",
  "jinh0/eyeliner.nvim",
})
