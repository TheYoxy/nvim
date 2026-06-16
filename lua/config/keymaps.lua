-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "x" }, "+", "<C-a>", { desc = "Increment number" })
vim.keymap.set({ "n", "x" }, "-", "<C-x>", { desc = "Decrement number" })

-- vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gjzz' : 'jzz'", { desc = "Down", expr = true, silent = true })
-- vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gjzz' : 'jzz'", { desc = "Down", expr = true, silent = true })
-- vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gkzz' : 'kzz'", { desc = "Up", expr = true, silent = true })
-- vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gkzz' : 'kzz'", { desc = "Up", expr = true, silent = true })
-- vim.keymap.set("n", "G", "'Gzz'", { expr = true, silent = true })
-- vim.keymap.set("n", "gg", "'ggzz'", { expr = true, silent = true })

if not vim.g.vscode then
  vim.keymap.set({ "n", "x" }, "<leader>c", function()
    Snacks.bufdelete()
  end, { desc = "Delete Buffer" })
  vim.keymap.set({ "n", "x" }, "<leader>bd", function()
    Snacks.bufdelete()
  end, { desc = "Delete Buffer" })
  vim.keymap.set({ "n", "x" }, "<leader>bc", function()
    Snacks.bufdelete.other()
  end, { desc = "Delete Other Buffers" })
end

vim.keymap.del("n", "<leader>l")
vim.keymap.set("n", "<leader>ln", function()
  require("sidekick.nes").update()
end, { desc = "Trigger NES" })

vim.keymap.set("n", "<Leader>pi", "<cmd>Lazy install<cr>", { desc = "Plugins Install" })
vim.keymap.set("n", "<Leader>ps", "<cmd>Lazy<cr>", { desc = "Plugins Status" })
vim.keymap.set("n", "<Leader>pS", "<cmd>Lazy sync<cr>", { desc = "Plugins Sync" })
vim.keymap.set("n", "<Leader>pu", "<cmd>Lazy check<cr>", { desc = "Plugins Check Updates" })
vim.keymap.set("n", "<Leader>pU", "<cmd>Lazy update<cr>", { desc = "Plugins Update" })
vim.keymap.set("n", "<Leader>si", "<cmd>lsp restart<cr>", { desc = "Restart lsp" })

-- source: https://github.com/ThePrimeagen/init.lua/blob/985892e6fecfb2f5682a17470ac39db7d21eb715/lua/theprimeagen/remap.lua
-- vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.del("n", "<C-j>")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.del("n", "<C-k>")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
-- vim.keymap.del("n", "<leader>k")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
-- vim.keymap.del("n", "<leader>j")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
vim.keymap.set("n", "<C-x>", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "<C-S-x>", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "<C-e>", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "<C-S-e>", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
--vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
--vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

if not vim.g.vscode then
  -- NOTE: this is defined in vscode.lua
  vim.keymap.set({ "n", "v" }, "<leader>rf", function()
    LazyVim.format({ force = true })
  end, { desc = "Format" })
end

vim.keymap.del({ "n", "v" }, "<leader>cf")
vim.keymap.del("n", "<leader>cd")
if not vim.g.vscode then
  vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  Snacks.toggle.zoom():map("<C-w>z")
end

vim.keymap.del("n", "<leader>fT")
vim.keymap.del("n", "<leader>ft")
