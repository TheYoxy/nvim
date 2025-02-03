if vim.g.vscode then return {} end -- NOTE: don't do anything in vscode instances
---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.tailwindcss" },
  },
  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    event = "VeryLazy",
    dependencies = {
      "AstroNvim/astrolsp",
      optional = true,
      ---@type AstroLSPOpts
      opts = {
        -- customize language server configuration options passed to `lspconfig`
        ---@diagnostic disable: missing-fields
        config = {
          tailwindcss = {
            on_attach = function(_, bufnr)
              require("tailwindcss-colors").buf_attach(bufnr)
              for _, server in ipairs(vim.lsp.get_clients { bufnr, name = "cssls" }) do
                if server.name == "cssls" then vim.lsp.get_client_by_id(server.id).stop() end
              end
            end,
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
