--- @module "lspconfig"
--- @module "lspconfig.configs"
--- @module "lspconfig.configs.tailwindcss"
--- @type LazySpec
return {
  -- Add packages(linting, debug adapter)
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "css-lsp" } },
  },
  -- Add syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "css" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@diagnostic disable missing-fields
      ---@type PluginLspOpts
      servers = {
        cssls = {
          settings = {
            css = {
              validate = true,
              format = {
                enable = false,
              },
              lint = {
                emptyRules = "warning",
                unknownAtRules = "ignore",
                vendorPrefix = "ignore",
              },
            },
          },
          -- → css.lint.argumentsInColorFunction              default: "error"
          -- → css.lint.boxModel                              default: "ignore"
          -- → css.lint.compatibleVendorPrefixes              default: "ignore"
          -- → css.lint.duplicateProperties                   default: "ignore"
          -- → css.lint.emptyRules                            default: "warning"
          -- → css.lint.float                                 default: "ignore"
          -- → css.lint.fontFaceProperties                    default: "warning"
          -- → css.lint.hexColorLength                        default: "error"
          -- → css.lint.idSelector                            default: "ignore"
          -- → css.lint.ieHack                                default: "ignore"
          -- → css.lint.importStatement                       default: "ignore"
          -- → css.lint.important                             default: "ignore"
          -- → css.lint.propertyIgnoredDueToDisplay           default: "warning"
          -- → css.lint.universalSelector                     default: "ignore"
          -- → css.lint.unknownAtRules                        default: "warning"
          -- → css.lint.unknownProperties                     default: "warning"
          -- → css.lint.unknownVendorSpecificProperties       default: "ignore"
          -- → css.lint.validProperties                       default: []
          -- → css.lint.vendorPrefix                          default: "warning"
          -- → css.lint.zeroUnits                             default: "ignore"
        },
        tailwindcss = {

          -- additional settings for the server, e.g:
          -- tailwindCSS = { includeLanguages = { someLang = "html" } }
          -- can be addeded to the settings table and will be merged with
          -- this defaults for Phoenix projects
          settings = {
            tailwindCSS = {
              validate = true,
              lint = {
                cssConflict = "error",
                invalidApply = "error",
                invalidScreen = "error",
                invalidVariant = "error",
                invalidConfigPath = "error",
                invalidTailwindDirective = "error",
                recommendedVariantOrder = "warning",
              },
              classFunctions = {
                "cva",
                "cn",
              },
              includeLanguages = {
                eelixir = "html-eex",
                eruby = "erb",
                templ = "html",
                htmlangular = "html",
              },
            },
          },
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          require("snacks").util.lsp.on({
            name = "tailwindCSS",
          }, function(_, buffer)
            if vim.bo[buffer].filetype == "css" then
              vim.schedule(function()
                require("tailwindcss-colors").buf_attach(buffer)
              end)
            end
          end)
        end,
      },
    },
  },
}
