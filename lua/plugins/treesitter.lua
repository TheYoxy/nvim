if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances
-- Customize tree-sitter plugins

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-treesitter/nvim-treesitter-context",
        event = "User AstroFile",
        cmd = { "TSContextToggle" },
        dependencies = {
          "AstroNvim/astrocore",
          ---@type AstroCoreOpts
          opts = {
            mappings = {
              n = {
                ["<Leader>uT"] = {
                  "<cmd>TSContextToggle<CR>",
                  desc = "Toggle treesitter context",
                },
              },
            },
          },
        },
      },
      {
        "RRethy/nvim-treesitter-endwise",
        lazy = true,
      },
    },
    --- comment
    --- @param _ LazyPlugin
    --- @param opts TSConfig | table
    opts = function(_, opts)
      local ensure_installed = {
        "vim",
        "lua",
        "c_sharp",
        "typescript",
        "css",
        "gitignore",
        "json",
        "yaml",
        "dockerfile",
        "vim",
        "regex",
        "markdown",
        "markdown_inline",
      }

      if vim.fn.has "linux" then table.insert(ensure_installed, "hyprlang") end

      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, ensure_installed)
      opts.auto_install = vim.fn.executable "tree-sitter" == 1
      opts.matchup = { enable = true }
      opts.endwise = { enable = true }
      ---@type TSContextConfig
      opts.context = { enable = true, max_lines = 3 }
      opts.textobjects = {
        enable = true,
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Select full function" },
            ["if"] = { query = "@function.inner", desc = "Select inner function code" },

            ["av"] = { query = "@assignment.outer", desc = "Select full variable assignation" },
            ["iv"] = { query = "@assignment.inner", desc = "Select inner variable assignation" },

            ["ac"] = { query = "@class.outer", desc = "Select full class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner class code" },

            ["aP"] = { query = "@parameter.outer", desc = "Select all parameters" },
            ["iP"] = { query = "@parameter.inner", desc = "Select inner parts of parameters" },

            ["ar"] = { query = "@return.outer", desc = "Select all return statement" },
            ["ir"] = { query = "@return.inner", desc = "Select inner return statement" },
          },
        },
      }
    end,
  },
}
