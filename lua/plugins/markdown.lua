--- @type LazySpec
--- @module "conform"
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["markdown"] = { "oxfmt", "prettier", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "oxfmt", "prettier", "markdownlint-cli2", "markdown-toc" },
      },
    },
  },
}
