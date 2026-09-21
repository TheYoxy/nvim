-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "x" }, "+", "<C-a>", { desc = "Increment number" })
vim.keymap.set({ "n", "x" }, "-", "<C-x>", { desc = "Decrement number" })
-- vim.keymap.set("n", "<leader>po", ":update<CR> :source<CR>", { desc = "Update and source" })

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

  vim.keymap.del("n", "<leader>l")
  vim.keymap.set("n", "<leader>ln", function()
    require("sidekick.nes").update()
  end, { desc = "Trigger NES" })
end

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

-- ============================================================================
-- Multicursor: Neovim 0.13 native, JetBrains (macOS) keymap
-- See :help multicursor and :help nvim_mcursor()
-- ============================================================================
if vim.fn.has("nvim-0.13") == 1 and not vim.g.vscode then
  local mc_ns = vim.api.nvim_create_namespace("nvim.multicursor")
  local needle_cache = {}
  local clone_anchor = {}

  local function mc_marks(buf)
    return vim.api.nvim_buf_get_extmarks(buf, mc_ns, 0, -1, {})
  end

  local function mc_visual()
    local m = vim.fn.mode(1)
    return m == "v" or m == "V" or m == "\22"
  end

  -- Text of the current Visual selection (empty unless it is on one line).
  local function mc_selection()
    if not mc_visual() then
      return ""
    end
    local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode(1) })
    local text = table.concat(lines, "\n")
    return text:find("\n", 1, true) and "" or text
  end

  -- Search needle: the Visual selection, else the word under the cursor.
  local function mc_needle(buf, fresh)
    if not fresh and needle_cache[buf] then
      return needle_cache[buf]
    end
    local text = mc_selection()
    if text == "" then
      text = vim.fn.expand("<cword>")
    end
    needle_cache[buf] = text
    return text
  end

  local function mc_matches(text)
    if text == "" then
      return {}
    end
    return vim.fn.matchbufline("%", [[\V]] .. vim.fn.escape(text, [[\]]), 1, "$")
  end

  local function mc_leave_visual()
    if mc_visual() then
      vim.cmd("normal! \27")
    end
  end

  -- Follow-mode on by default: motions replay at every caret. There is no
  -- option or API for this, so force it with "1q=" each time a caret is added.
  -- Caret-adding mappings must first turn it OFF ("2q="): the multicursor
  -- cascade replays queued atoms at every caret, and a mapping that leaves
  -- follow on is itself replayed, so the carets collapse instead of adding.
  local function mc_follow()
    vim.cmd("normal! 1q=")
  end

  local function mc_follow_off()
    vim.cmd("normal! 2q=")
  end

  -- Reference position: start of the Visual selection, else the cursor.
  local function mc_prepare()
    if mc_visual() then
      local a, b = vim.fn.getpos("v"), vim.fn.getpos(".")
      local ar, ac, br, bc = a[2], a[3] - 1, b[2], b[3] - 1
      if br < ar or (br == ar and bc < ac) then
        ar, ac, br, bc = br, bc, ar, ac
      end
      mc_leave_visual()
      vim.api.nvim_win_set_cursor(0, { ar, ac })
      return ar, ac
    end
    local cursor = vim.api.nvim_win_get_cursor(0)
    return cursor[1], cursor[2]
  end

  -- Ctrl+G: add a caret at the next occurrence, keeping the current one.
  local function mc_add_next()
    local buf = vim.api.nvim_get_current_buf()
    local text = mc_needle(buf, #mc_marks(buf) == 0)
    if text == "" then
      return
    end
    mc_follow_off()
    local row, col = mc_prepare()
    local found = mc_matches(text)
    if #found == 0 then
      return
    end
    local taken = { [row - 1 .. ":" .. col] = true }
    for _, m in ipairs(mc_marks(buf)) do
      taken[m[2] .. ":" .. m[3]] = true
    end
    vim.api.nvim_mcursor(buf, { row, col })
    local pick
    for _, m in ipairs(found) do
      if not taken[m.lnum - 1 .. ":" .. m.byteidx] then
        pick = pick or m
        if m.lnum > row or (m.lnum == row and m.byteidx > col) then
          pick = m
          break
        end
      end
    end
    if pick then
      vim.api.nvim_win_set_cursor(0, { pick.lnum, pick.byteidx })
    end
    mc_follow()
  end

  -- Cmd+Ctrl+G: add a caret at every occurrence.
  local function mc_add_all()
    local buf = vim.api.nvim_get_current_buf()
    local text = mc_needle(buf, true)
    if text == "" then
      return
    end
    mc_follow_off()
    local row, col = mc_prepare()
    vim.api.nvim_mcursor(buf, { row, col })
    for _, m in ipairs(mc_matches(text)) do
      vim.api.nvim_mcursor(buf, { m.lnum, m.byteidx })
    end
    vim.api.nvim_win_set_cursor(0, { row, col })
    mc_follow()
  end

  -- Ctrl+Shift+G: remove the caret added last.
  local function mc_deselect()
    local buf = vim.api.nvim_get_current_buf()
    local found = mc_marks(buf)
    if #found == 0 then
      return
    end
    mc_follow_off()
    local last = found[1]
    for _, m in ipairs(found) do
      if m[1] > last[1] then
        last = m
      end
    end
    vim.api.nvim_buf_del_extmark(buf, mc_ns, last[1])
    mc_follow()
  end

  local function mc_clear()
    local buf = vim.api.nvim_get_current_buf()
    needle_cache[buf] = nil
    clone_anchor[buf] = nil
    vim.api.nvim_buf_clear_namespace(buf, mc_ns, 0, -1)
  end

  -- Double Alt+Up/Down: clone the caret above/below.
  local function mc_clone(dir)
    local buf = vim.api.nvim_get_current_buf()
    mc_follow_off()
    local cursor = vim.api.nvim_win_get_cursor(0)
    if #mc_marks(buf) == 0 then
      clone_anchor[buf] = { cursor[1], cursor[2] }
    end
    local anchor = clone_anchor[buf] or { cursor[1], cursor[2] }
    local row = anchor[1] + dir
    if row < 1 or row > vim.api.nvim_buf_line_count(buf) then
      return
    end
    local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1] or ""
    local col = math.min(anchor[2], #line)
    vim.api.nvim_mcursor(buf, { row, col })
    clone_anchor[buf] = { row, col }
    mc_follow()
  end

  -- Alt+Shift+G: add a caret at the end of each selected line.
  local function mc_line_ends()
    if not mc_visual() then
      return
    end
    local a, b = vim.fn.getpos("v"), vim.fn.getpos(".")
    local first, last = math.min(a[2], b[2]), math.max(a[2], b[2])
    mc_follow_off()
    mc_leave_visual()
    local buf = vim.api.nvim_get_current_buf()
    for row = first, last do
      local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1] or ""
      vim.api.nvim_mcursor(buf, { row, #line })
    end
    mc_follow()
  end

  -- Toggle a caret at a (line, col) position without moving the primary.
  local function mc_toggle_at(line, col)
    local buf = vim.api.nvim_get_current_buf()
    mc_follow_off()
    for _, m in ipairs(mc_marks(buf)) do
      if m[2] == line - 1 and m[3] == col then
        vim.api.nvim_buf_del_extmark(buf, mc_ns, m[1])
        return
      end
    end
    vim.api.nvim_mcursor(buf, { line, col })
    mc_follow()
  end

  -- Alt+Shift+Click: add/remove a caret at the click position.
  vim.keymap.set("n", "<M-S-LeftMouse>", function()
    local p = vim.fn.getmousepos()
    if p.line > 0 then
      mc_toggle_at(p.line, math.max(p.column - 1, 0))
    end
  end, { desc = "Add/remove caret at mouse" })
  -- Cmd+Shift+8: toggle column (blockwise) selection.
  -- vim.keymap.set({ "n", "x" }, "<D-S-8>", "<C-v>", { desc = "Toggle column selection" })
  -- Double Alt+Up/Down: clone caret above/below.
  vim.keymap.set("n", "<M-S-Up>", function()
    mc_clone(-1)
  end, { desc = "Clone caret above" })
  vim.keymap.set("n", "<M-S-Down>", function()
    mc_clone(1)
  end, { desc = "Clone caret below" })
  -- Alt+Shift+G: add a caret at the end of each selected line.
  vim.keymap.set("x", "<M-S-g>", mc_line_ends, { desc = "Add caret to ends of selected lines" })
  -- Ctrl+G: add a caret at the next occurrence.
  vim.keymap.set({ "n", "x" }, "<C-g>", mc_add_next, { desc = "Add caret at next occurrence" })
  -- Ctrl+Shift+G: remove the last occurrence caret.
  vim.keymap.set({ "n", "x" }, "<C-S-g>", mc_deselect, { desc = "Remove last occurrence caret" })
  -- Cmd+Ctrl+G: add a caret at every occurrence.
  vim.keymap.set({ "n", "x" }, "<D-C-g>", mc_add_all, { desc = "Add caret at all occurrences" })
  -- Esc: remove extra carets, keeping the primary.
  vim.keymap.set("n", "<Esc>", function()
    if #mc_marks(vim.api.nvim_get_current_buf()) > 0 then
      mc_follow_off()
      mc_clear()
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    end
  end, { desc = "Remove extra carets" })

  -- Follow-mode has no option or API (the state is internal C: mc_following()).
  -- The keymaps above force it on with "1q=" whenever a caret is added, so they
  -- already behave like JetBrains. Native Q / 1Q still disable it. To re-arm it
  -- after every action instead, uncomment this hook. Trade-off: "q=" no longer
  -- stays off, and the action that re-arms it does not itself follow.
  -- vim.api.nvim_create_autocmd("CmdAtom", {
  --   callback = function(ev)
  --     if tostring(ev.data.lhs):match("%d*q=$") then
  --       return
  --     end
  --     if #mc_marks(vim.api.nvim_get_current_buf()) > 0 then
  --       vim.cmd("normal! 1q=")
  --     end
  --   end,
  -- })
end
