if not vim.g.vscode then
  return {}
end

local enabled = {
  "LazyVim",
  "dial.nvim",
  "flit.nvim",
  "lazy.nvim",
  "leap.nvim",
  "mini.ai",
  "mini.comment",
  "mini.move",
  "mini.pairs",
  "mini.surround",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  "snacks.nvim",
  "ts-comments.nvim",
  "vim-repeat",
  "yanky.nvim",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end
vim.g.snacks_animate = false

-- Add some vscode specific keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymapsDefaults",
  callback = function()
    --- @class NvimVscode
    --- @field action fun(action: string, opts?: { args?: any[], range: [number| number] | [number, string, number, string], restore_selection: boolean, callback: fun(err: string | nil, ret: any) })
    --- @field notify fun(message: string)
    --- @field call fun(action: string, args?: any[])
    local vscode = require("vscode")
    vim.notify = vscode.notify

    vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gjzz' : 'jzz'", { desc = "Down", expr = true, silent = true })
    vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gjzz' : 'jzz'", { desc = "Down", expr = true, silent = true })
    vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gkzz' : 'kzz'", { desc = "Up", expr = true, silent = true })
    vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gkzz' : 'kzz'", { desc = "Up", expr = true, silent = true })
    vim.keymap.set({ "n", "x" }, "G", "'Gzz'", { expr = true, silent = true })
    vim.keymap.set({ "n", "x" }, "gg", "'ggzz'", { expr = true, silent = true })

    -- VSCode-specific keymaps for search and navigation
    vim.keymap.set({ "n", "x" }, "<leader><space>", "<cmd>Find<cr>")
    vim.keymap.set({ "n", "x" }, "<leader>/", [[<cmd>lua require('vscode').action('workbench.action.findInFiles')<cr>]])
    vim.keymap.set({ "n", "x" }, "<leader>fs", function()
      vscode.action("workbench.action.gotoSymbol")
    end)

    -- Keep undo/redo lists in sync with VsCode
    vim.keymap.set({ "n" }, "u", function()
      vscode.call("undo")
      vscode.call("cancelSelection")
    end, { desc = "Undo" })
    vim.keymap.set({ "n" }, "<C-r>", function()
      vscode.call("redo")
      vscode.call("cancelSelection")
    end, { desc = "Redo" })

    -- Navigate VSCode tabs like lazyvim buffers
    -- Navigate VSCode tabs like lazyvim buffers
    vim.keymap.set({ "n", "x" }, "<S-h>", function()
      vscode.call("workbench.action.previousEditor")
    end)
    vim.keymap.set({ "n", "x" }, "<S-l>", function()
      vscode.call("workbench.action.nextEditor")
    end)

    -- vim.keymap.set({ "n" }, "<leader>", function() vscode.action "whichkey.show" end, { noremap = false, remap = true })
    -- vim.keymap.set({ "n", "x", "i" }, "<C-g>", function() vscode.action "editor.action.addSelectionToNextFindMatch" end)

    -- vim.keymap.set("n", "+", "<c-a>", { desc = "Increment number", noremap = true })
    -- vim.keymap.set("n", "-", "<c-x>", { desc = "Decrement number", noremap = true })

    -- vim.keymap.set("n", "za", function()
    --   vscode.action "editor.fold"
    -- end, { desc = "Toggle fold" })

    vim.keymap.set({ "n", "x" }, "<leader>si", function()
      vscode.action("vscode-neovim.restart")
    end, { desc = "Restart vscode" })

    vim.keymap.set({ "n", "x" }, "]d", function()
      vscode.action("editor.action.marker.next")
    end, { desc = "Next diagnostic" })
    vim.keymap.set({ "n", "x" }, "[d", function()
      vscode.action("editor.action.marker.prev")
    end, { desc = "Previous diagnostic" })
    vim.keymap.set({ "n", "x" }, "<leader>x", function()
      vscode.action("editor.action.marker.next")
    end, { desc = "Next diagnostic" })
    vim.keymap.set({ "n", "x" }, "<leader>X", function()
      vscode.action("editor.action.marker.prev")
    end, { desc = "Previous diagnostic" })

    vim.keymap.set({ "n", "x" }, "<leader>:", function()
      vscode.action("workbench.action.showCommands")
    end, { desc = "Show commands" })
    vim.keymap.set({ "n", "x" }, "<leader><leader>", function()
      vscode.action("workbench.action.quickOpen")
    end, { desc = "Quick open" })
    vim.keymap.set({ "n", "x" }, "<leader>ff", function()
      vscode.action("workbench.action.quickOpen")
    end, { desc = "Quick open" })
    vim.keymap.set({ "n", "x" }, "<leader>fs", function()
      vscode.action("workbench.action.showAllSymbols")
    end, { desc = "Show all symbols" })
    vim.keymap.set({ "n", "x" }, "<leader>fw", function()
      vscode.action("workbench.action.quickTextSearch")
    end, { desc = "Quick text search" })
    vim.keymap.set({ "n", "x" }, "<leader>rr", function()
      vscode.action("editor.action.rename")
    end, { desc = "Rename" })

    vim.keymap.set(
      { "n", "x" },
      "<leader>rf",
      [[<cmd>lua require('vscode').action('editor.action.formatDocument')<cr>]],
      { desc = "Format document" }
    )
    vim.keymap.set({ "n", "x" }, "<leader>rv", function()
      vscode.action("editor.action.codeAction", { args = { kind = "refactor.extract.local" } })
    end, { desc = "Refactor extract local" })
    vim.keymap.set({ "n", "x" }, "<leader>rn", function()
      vscode.action("editor.action.codeAction", { args = { kind = "refactor.inline" } })
    end, { desc = "Refactor inline" })
    vim.keymap.set({ "n", "x" }, "<leader>rm", function()
      vscode.action("editor.action.codeAction", { args = { kind = "refactor.extract.function" } })
    end, { desc = "Refactor extract function" })
    vim.keymap.set({ "n", "x" }, "<leader>ri", function()
      vscode.action("editor.action.organizeImports")
    end, { desc = "Organize imports" })
    -- vim.keymap.set({ "n", "x" }, "<leader>t", function()
    --   vscode.action("workbench.action.terminal.focus")
    -- end, { desc = "Focus terminal" })
    vim.keymap.set({ "n", "x" }, "<leader>e", function()
      vscode.action("workbench.view.explorer")
    end, { desc = "Explorer" })
    vim.keymap.set({ "n", "x" }, "<leader>fe", function()
      vscode.action("workbench.action.quickOpen")
    end, { desc = "Quick open" })

    vim.keymap.set({ "n", "x" }, "<leader>q", function()
      vscode.action("workbench.action.closeActiveEditor")
    end, { desc = "Close active editor" })
    vim.keymap.set({ "n", "x" }, "<leader>c", function()
      vscode.action("workbench.action.closeActiveEditor")
    end, { desc = "Close active editor" })
    vim.keymap.set({ "n", "x" }, "<leader>Q", function()
      vscode.action("workbench.action.reopenClosedEditor")
    end, { desc = "Reopen closed editor" })

    vim.keymap.set({ "n", "x" }, "<leader>bc", function()
      vscode.action("workbench.action.closeOtherEditors")
    end, { desc = "Close other editors" })

    vim.keymap.set({ "n", "x" }, "<leader>o", function()
      vscode.action("workbench.action.files.openFile")
    end, { desc = "Open file" })
    vim.keymap.set({ "n", "x" }, "<leader>wo", function()
      vscode.action("workbench.action.showNextWindowTab")
    end, { desc = "Show next window tab" })
    vim.keymap.set({ "n", "x" }, "<leader>wp", function()
      vscode.action("workbench.action.showPreviousWindowTab")
    end, { desc = "Show previous window tab" })
    vim.keymap.set({ "n", "x" }, "<leader>ws", function()
      vscode.action("workbench.action.splitEditorLeft")
    end, { desc = "Split editor left" })
    vim.keymap.set({ "n", "x" }, "<leader>wv", function()
      vscode.action("workbench.action.splitEditorDown")
    end, { desc = "Split editor down" })
    vim.keymap.set({ "n", "x" }, "<leader>wf", function()
      vscode.action("workbench.action.toggleSidebarVisibility")
    end, { desc = "Toggle sidebar visibility" })
    vim.keymap.set({ "n", "x" }, "[q", function()
      vscode.action("search.action.focusPreviousSearchResult")
    end, { desc = "Focus previous search result" })
    vim.keymap.set({ "n", "x" }, "]q", function()
      vscode.action("search.action.focusNextSearchResult")
    end, { desc = "Focus next search result" })

    vim.keymap.set({ "n", "x" }, ",a", function()
      vscode.action("workbench.action.showCommands")
    end, { desc = "Show commands" })

    --- NOTE: testing keymaps
    vim.keymap.set({ "n", "x" }, "<leader>ta", function()
      vscode.action("testing.debugAtCursor")
    end, { desc = "Toggle watch" })
    vim.keymap.set({ "n", "x" }, "<leader>tl", function()
      vscode.action("testing.showMostRecentOutput")
    end, { desc = "Run last tests" })
    vim.keymap.set({ "n", "x" }, "<leader>tt", function()
      vscode.action("testing.runCurrentFile")
    end, { desc = "Run this test" })
    vim.keymap.set({ "n", "x" }, "<leader>to", function()
      vscode.action("testing.toggleInlineTestOutput")
    end, { desc = "Run this test" })
    vim.keymap.set({ "n", "x" }, "<leader>tO", function()
      vscode.action("testing.showMostRecentOutput")
    end, { desc = "Toggle output panel" })
    vim.keymap.set({ "n", "x" }, "<leader>tr", function()
      vscode.action("testing.runAtCursor")
    end, { desc = "Run previous test command" })
    vim.keymap.set({ "n", "x" }, "<leader>tT", function()
      vscode.action("testing.runAll")
    end, { desc = "Run all tests" })
    vim.keymap.set({ "n", "x" }, "<leader>tw", function()
      vscode.action("testing.toggleContinuousRunForTest")
    end, { desc = "Toggle watch" })

    vim.keymap.set({ "n", "x" }, "K", function()
      vscode.action("editor.action.showHover")
    end, { desc = "Show hover" })
    vim.keymap.set({ "n", "x" }, "gI", function()
      vscode.action("editor.action.goToImplementation")
    end, { desc = "Go to implementation" })
    vim.keymap.set({ "n", "x" }, "gd", function()
      vscode.action("editor.action.revealDefinition")
    end, { desc = "Reveal definition" })
    vim.keymap.set({ "n", "x" }, "gD", function()
      vscode.action("editor.action.revealDeclaration")
    end, { desc = "Reveal declaration" })
    vim.keymap.set({ "n", "x" }, "gr", function()
      vscode.action("references-view.findReferences")
    end, { desc = "Find references" })
    vim.keymap.set({ "n", "x" }, "gy", function()
      vscode.action("editor.action.goToTypeDefinition")
    end, { desc = "Go to type definition" })
    vim.keymap.set({ "n", "v" }, "<leader>la", function()
      vscode.action("editor.action.quickFix")
    end, { desc = "Quick fix" })
    vim.keymap.set({ "n", "x" }, "<leader>lG", function()
      vscode.action("workbench.action.showAllSymbols")
    end, { desc = "Show all symbols" })
    vim.keymap.set({ "n", "x" }, "<leader>lR", function()
      vscode.action("editor.action.goToReferences")
    end, { desc = "Go to references" })
    vim.keymap.set({ "n", "x" }, "<leader>lr", function()
      vscode.action("editor.action.rename")
    end, { desc = "Rename" })
    vim.keymap.set({ "n", "x" }, "<leader>ls", function()
      vscode.action("workbench.action.gotoSymbol")
    end, { desc = "Go to symbol" })
    vim.keymap.set({ "n", "x" }, "<leader>lf", function()
      -- vscode.action("eslint.executeAutofix")
      vscode.action("oxc.applyAllFixesFile")
    end, { desc = "Format document" })
    vim.keymap.set({ "n", "x" }, "<C-g>", function()
      vscode.action("editor.action.addSelectionToNextFindMatch")
    end, { desc = "Add selection to next find match" })

    -- vim.keymap.set("n", ",c", function()
    --   local languageId = vscode.eval("return vscode.window.activeTextEditor.document.languageId")
    --   if languageId == "csharp" then
    --     vscode.action("csdevkit.rebuildSolution")
    --   else
    --     vim.notify("no build action for this language")
    --   end
    -- end, { desc = "Rebuild solution" })
    -- vim.keymap.set("n", ",b", function()
    --   local languageId = vscode.eval("return vscode.window.activeTextEditor.document.languageId")
    --   if languageId == "csharp" then
    --     vscode.action("csdevkit.buildSolution")
    --   else
    --     vim.notify("no build action for this language")
    --   end
    -- end, { desc = "Build solution" })

    vim.keymap.set("n", ",r", function()
      vscode.action("workbench.action.debug.start")
    end, { desc = "Start debugging" })

    vim.keymap.set({ "n" }, ",t", function()
      vscode.action("test-explorer.run-this-test")
    end, { desc = "Run this test" })

    vim.keymap.set({ "n", "i", "v", "x" }, "<C-i>", function()
      vscode.action("inlineChat.start")
    end, { desc = "Start inline chat" })

    -- vim.keymap.set("n", "<leader>gg", function()
    --   vscode.action("lazygit-vscode.toggle")
    -- end, { desc = "Toggle lazygit" })

    local addSelection = function()
      vscode.action("editor.action.addSelectionToNextFindMatch")
    end

    --- NOTE: multi-cursor keymaps
    vim.keymap.set({ "n", "x" }, "<C-g>", function()
      addSelection()
    end, {
      desc = "Add selection to next find match",
    })

    vim.keymap.set({ "i", "x" }, "<C-g>", function()
      vscode.with_insert(addSelection)
    end, {
      desc = "Add selection to next find match",
    })
  end,
})

function LazyVim.terminal()
  --- @class NvimVscode
  --- @field action fun(action: string, opts?: { args?: any[], range: [number| number] | [number, string, number, string], restore_selection: boolean, callback: fun(err: string | nil, ret: any) })
  --- @field notify fun(message: string)
  local vscode = require("vscode-neovim")
  vscode.action("workbench.action.terminal.toggleTerminal")
end

return {
  {
    "snacks.nvim",
    opts = {
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      picker = { enabled = false },
      quickfile = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
    },
  },
  {
    "LazyVim/LazyVim",
    config = function(_, opts)
      opts = opts or {}
      -- disable the colorscheme
      opts.colorscheme = function() end
      require("lazyvim").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}
