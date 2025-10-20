--- @type LazySpec
return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    --- @module "lspconfig"
    --- @type lspconfig.Config
    opts = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = {
          virt_text_pos = "eol_right_align",
        },
        virtual_lines = {
          severity = vim.diagnostic.severity.ERROR,
          current_line = true,
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim.
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = true,
      },
      -- Enable this to enable the builtin LSP folding on Neovim.
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the folds.
      folds = {
        enabled = true,
      },
    },
  },
  -- cmdline tools and lsp servers
  {
    "mason-org/mason.nvim",
    optional = true,
    dependencies = {
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        cmd = {
          "MasonToolsInstall",
          "MasonToolsInstallSync",
          "MasonToolsUpdate",
          "MasonToolsUpdateSync",
          "MasonToolsClean",
        },
        enabled = false,
        keys = {
          {
            "<leader>pM",
            "<Cmd>MasonToolsUpdate<CR>",
            desc = "Mason update",
          },
        },
        opts_extend = { "ensure_installed" },
        opts = {
          ensure_installed = LazyVim.opts("mason-lspconfig.nvim").ensure_installed,
          integrations = { ["mason-lspconfig"] = false, ["mason-null-ls"] = false, ["mason-nvim-dap"] = false },
        },
      },
    },
    keys = {
      {
        "<leader>pm",
        function()
          require("mason.ui").open()
        end,
        desc = "Mason Installer",
      },
      {
        "<leader>pa",
        function()
          require("lazy").sync({ wait = true })
          if vim.fn.exists(":MasonToolsUpdate") > 0 then
            vim.cmd.MasonToolsUpdate()
          end
        end,
        desc = "Update Lazy and Mason",
      },
    },
  },
}
