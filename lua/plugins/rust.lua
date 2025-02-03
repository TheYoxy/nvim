if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances
---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.rust" },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      formatting = {
        format_on_save = {
          allow_filetypes = {
            "rust",
          },
        },
      },
      -- customize language server configuration options passed to `lspconfig`
      ---@diagnostic disable: missing-fields
      config = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              files = {
                excludeDirs = { ".git", "target", ".direnv", "result" },
              },
              inlayHints = {
                -- maxLength = nil,
                lifetimeElisionHints = {
                  useParameterNames = true,
                  enable = "skip_trivial",
                },
                closureReturnTypeHints = {
                  enable = "always",
                },
              },
            },
          },
        },
      },
    },
  },
}
