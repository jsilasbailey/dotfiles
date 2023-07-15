-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Save with leader
keymap("n", "<leader>w", ":w<cr>", { silent = true })
-- Kill windows with leader
keymap("n", "<leader>q", ":q<cr>", { silent = true })
-- Save and kill windows with leader
keymap("n", "<leader>wq", ":wq<cr>", { silent = true })

-- Less keystrokes for window navigation
keymap("n", "<C-h>", "<C-w>h", { silent = true })
keymap("n", "<C-j>", "<C-w>j", { silent = true })
keymap("n", "<C-k>", "<C-w>k", { silent = true })
keymap("n", "<C-l>", "<C-w>l", { silent = true })

-- Cursor reamins in center of the screen when page jumping
keymap("n", "<C-d>", "<C-d>zz", { silent = true })
keymap("n", "<C-u>", "<C-u>zz", { silent = true })

-- Visual --

-- Stay in indent mode
keymap("v", "<", "<gv", { silent = true })
keymap("v", ">", ">gv", { silent = true })

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", { silent = true })
keymap("v", "<A-k>", ":m .-2<CR>==", { silent = true })
keymap("v", "p", '"_dP', { silent = true })

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", { silent = true })
keymap("x", "K", ":move '<-2<CR>gv-gv", { silent = true })
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", { silent = true })
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", { silent = true })

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })
