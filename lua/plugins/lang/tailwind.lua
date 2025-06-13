--- @type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "themaxmarchuk/tailwindcss-colors.nvim",
        event = "VeryLazy",
      },
    },
    ---@diagnostic disable missing-fields
    ---@type PluginLspOpts
    opts = {
      servers = {
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = {
            "javascriptreact",
            "javascript.jsx",
            "typescriptreact",
            "typescript.tsx",
            "astro",
          },
          -- to fully override the default_config, change the below
          -- filetypes = {}
        },
      },
      setup = {
        --- @param opts _.lspconfig.settings.tailwindcss.TailwindCSS
        tailwindcss = function(_, opts)
          local tw = LazyVim.lsp.get_raw_config("tailwindcss")
          opts.filetypes = opts.filetypes or {}
          opts.lint = vim.list_extend(opts.lint or {}, {
            cssConflict = "error",
          })
          opts.classFunctions = vim.list_extend(opts.classFunctions or {}, {
            "cva",
            "cn",
          })
          opts.experimental = opts.experimental or {}
          opts.experimental.classRegex = vim.list_extend(opts.experimental.classRegex or {}, {
            {
              "cva\\(([^)]*)\\)",
              "[\"'`]([^\"'`]*).*?[\"'`]",
            },
            {
              "cn\\(([^)]*)\\)",
              "[\"'`]([^\"'`]*).*?[\"'`]",
            },
          })

          LazyVim.lsp.on_attach(function(_, buffer)
            if vim.bo[buffer].filetype == "css" then
              vim.schedule(function()
                require("tailwindcss-colors").buf_attach(buffer)
              end)
            end
          end, "tailwindcss")

          -- Add default filetypes
          vim.list_extend(opts.filetypes, tw.default_config.filetypes)

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
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
    },
    opts = function(_, opts)
      -- original LazyVim kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
}
