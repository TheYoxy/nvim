-- Last updated: 25/07/24
if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances

---@type LazySpec
return {
  -- CSharp support
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "c_sharp" })
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      -- NOTE: Csharpier is disbaled since i don't use the configuration from
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      --NOTE: Install csharp_ls only if non nix os
      if vim.fn.executable "omnisharp" == 1 then
        -- safely extend the servers list
        opts.servers = opts.servers or {}
        vim.list_extend(opts.servers, {
          "omnisharp",
          -- add more servers as needed...
        })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      if vim.fn.executable "omnisharp" == 0 then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "omnisharp" })
      end
    end,
  },
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    dependencies = {
      {
        "AstroNvim/astrolsp",
        opts = {
          config = {
            omnisharp = {
              handlers = {
                ["textDocument/definition"] = function(...) require("omnisharp_extended").definition_handler(...) end,
                ["textDocument/typeDefinition"] = function(...)
                  require("omnisharp_extended").type_definition_handler(...)
                end,
                ["textDocument/references"] = function(...) require("omnisharp_extended").references_handler(...) end,
                ["textDocument/implementation"] = function(...)
                  require("omnisharp_extended").implementation_handler(...)
                end,
              },
            },
          },
        },
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "coreclr" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "omnisharp", "netcoredbg" })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "Issafalcon/neotest-dotnet", config = function() end },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-dotnet"(require("astrocore").plugin_opts "neotest-dotnet"))
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "" },
      },
    },
  },
}
