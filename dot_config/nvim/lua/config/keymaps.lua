-- move lines
vim.keymap.set("n", "<a-j>", "<cmd>m .+1<cr>==", { desc = "move down" })
vim.keymap.set("n", "<a-k>", "<cmd>m .-2<cr>==", { desc = "move up" })
vim.keymap.set("i", "<a-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "move down" })
vim.keymap.set("i", "<a-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "move up" })
vim.keymap.set("v", "<a-j>", ":m '>+1<cr>gv=gv", { desc = "move down" })
vim.keymap.set("v", "<a-k>", ":m '<-2<cr>gv=gv", { desc = "move up" })
