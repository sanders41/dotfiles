local cmd = vim.cmd
local set = vim.opt

local function line_length()
  local length = os.getenv("LINELENGTH")

  if length then
    return length
  end

  return "100"
end

set.encoding = "utf-8"
set.scrolloff = 5
set.sidescrolloff = 2
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.smartindent = true
set.wrap = false
set.mouse = "a"
set.relativenumber = true
set.number = true  -- Show the actual number for the line we"re on
set.splitright = true
set.splitbelow = true
set.showmatch = true
set.colorcolumn = line_length()
set.clipboard = "unnamedplus"
set.swapfile = false
set.termguicolors = true
set.completeopt = { "menuone", "noselect" }
set.cursorline = true
cmd [[autocmd FileType py,rs setlocal shiftwidth=4 tabstop=4 softtabstop=4]]
cmd [[autocmd FileType go setlocal noexpandtab]]
cmd [[set iskeyword+=-]]  -- consider - words one word. i.e. one-word
cmd [[set iskeyword+=_]]  -- consider _ words one word. i.e. one_word

-- search settings
set.ignorecase = true
set.smartcase = true

-- show hidden characters
set.list = true
set.listchars = {eol = "↲"}
set.listchars:append({tab = "» ", extends = "»", precedes = "«", trail = "•"})

require("tokyonight").setup({
  style = "night",
  on_colors = function(colors)
    colors.comment = "#75788c"
  end,
  on_highlights = function(hl)
    -- Set unused code color
    hl.DiagnosticUnnecessary = { fg = "#75788c" }
    hl.LineNrAbove = { fg = "#75788c" }
    hl.LineNrBelow = { fg = "#75788c" }
  end,
})

cmd("colorscheme tokyonight-night")

cmd [[autocmd TermOpen * setlocal nonumber norelativenumber]]

set.shell = "zsh --login"
