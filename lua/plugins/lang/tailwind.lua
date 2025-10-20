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
          filetypes_include = { "markdown.mdx" },
          -- to fully override the default_config, change the below
          -- filetypes = {}
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          opts.filetypes = opts.filetypes or {}

          -- LazyVim.lsp.on_attach(function(_, buffer)
          --   if vim.bo[buffer].filetype == "css" then
          --     vim.schedule(function()
          --       require("tailwindcss-colors").buf_attach(buffer)
          --     end)
          --   end
          -- end, "tailwindcss")

          -- Add default filetypes
          vim.list_extend(opts.filetypes, vim.lsp.config.tailwindcss.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Additional settings for Phoenix projects
          opts.settings = {
            --- @type _.lspconfig.settings.tailwindcss.TailwindCSS
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
              lint = {
                cssConflict = "error",
              },
              classFunctions = {
                "cva",
                "cn",
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
