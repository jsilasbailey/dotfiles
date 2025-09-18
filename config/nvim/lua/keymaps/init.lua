local map = vim.keymap.set

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Save with leader
map("n", "<leader>w", ":w<cr>", { silent = true })
-- Kill windows with leader
map("n", "<leader>q", ":q<cr>", { silent = true })
-- Save and kill windows with leader
map("n", "<leader>wq", ":wq<cr>", { silent = true })

-- Cursor remains in center of the screen when page jumping
map("n", "<C-d>", "<C-d>zz", { silent = true })
map("n", "<C-u>", "<C-u>zz", { silent = true })

-- Stay in indent mode
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

map("v", "p", '"_dP', { silent = true })

-- Move text up and down
map("n", "<A-j>", ":m .+1<CR>==", { silent = true })
map("n", "<A-k>", ":m .-2<CR>==", { silent = true })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- Windows
map("n", "<A-l>", "10<C-w><", { silent = true })
map("n", "<A-h>", "10<C-w>>", { silent = true })

-- Terminal --
-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true })
map("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true })
map("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true })
map("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true })
map("t", "<C-o>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Diagnostic keymaps
map("n", "[d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show [D]iagnostic messages" })
map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [D]iagnostic [Q]uickfix list" })
