local map = vim.keymap.set

vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })
vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "move end of line" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "move up" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
vim.keymap.set("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

vim.keymap.set("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
vim.keymap.set("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
vim.keymap.set("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

vim.keymap.set({ "n", "x" }, "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- global lsp mappings
vim.keymap.set("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- tabufline
if require("nvconfig").ui.tabufline.enabled then
  vim.keymap.set("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

  vim.keymap.set("n", "<tab>", function()
    require("nvchad.tabufline").next()
  end, { desc = "buffer goto next" })

  vim.keymap.set("n", "<S-tab>", function()
    require("nvchad.tabufline").prev()
  end, { desc = "buffer goto prev" })

  vim.keymap.set("n", "<leader>x", function()
    require("nvchad.tabufline").close_buffer()
  end, { desc = "buffer close" })
end

-- Comment
vim.keymap.set("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
vim.keymap.set("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
vim.keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
vim.keymap.set("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
vim.keymap.set("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
vim.keymap.set("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

vim.keymap.set("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
vim.keymap.set(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- terminal
vim.keymap.set("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- whichkey
vim.keymap.set("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

vim.keymap.set("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

vim.keymap.set("n", "<leader>po", ":update<CR> :source<CR>", { desc = "Update and source" })

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

--if not vim.g.vscode then
--  vim.keymap.set({ "n", "x" }, "<leader>c", function()
--    Snacks.bufdelete()
--  end, { desc = "Delete Buffer" })
--  vim.keymap.set({ "n", "x" }, "<leader>bd", function()
--    Snacks.bufdelete()
--  end, { desc = "Delete Buffer" })
--  vim.keymap.set({ "n", "x" }, "<leader>bc", function()
--    Snacks.bufdelete.other()
--  end, { desc = "Delete Other Buffers" })
--
--  vim.keymap.del("n", "<leader>l")
--  vim.keymap.set("n", "<leader>ln", function()
--    require("sidekick.nes").update()
--  end, { desc = "Trigger NES" })
--end

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
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
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

-- if not vim.g.vscode then
--   -- NOTE: this is defined in vscode.lua
--   vim.keymap.set({ "n", "v" }, "<leader>rf", function()
--     LazyVim.format({ force = true })
--   end, { desc = "Format" })
-- end


if not vim.g.vscode then
  vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  -- Snacks.toggle.zoom():map("<C-w>z")
end
