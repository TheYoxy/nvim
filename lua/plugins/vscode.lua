if not vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances

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
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.recipes.vscode" },
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      replace(
        opts.mappings.n["<leader>fw"],
        function() require("vscode-neovim").action "workbench.action.quickTextSearch" end
      )
      opts.mappings = {
        n = {
          ["<leader>e"] = function() require("vscode-neovim").action "workbench.action.quickOpen" end,
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
      }
      return opts
    end,
  },
}
