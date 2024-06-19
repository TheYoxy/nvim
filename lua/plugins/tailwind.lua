---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.tailwindcss" },
  },
  {
    "themaxmarchuk/tailwindcss-colors.nvim",
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      handlers = {
        tailwindcss = function(_, opts) require("tailwindcss-colors").setup(opts) end,
      },
      -- customize language server configuration options passed to `lspconfig`
      ---@diagnostic disable: missing-fields
      config = {
        tailwindcss = {
          on_attach = function(client, bufnr) require("tailwindcss-colors").buf_attach(client, bufnr) end,
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
}
