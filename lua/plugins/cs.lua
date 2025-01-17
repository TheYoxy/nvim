if true then return {} end
--- @type LazySpec
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
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      --NOTE: Install csharp_ls only if non nix os
      if not os.getenv "NIX_PROFILE" ~= nil then
        -- safely extend the servers list
        opts.servers = opts.servers or {}
        vim.list_extend(opts.servers, {
          "csharp_ls",
          -- add more servers as needed...
        })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      if not os.getenv "NIX_PROFILE" ~= nil then --NOTE: Install csharp_ls only if non nix os
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "csharp_ls" })
      end
    end,
  },
  {
    "Decodetalkers/csharpls-extended-lsp.nvim",
    dependencies = {
      {
        "AstroNvim/astrolsp",
        opts = {
          config = {
            csharp_ls = {
              handlers = {
                ["textDocument/definition"] = function(...) require("csharpls_extended").handler(...) end,
                ["textDocument/typeDefinition"] = function(...) require("csharpls_extended").handler(...) end,
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
        require("astrocore").list_insert_unique(opts.ensure_installed, { "csharp-language-server", "netcoredbg" })
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
