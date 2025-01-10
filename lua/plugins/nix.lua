---@type LazySpec
return {
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "nil_ls" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      if vim.fn.executable "nil" == 1 then
        -- safely extend the servers list
        opts.servers = opts.servers or {}
        vim.list_extend(opts.servers, {
          "nil_ls",
          -- add more servers as needed...
        })
      end
    end,
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    --- @type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        nil_ls = {
          settings = {
            ["nil"] = {
              nix = {
                maxMemoryMB = 16384,
                flake = {
                  autoEvalInputs = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
