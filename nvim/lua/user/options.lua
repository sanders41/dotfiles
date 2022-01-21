local cmd = vim.cmd
local set = vim.opt

set.encoding = 'utf-8'
set.scrolloff = 2
set.sidescrolloff = 2
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.smartindent = true
set.wrap = false
set.mouse = 'a'
set.number = true
set.splitright = true
set.splitbelow = true
set.showmatch = true
set.colorcolumn = '100'
set.clipboard = 'unnamedplus'
set.swapfile = false
set.termguicolors = true
set.completeopt = { "menuone", "noselect" }
set.cursorline = true
cmd [[autocmd FileType py,rs setlocal shiftwidth=4 tabstop=4 softtabstop=4]]
cmd [[set iskeyword+=-]]  -- consider - words one word. i.e. one-word
cmd [[set iskeyword+=_]]  -- consider _ words one word. i.e. one_word

-- search settings
set.ignorecase = true
set.smartcase = true

-- show hidden characters
set.list = true
set.listchars:append({extends = '»', precedes = '«', trail = '•'})

vim.g.vscode_style = 'dark'
cmd[[colorscheme vscode]]

cmd [[autocmd TermOpen * setlocal nonumber norelativenumber]]

-- Rust
cmd [[let g:rustfmt_autosave = 1]]  -- run cargo fmt on save for Rust files
cmd [[let g:rustfmt_emit_files = 1]]
cmd [[let g:rustfmt_fail_silently = 0]]

-- Python
cmd(
  [[
    augroup FormatAutogroup
      autocmd!
      autocmd BufWritePost *.py FormatWrite
    augroup END
  ]],
  true
)
