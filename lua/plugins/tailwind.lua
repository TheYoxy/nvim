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
          validate = true,
          lint = {
            cssConflict = "error",
          },
          classFunctions = {
            "cva",
            "cn",
          },
          classAttributes = {
            "class",
            "className",
            "class:list",
            "classList",
            "ngClass",
          },
          includeLanguages = {
            eelixir = "html-eex",
            eruby = "erb",
            templ = "html",
            htmlangular = "html",
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
