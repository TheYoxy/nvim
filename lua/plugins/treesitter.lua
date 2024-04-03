-- Customize tree-sitter plugins

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
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


    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed,ensure_installed)
      opts.futo_install = vim.fn.executable "tree-sitter" == 1
      opts.matchup = { enable = true }
      opts.ensure_installed = ensure_installed
    opts.textobjects = {
        enable = true,
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aP"] = "@parameter.outer",
            ["iP"] = "@parameter.inner",
          },
        },
      }


    opts.context = {
        enable = true,
      }
  end,
}
