if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances
---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.tailwindcss" },
  dependencies = {
    "themaxmarchuk/tailwindcss-colors.nvim",
    dependencies = {
      "AstroNvim/astrolsp",
      optional = true,
      ---@type AstroLSPOpts
      opts = {
        -- customize language server configuration options passed to `lspconfig`
        ---@diagnostic disable: missing-fields
        config = {
          tailwindcss = {
            on_attach = function(_, bufnr) require("tailwindcss-colors").buf_attach(bufnr) end,
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    {
                      "twc\\.[^`]+`([^`]*)`",
                      "twc\\(.*?\\).*?`([^`]*)",
                      {
                        "twc\\.[^`]+\\(([^)]*)\\)",
                        "(?:'|\"|`)([^']*)(?:'|\"|`)",
                      },
                      {
                        "twc\\(.*?\\).*?\\(([^)]*)\\)",
                        "(?:'|\"|`)([^']*)(?:'|\"|`)",
                      },
                      {
                        "cva\\(([^)]*)\\)",
                        "[\"'`]([^\"'`]*).*?[\"'`]",
                      },
                      {
                        "cx\\(([^)]*)\\)",
                        "(?:'|\"|`)([^']*)(?:'|\"|`)",
                      },
                      {
                        "cn\\(([^)]*)\\)",
                        "[\"'`]([^\"'`]*).*?[\"'`]",
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
