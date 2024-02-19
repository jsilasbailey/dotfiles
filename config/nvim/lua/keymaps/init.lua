local keymap = vim.keymap.set

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Save with leader
keymap("n", "<leader>w", ":w<cr>", { silent = true })
-- Kill windows with leader
keymap("n", "<leader>q", ":q<cr>", { silent = true })
-- Save and kill windows with leader
keymap("n", "<leader>wq", ":wq<cr>", { silent = true })

-- Cursor remains in center of the screen when page jumping
keymap("n", "<C-d>", "<C-d>zz", { silent = true })
keymap("n", "<C-u>", "<C-u>zz", { silent = true })

-- Stay in indent mode
keymap("v", "<", "<gv", { silent = true })
keymap("v", ">", ">gv", { silent = true })

keymap("v", "p", '"_dP', { silent = true })

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", { silent = true })
keymap("n", "<A-k>", ":m .-2<CR>==", { silent = true })
keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- Windows
keymap("n", "<A-l>", "10<C-w><", { silent = true })
keymap("n", "<A-h>", "10<C-w>>", { silent = true })


-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })
