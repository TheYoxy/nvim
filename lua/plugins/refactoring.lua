--- @type LazySpec
return {
  "ThePrimeagen/refactoring.nvim",
  event = "User AstroFile",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local get_icon = require("astroui").get_icon
        return require("astrocore").extend_tbl(opts, {
          mappings = {
            n = {
              ["<Leader>r"] = { desc = get_icon("Refactoring", 1, true) .. "Refactor" },
              ["<Leader>rb"] = {
                function() require("refactoring").refactor "Extract Block" end,
                desc = "Extract Block",
              },
              ["<Leader>rp"] = {
                function() require("refactoring").debug.printf { below = false } end,
                desc = "Debug: Print Function",
              },
              ["<Leader>rc"] = {
                function() require("refactoring").debug.cleanup {} end,
                desc = "Debug: Clean Up",
              },
              ["<Leader>rbf"] = {
                function() require("refactoring").refactor "Extract Block To File" end,
                desc = "Extract Block To File",
              },
              ["<Leader>rr"] = {
                function() vim.lsp.buf.rename() end,
                desc = "Rename symbol",
              },
              ["<Leader>rd"] = {
                function() vim.lsp.buf.delete() end,
                desc = "Delete symbol",
              },
            },
            x = {
              ["<Leader>r"] = { desc = get_icon("Refactoring", 1, true) .. "Refactor" },
              ["<Leader>re"] = {
                function() require("refactoring").refactor "Extract Function" end,
                desc = "Extract Function",
              },
              ["<Leader>rf"] = {
                function() require("refactoring").refactor "Extract Function To File" end,
                desc = "Extract Function To File",
              },
              ["<Leader>rv"] = {
                function() require("refactoring").refactor "Extract Variable" end,
                desc = "Extract Variable",
              },
            },
            v = {
              ["<Leader>r"] = { desc = get_icon("Refactoring", 1, true) .. "Refactor" },
              ["<Leader>re"] = {
                function() require("refactoring").refactor "Extract Function" end,
                desc = "Extract Function",
              },
              ["<Leader>rf"] = {
                function() require("refactoring").refactor "Extract Function To File" end,
                desc = "Extract Function To File",
              },
              ["<Leader>rv"] = {
                function() require("refactoring").refactor "Extract Variable" end,
                desc = "Extract Variable",
              },
              ["<Leader>rb"] = {
                function() require("refactoring").refactor "Extract Block" end,
                desc = "Extract Block",
              },
              ["<Leader>rbf"] = {
                function() require("refactoring").refactor "Extract Block To File" end,
                desc = "Extract Block To File",
              },
              ["<Leader>rr"] = {
                function() require("refactoring").select_refactor({}) end,
                desc = "Select Refactor",
              },
              ["<Leader>rp"] = {
                function() require("refactoring").debug.printf { below = false } end,
                desc = "Debug: Print Function",
              },
              ["<Leader>rc"] = {
                function() require("refactoring").debug.cleanup {} end,
                desc = "Debug: Clean Up",
              },
            },
          },
        } --[[@as AstroCoreOpts]])
      end,
    },
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = {
        mappings = {
          n = {
            ["<Leader>rf"] = {
              function() vim.lsp.buf.format(require("astrolsp").format_opts) end,
              desc = "Format buffer",
              cond = "textDocument/formatting",
            },
            ["<Leader>rn"] = {
              desc = "Inline variable",
              function()
                vim.lsp.buf.code_action {
                  context = {
                    only = { "refactor.inline" },
                  },
                  apply = true,
                }
              end,
              cond = "textDocument/codeAction",
            },
            ["<Leader>ri"] = {
              desc = "Remove imports",
              function()
                -- Execute the "Remove Unused Imports" code action
                vim.lsp.buf.code_action {
                  context = {
                    only = { "source.organizeImports" },
                  },
                  apply = true,
                }
              end,
              cond = "textDocument/codeAction",
            },
          },
        },
      },
    },
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        icons = {
          Refactoring = "󰣪",
        },
      },
    },
  },
  opts = {},
}
