-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })

vim.keymap.set("n", "<leader>c", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

vim.keymap.set("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bc", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

vim.keymap.del("n", "<leader>l")
vim.keymap.set("n", "<Leader>pi", "<cmd>Lazy install<cr>", { desc = "Plugins Install" })
vim.keymap.set("n", "<Leader>ps", "<cmd>Lazy<cr>", { desc = "Plugins Status" })
vim.keymap.set("n", "<Leader>pS", "<cmd>Lazy sync<cr>", { desc = "Plugins Sync" })
vim.keymap.set("n", "<Leader>pu", "<cmd>Lazy check<cr>", { desc = "Plugins Check Updates" })
vim.keymap.set("n", "<Leader>pU", "<cmd>Lazy update<cr>", { desc = "Plugins Update" })

vim.keymap.del({ "n", "v" }, "<leader>cf")
vim.keymap.set({ "n", "v" }, "<leader>rf", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

vim.keymap.del("n", "<leader>cd")
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
