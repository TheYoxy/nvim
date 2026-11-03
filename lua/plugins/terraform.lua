--- @module "lspconfig"
--- @type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "terraform", "hcl" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@diagnostic disable missing-fields
      ---@type PluginLspOpts
      servers = {
        tofu_ls = {},
      },
    },
  },
  -- ensure terraform tools are installed
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "tofu-ls", "tflint" } },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    --- @module "null-ls"
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.packer,
        null_ls.builtins.formatting.terraform_fmt,
        null_ls.builtins.diagnostics.terraform_validate,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      -- The builtin runs `terraform validate`, which cannot resolve the
      -- registry.opentofu.org providers this repo locks; same check via tofu.
      require("lint").linters.tofu_validate = function()
        local linter = require("lint").linters.terraform_validate()
        linter.cmd = "tofu"
        linter.source = "tofu validate"
        return linter
      end

      opts.linters_by_ft = {
        terraform = { "tofu_validate" },
        tf = { "tofu_validate" },
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        hcl = { "tfmt" },
        terraform = { "tfmt" },
        tf = { "tfmt" },
        ["terraform-vars"] = { "tfmt" },
      },
      formatters = {
        tfmt = {
          command = "tofu",
          args = { "fmt", "-" },
          stdin = true,
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    specs = {
      {
        "ANGkeith/telescope-terraform-doc.nvim",
        ft = { "terraform", "hcl" },
        config = function()
          LazyVim.on_load("telescope.nvim", function()
            require("telescope").load_extension("terraform_doc")
          end)
        end,
      },
      {
        "cappyzawa/telescope-terraform.nvim",
        ft = { "terraform", "hcl" },
        config = function()
          LazyVim.on_load("telescope.nvim", function()
            require("telescope").load_extension("terraform")
          end)
        end,
      },
    },
  },
}
