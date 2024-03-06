local keymap = vim.keymap.set

-- Telescope key maps
local builtin = require 'telescope.builtin'
keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
keymap("n", "<leader>fh", "<cmd>Telescope find_files hidden=true<CR>", { desc = "Find files including hidden files" })
keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Search by Grep' })
keymap('n', '<leader>fk', builtin.keymaps, { desc = 'Search Keymaps' })
keymap('n', '<leader>fw', builtin.grep_string, { desc = 'Search current Word' })
keymap('n', '<leader>fd', builtin.diagnostics, { desc = 'Search Diagnostics' })
keymap('n', '<leader>fr', builtin.resume, { desc = 'Search Resume' })
keymap('n', '<leader>f.', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
keymap('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to the window on the left" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move down a window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move up a window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to the window in the right" })

-- Resize window with aarows
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down" })
keymap("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "Resize window left" })
keymap("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Resize window right" })

-- NvimTree
keymap("n", "<leader>t", ":NvimTreeToggle<CR>", { desc = "Toggle nvim tree" })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Move to tab on the right" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Move to the tab on the left" })

-- Close buffers
keymap("n", "<leader>q", ":Bdelete<CR>", { desc = "Close the current buffer" })  -- bbye close single buffer
keymap("n", "<leader><S-q>", ":%bd<CR>", { desc = "Close all buffers" })  -- close all buffers

-- Git
keymap("n", "<leader>gb", ":Git blame<CR>", { desc = "Show git blame" })

keymap ("n", "<leader><leader>w", ":w | source %<CR>", { desc = "Save and reload file" })
