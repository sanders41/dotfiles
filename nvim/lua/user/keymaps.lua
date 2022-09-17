local opts = { silent = true }
local keymap = vim.keymap.set

-- Telescope key maps
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope find_files hidden=true<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize window with aarows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- NvimTree
keymap("n", "<leader>t", ":NvimTreeToggle<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<leader>q", ":Bdelete<CR>", opts)  -- bbye close single buffer
keymap("n", "<leader><S-q>", ":%bd<CR>", opts)  -- close all buffers

-- Git
keymap("n", "<leader>gb", ":Git blame<CR>", opts)

keymap ("n", "<leader><leader>w", ":w | source %<CR>", opts)
