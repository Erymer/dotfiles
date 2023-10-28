vim.g.mapleader = " "

vim.keymap.set("i", "cg", "<Esc>")
vim.keymap.set("v", "cg", "<Esc>")

-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>")

vim.keymap.set("n", "<leader>fs", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":confirm qall<CR>")

-- Yank from position until last character in line
vim.keymap.set("n", "y-", "yg_")
vim.keymap.set("n", "Y", "yg$")

-- Move things while in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in the same place when pressing "J" in normal mode
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "G", "Gzz")
-- vim.keymap.set("n", "H", "Hzz")
vim.keymap.set("n", "M", "Mzz")
-- vim.keymap.set("n", "L", "Lzz")
-- vim.keymap.set("n", "k", "kzz")
-- vim.keymap.set("n", "j", "jzz")
-- vim.keymap.set("n", "{", "{zz")
-- vim.keymap.set("n", "}", "}zz")

-- Paste over a word without losing it in register
vim.keymap.set("x", "<leader>p", "\"_dp")

-- Yank to system register
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Hover cursor over a word you want to replace and press leader s
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")


vim.keymap.set("n", "H", ":b#<CR>")
