-- NOTE: disabled
if false then
  return {
    {
      "neovim/nvim-lspconfig",
      ---@diagnostic disable missing-fields
      ---@type PluginLspOpts
      opts = {
        -- make sure mason installs the server
        servers = {
          tsgo = {
            enabled = false,
          },
        },
      },
    },
  }
end

--- @module "lspconfig"
--- @module "lspconfig.configs"
--- @module "lspconfig.configs.tailwindcss"
--- @type LazySpec
return {
  -- correctly setup lspconfig
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "tsgo" } },
  },
  {
    "neovim/nvim-lspconfig",
    ---@diagnostic disable missing-fields
    ---@type PluginLspOpts
    opts = {
      -- make sure mason installs the server
      servers = {
        vtsls = {
          enabled = false,
        },
        tsgo = {
          enabled = true,
          -- available on 190326: "quickfix", "source.organizeImports", "source.removeUnusedImports", "source.sortImports"
          keys = {
            {
              "gD",
              function()
                local win = vim.api.nvim_get_current_win()
                local params = vim.lsp.util.make_position_params(win, "utf-16")
                LazyVim.lsp.execute({
                  command = "typescript.goToSourceDefinition",
                  arguments = { params.textDocument.uri, params.position },
                  open = true,
                })
              end,
              desc = "Goto Source Definition",
            },
            {
              "gR",
              function()
                LazyVim.lsp.execute({
                  command = "typescript.findAllFileReferences",
                  arguments = { vim.uri_from_bufnr(0) },
                  open = true,
                })
              end,
              desc = "File References",
            },
            {
              "<leader>ri",
              LazyVim.lsp.action["source.removeUnusedImports"],
              desc = "Remove unused imports",
            },
            {
              "<leader>rI",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
            {
              "<leader>lo",
              LazyVim.lsp.action["source.addMissingImports"],
              desc = "Add missing imports",
            },
            {
              "<leader>lD",
              LazyVim.lsp.action["quickfix"],
              desc = "Fix all diagnostics",
            },
            {
              "<leader>rN",
              LazyVim.lsp.action["refactor.move.newFile"],
              desc = "Move to new file",
            },
            {
              "<leader>rV",
              function()
                LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
              end,
              desc = "Select TS workspace version",
            },
          },
        },
      },
      setup = {
        --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
        --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
        tsserver = function()
          -- disable tsserver
          return true
        end,
        ts_ls = function()
          -- disable tsserver
          return true
        end,
      },
    },
  },
}
