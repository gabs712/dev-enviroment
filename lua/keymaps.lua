vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Hide highlight' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Window left' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Window bottom' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Window top' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Window right' })

vim.keymap.set('n', '<Space>', '<Nop>')

-- Window resize
vim.keymap.set("n", "<C-Up>", '<cmd>vertical resize +5<cr>', { desc = 'Window vertical increase' })
vim.keymap.set("n", "<C-Down>", '<cmd>vertical resize -5<cr>', { desc = 'Window vertical decrease' })
vim.keymap.set("n", "<C-Right>", '<cmd>horizontal resize +2<cr>', { desc = 'Window horizontal increase' })
vim.keymap.set("n", "<C-Left>", '<cmd>horizontal resize -2<cr>', { desc = 'Window horizontal decrease' })

-- With strings, when using "a" on operator-pending or visual mode, not include extra whitespace
vim.keymap.set('o', "a'", "2i'")
vim.keymap.set('o', 'a"', "2i\"")
vim.keymap.set('o', 'a`', "2i`")
vim.keymap.set('x', "a'", "2i'")
vim.keymap.set('x', 'a"', "2i\"")
vim.keymap.set('x', 'a`', "2i`")

-- Move through wrap 
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
