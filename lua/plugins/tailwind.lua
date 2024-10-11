---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.tailwindcss" },
  dependencies = {
    -- {
    --   "themaxmarchuk/tailwindcss-colors.nvim",
    -- },
    {
      "AstroNvim/astrolsp",
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
