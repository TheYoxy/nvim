---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.recipes.vscode" },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<leader>e"] = function() require("vscode-neovim").action "workbench.action.quickOpen" end,
          ["<leader>fw"] = function() require("vscode-neovim").action "workbench.action.quickTextSearch" end,
          ["<leader>rf"] = function() require("vscode-neovim").action "editor.action.formatDocument" end,
          ["<leader>rv"] = function()
            require("vscode-neovim").action(
              "editor.action.codeAction",
              { args = { kind = "refactor.extract.variable" } }
            )
          end,
          ["<leader>rn"] = function()
            require("vscode-neovim").action("editor.action.codeAction", { args = { kind = "refactor.inline" } })
          end,
          ["<leader>rm"] = function()
            require("vscode-neovim").action(
              "editor.action.codeAction",
              { args = { kind = "refactor.extract.function" } }
            )
          end,
        },
      },
    },
  },
}
