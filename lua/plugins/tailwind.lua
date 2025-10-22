--- @type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      --- @module "lspconfig"
      --- @module "lspconfig.configs"
      --- @module "lspconfig.configs.tailwindcss"
      --- @type _.lspconfig.settings.tailwindcss.TailwindCSS
      ---@diagnostic disable missing-fields
      ---@type PluginLspOpts
      servers = {
        tailwindcss = { enabled = false },
        tailwindCSS = {
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
        tailwindcss = function(_, _)
          -- Disable default tailwindcss setup
          return false
        end,
        tailwindCSS = function(_, opts)
          opts.filetypes = opts.filetypes or {}

          LazyVim.lsp.on_attach(function(_, buffer)
            if vim.bo[buffer].filetype == "css" then
              vim.schedule(function()
                require("tailwindcss-colors").buf_attach(buffer)
              end)
            end
          end, "tailwindCSS")

          -- Add default filetypes
          vim.list_extend(opts.filetypes, vim.lsp.config.tailwindcss.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Additional settings for Phoenix projects
          opts.settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
            },
          }

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
  },
}
