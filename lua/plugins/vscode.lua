if not vim.g.vscode then return {} end -- NOTE: don't do anything in not vscode instances

---replace a key if it exists
---@param key any
---@param fn function
local function replace(key, fn)
  if key then
    key[1] = fn
  else
    key = fn
  end
end

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.recipes.vscode" },
  dependencies = {

    "AstroNvim/astrocore",
    opts = function(_, opts)
      local vscode = require "vscode-neovim"
      replace(opts.mappings.n["<leader>fw"], function() vscode.action "workbench.action.quickTextSearch" end)
      opts.mappings = {
        n = {
          j = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" },
          k = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" },

          -- utils
          ["+"] = "<c-a>",
          ["-"] = "<c-x>",

          -- folding
          za = function() vscode.action "editor.toggleFold" end,

          si = function() vscode.action "vscode-neovim.restart" end,
          gd = function() vscode.call "editor.action.revealDefinition" end,

          -- tmux like action to navigate
          ["<C-a> h"] = function() vscode.action "workbench.action.navigateLeft" end,
          ["<C-a> l"] = function() vscode.action "workbench.action.navigateRight" end,
          ["<C-a> k"] = function() vscode.action "workbench.action.navigateUp" end,
          ["<C-a> j"] = function() vscode.action "workbench.action.navigateDown" end,

          ["<leader>x"] = function() vscode.action "editor.action.marker.next" end,
          ["<leader>X"] = function() vscode.action "editor.action.marker.prev" end,

          ["<leader>:"] = function() vscode.action "workbench.action.showCommands" end,
          ["<leader>ff"] = function() vscode.action "workbench.action.quickOpen" end,
          ["<leader>fs"] = function() vscode.action "workbench.action.showAllSymbols" end,
          ["<leader>fw"] = function() vscode.action "workbench.action.quickTextSearch" end,
          ["<leader>rr"] = function() vscode.action "editor.action.rename" end,
          ["<leader>rf"] = function() vscode.action "editor.action.formatDocument" end,
          ["<leader>rv"] = function()
            vscode.action("editor.action.codeAction", { args = { kind = "refactor.extract.variable" } })
          end,
          ["<leader>rn"] = function()
            vscode.action("editor.action.codeAction", { args = { kind = "refactor.inline" } })
          end,
          ["<leader>rm"] = function()
            vscode.action("editor.action.codeAction", { args = { kind = "refactor.extract.function" } })
          end,
          ["<leader>gg"] = function() vscode.action "workbench.action.output.show.vscode.git.Git" end,
          ["<leader>ri"] = function() vscode.action "editor.action.organizeImports" end,
          ["<leader>lR"] = function() vscode.action "editor.action.goToReferences" end,
          ["<leader>lf"] = function() vscode.action "editor.action.formatDocument" end,
          ["<leader>t"] = function() vscode.action "workbench.action.terminal.focus" end,
          -- ["<leader>e"] = function() vscode.action "workbench.view.explorer" end,
          ["<leader>e"] = function() vscode.action "workbench.action.quickOpen" end,
          --
          -- tabs actions
          ["<leader>q"] = function() vscode.action "workbench.action.closeActiveEditor" end,
          ["<leader>c"] = function() vscode.action "workbench.action.closeActiveEditor" end,
          ["<leader>Q"] = function() vscode.action "workbench.action.reopenClosedEditor" end,
          ["<leader>bc"] = function() vscode.action "workbench.action.closeOtherEditors" end,

          ["<leader><leader>"] = function() vscode.action "workbench.action.previousEditor" end,
          ["<leader>o"] = function() vscode.action "workbench.view.explorer" end,
          ["<leader>wo"] = function() vscode.action "workbench.action.showNextWindowTab" end,
          ["<leader>wp"] = function() vscode.action "workbench.action.showPreviousWindowTab" end,
          ["<leader>ws"] = function() vscode.action "workbench.action.splitEditorLeft" end,
          ["<leader>wv"] = function() vscode.action "workbench.action.splitEditorDown" end,
          ["<leader>wf"] = function() vscode.action "workbench.action.toggleSidebarVisibility" end,

          ["<leader>la"] = function() vscode.action "editor.action.quickFix" end,

          ["<C-g>"] = function() vscode.action "editor.action.addSelectionToNextFindMatch" end,
          [",c"] = function() vscode.action "csdevkit.rebuildSolution" end,
          [",b"] = function() vscode.action "csdevkit.buildSolution" end,
        },
      }
      return opts
    end,
  },
}
