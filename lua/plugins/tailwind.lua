--- @module "lspconfig"
--- @module "lspconfig.configs"
--- @module "lspconfig.configs.tailwindcss"
--- @type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@diagnostic disable missing-fields
      ---@type PluginLspOpts
      servers = {
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
