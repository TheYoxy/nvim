---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.rust" },
  dependencies = {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
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
